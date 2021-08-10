//
//  MatchModel.swift
//  inStat
//
//  Created by Владислав Галкин on 10.08.2021.
//

import Foundation

struct MatchModel {
    let teamName: String
    let firstTeamName: Team
    let secondTeamName: Team
    let dateTournament: String
    let score: Int
    let url: [String]
}

struct Team {
    let name: String
    let score: Int
}


