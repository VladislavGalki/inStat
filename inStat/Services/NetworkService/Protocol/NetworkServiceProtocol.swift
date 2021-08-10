//
//  NetworkServiceProtocol.swift
//  inStat
//
//  Created by Владислав Галкин on 09.08.2021.
//

import Foundation

typealias GetMatchAPIResponse = Result<GetMatchResponse, NetworkServiceError>
typealias GetStreamAPIResponse = [GetStreamResponse]

protocol NetworkServiceProtocol {
    func getMatchInfo(completion: @escaping (GetMatchAPIResponse) -> Void)
    func getStreamIdByMatchId(id: Int, completion: @escaping (GetStreamAPIResponse) -> Void)
}
