//
//  ApiService.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import Foundation
import Combine

 class APIService {
    
    private var cancellables = Set<AnyCancellable>()
    
    
   
    //MARK: Generic Load Data Function
    
      func load <T:Decodable>(endpoint: Endpoint, type: T.Type) -> AnyPublisher<T,Error> {
        
         
         guard let url = endpoint.url else {
             return Fail(error: APIError.invalidUrl).eraseToAnyPublisher()
         }
        
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw APIError.invalidStatusCode
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension APIService {
    enum APIError: LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode
        case invalidData
        case failedToDecode(error: Error)
        
        
        
        var errorDescription: String? {
            switch self {
            case .invalidUrl:
                return "URL isn't valid"
            case .invalidStatusCode:
                return "Bad Server Response Code"
            case .invalidData:
                return "Response data is invalid"
            case .failedToDecode:
                return "Failed to decode"
            case .custom(let error):
                return "Something went wrong \(error.localizedDescription)"
            }
        }
    }
}


