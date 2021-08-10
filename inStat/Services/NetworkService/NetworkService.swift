//
//  NetworkService.swift
//  inStat
//
//  Created by Владислав Галкин on 09.08.2021.
//

import Foundation

final class NetworkService {
    private let session: URLSession = .shared
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        return encoder
    }()
    
}

extension NetworkService: NetworkServiceProtocol {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    func getMatchInfo(completion: @escaping (GetMatchAPIResponse) -> Void) {
        
        let components = URLComponents(string: ApiConstant.APIMethods.getMatchInfo)
        guard let url = components?.url else { completion(.failure(.unknownError)); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Сontent-Type")
        
        let source = RequestBodyMatchInfo(proc: "get_match_info", params: ["_p_sport" : 1, "_p_match_id" : 1724836])
        
        guard let body = try? encoder.encode(source) else { return }
        
        request.httpBody = body
        
        let handler: Handler = { rawData, response, taskError in
            do {
                let data = try self.httpResponse(data: rawData, response: response)
                let response = self.decodeJson(type: GetMatchResponse.self, from: data)
                if let response = response {
                    completion(.success(response))
                }
            } catch let error as NetworkServiceError {
                completion(.failure(error))
            } catch {
                completion(.failure(.unknownError))
            }
        }
        session.dataTask(with: request, completionHandler: handler).resume()
    }
    
    func getStreamIdByMatchId(id: Int, completion: @escaping (GetStreamAPIResponse) -> Void) {
        
        let components = URLComponents(string: ApiConstant.APIMethods.getStreamId)
        guard let url = components?.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Сontent-Type")
        
        let source = RequestBodyStreamUrl(match_id: id)
        
        guard let body = try? encoder.encode(source) else { return }
        
        request.httpBody = body
        
        let handler: Handler = { rawData, response, taskError in
            do {
                let data = try self.httpResponse(data: rawData, response: response)
                let response = self.decodeJson(type: [GetStreamResponse].self, from: data)
                if let response = response {
                    completion(response)
                }
            } catch {
                print(error)
            }
        }
        session.dataTask(with: request, completionHandler: handler).resume()
    }
    
    private func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let data = data else {
            throw NetworkServiceError.networkError
        }
        return data
    }
    
    private func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let result = try decoder.decode(type.self, from: data)
            return result
        } catch {
            print("Ошибка парсинга")
        }
        return nil
    }
}
