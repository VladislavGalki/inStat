//
//  GetMatchResponse.swift
//  inStat
//
//  Created by Владислав Галкин on 09.08.2021.
//

import Foundation

struct GetMatchResponse: Decodable {
    let tournament: Tournament
    let date: String
    let team1: TeamOne
    let team2: TeamTwo
    let calc: Bool
    let hasVideo: Bool
    let live: Bool
    let storage: Bool
    let sub: Bool
    let access: Bool
    
    enum CodingKeys: String, CodingKey {
        case tournament
        case date
        case team1
        case team2
        case calc
        case hasVideo = "has_video"
        case live
        case storage
        case sub
        case access
    }
}

struct Tournament: Decodable {
    let id:Int
    let nameEng: String
    let nameRus: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case nameEng = "name_eng"
        case nameRus = "name_rus"
    }
}

struct TeamOne: Decodable {
    let id: Int
    let nameEng: String
    let nameRus: String
    let score: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case nameEng = "name_eng"
        case nameRus = "name_rus"
        case score
    }
}

struct TeamTwo: Decodable {
    let id: Int
    let nameEng: String
    let nameRus: String
    let score: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case nameEng = "name_eng"
        case nameRus = "name_rus"
        case score
    }
}
