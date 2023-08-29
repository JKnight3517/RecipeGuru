//
//  ApiService.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import Foundation
import Combine

public class APIService {

    
    private let baseUrl = "https://api.spoonacular.com/recipes/complexSearch"
    
    private let apiKeySuffix = "?apiKey=b0f00832a4f64ccf828ee1ddd5da2693"
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadRecipes(searchString: String) -> AnyPublisher<[Recipe], Error> {
        let urlString = baseUrl + "/query=\(searchString)" + apiKeySuffix
         guard let url = URL(string: urlString) else {
             
             //TODO: Error Handling
            print("Bad URL")
             return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
         }
        return load(url: url)
    }
    
    
    
    private func load <T:Decodable>(url: URL) -> AnyPublisher<T,Error> {
        // Maybe take in string and try to make a url here instead -> Could be efficient
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw  URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
