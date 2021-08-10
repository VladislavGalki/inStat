//
//  NetworkServiceError.swift
//  inStat
//
//  Created by Владислав Галкин on 09.08.2021.
//

import Foundation

enum NetworkServiceError: Error {
    case networkError
    case decodableError
    case unknownError
}
