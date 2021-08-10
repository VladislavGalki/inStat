//
//  RequestBodyGenerate.swift
//  inStat
//
//  Created by Владислав Галкин on 10.08.2021.
//

import Foundation

struct RequestBodyMatchInfo: Encodable {
    let proc: String
    let params: [String: Int]
}

struct RequestBodyStreamUrl: Encodable {
    let match_id: Int
    let sport_id: Int = 1
}
