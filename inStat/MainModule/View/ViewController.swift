//
//  ViewController.swift
//  inStat
//
//  Created by Владислав Галкин on 09.08.2021.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var presenter: MainPresenterProtocol!
    
    let tournamentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.showMatchInfo()
        configure()
    }
    
    func configure() {
        view.addSubview(tournamentLabel)
        view.addSubview(teamNameLabel)
        view.addSubview(scoreLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            tournamentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tournamentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            teamNameLabel.topAnchor.constraint(equalTo: tournamentLabel.bottomAnchor, constant: 10),
            teamNameLabel.leadingAnchor.constraint(equalTo: tournamentLabel.leadingAnchor),
            scoreLabel.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor, constant: 10),
            scoreLabel.leadingAnchor.constraint(equalTo: teamNameLabel.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: scoreLabel.leadingAnchor),
            stackView.widthAnchor.constraint(equalTo: tournamentLabel.widthAnchor)
        ])
    }
    
    @objc func didTapButton(_ button : UIButton) {
        let urlString = presenter.matchModel[0].url[button.tag]
        let videoURL = URL(string: urlString)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.navigationController?.present(playerViewController, animated: true, completion: {
            playerViewController.player?.play()
        })
    }
}

extension ViewController: MainViewProtocol {
    func succes() {
        let model = presenter.matchModel[0]
        tournamentLabel.text = model.teamName + " " + model.dateTournament
        teamNameLabel.text = model.firstTeamName.name + " vs " + model.secondTeamName.name
        scoreLabel.text = "\(model.firstTeamName.score) : \(model.secondTeamName.score)"
        
        configureStackView(urls: model.url)
    }
    
    func failure(error: NetworkServiceError) {
    }
    
    private func configureStackView(urls: [String]) {
        for (index, _) in urls.enumerated() {
            stackView.addArrangedSubview(makeButtonWithTag(tag: index))
        }
    }
    
    private func makeButtonWithTag(tag: Int) -> UIButton {
        let myButton = UIButton(type: .system)
        myButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        myButton.backgroundColor = .blue
        myButton.setTitle("play", for: .normal)
        myButton.setTitleColor(.white, for: .normal)
        myButton.tag = tag
        myButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        return myButton
    }
}

