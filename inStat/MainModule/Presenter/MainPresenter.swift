//
//  MainPresenter.swift
//  inStat
//
//  Created by Владислав Галкин on 10.08.2021.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func succes()
    func failure(error: NetworkServiceError)
}

protocol MainPresenterProtocol: AnyObject {
    func showMatchInfo()
    var matchModel: [MatchModel] { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol
    var matchModel = [MatchModel]()
    private var streamUrls = [String]()
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func showMatchInfo() {
        networkService.getMatchInfo { [weak self] response in
            guard let self = self else { return }
            self.process(response: response)
        }
    }
    
    private func process(response: GetMatchAPIResponse){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.parseData(data: data)
                self.view?.succes()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    private func parseData(data: GetMatchResponse) {
        let group = DispatchGroup()
        group.enter()
        networkService.getStreamIdByMatchId(id: data.tournament.id) { [weak self] response in
            guard let self = self else { return }
            self.streamUrls = response.map {$0.url}
            group.leave()
        }
        
        group.wait()
        print(self.streamUrls.count)
        let formateDate = convertDateFormat(inputDate: data.date)
        
        self.matchModel = [MatchModel(teamName: data.tournament.nameRus, firstTeamName: Team(name: data.team1.nameRus, score: data.team1.score), secondTeamName: Team(name: data.team2.nameRus, score: data.team2.score), dateTournament: formateDate, score: data.team1.score, url: self.streamUrls)]
    }
}
