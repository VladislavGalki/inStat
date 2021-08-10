//
//  GetStreamResponse.swift
//  inStat
//
//  Created by Владислав Галкин on 10.08.2021.
//

import Foundation

struct GetStreamResponse: Decodable {
    let name: String
    let matchId: Int
    let period: Int
    let serverId: Int
    let quality: String
    let folder: String
    let videoType: String
    let abc: String
    let startMs: Int
    let checksum: Int
    let size: Int
    let abcType: String
    let duration: Int
    let fps: Double
    let urlRoot: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case matchId = "match_id"
        case period
        case serverId = "server_id"
        case quality
        case folder
        case videoType = "video_type"
        case abc
        case startMs = "start_ms"
        case checksum
        case size
        case abcType = "abc_type"
        case duration
        case fps
        case urlRoot = "url_root"
        case url
    }
}
