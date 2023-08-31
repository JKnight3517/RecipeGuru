//
//  ApiService.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import Foundation
import Combine

 class APIService {
 
    private let baseUrl = "https://api.spoonacular.com/recipes/"
    
    private let apiKeyComponent = "apiKey=b0f00832a4f64ccf828ee1ddd5da2693"
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Load Recipes
    
     func loadRecipes(searchString: String, offset: Int, numberOfRecipes: Int = 10) -> AnyPublisher<RecipeSearchResponse, Error> {
        let urlString = baseUrl + "complexSearch?query=\(searchString)&offset=\(offset)&number=\(numberOfRecipes)" + "&" + apiKeyComponent
        print(urlString)
         guard let url = URL(string: urlString) else {
             
             //TODO: Error Handling
            print("Bad URL")
             return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
         }
        return load(url: url)
    }
    
    
    //MARK: Load Recipe Details
    func loadRecipeDetails(id: Int) -> AnyPublisher<RecipeDetail, Error> {
        let urlString = baseUrl + "\(id)/information" + "?" + apiKeyComponent
        print(urlString)
        guard let url = URL(string: urlString) else {

            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return load(url: url)
    }
    
    
    //MARK: Load Recipe InStructions

    func loadRecipeInstructions(id: Int) -> AnyPublisher<[RecipeInstructions], Error> {
        let urlString = baseUrl + "\(id)/analyzedInstructions" + "?" + apiKeyComponent
        print(urlString)
        guard let url = URL(string: urlString) else {
            
            //TODO: Error Handling
            print("Bad URL")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return load(url: url)
    }
    
    //MARK: Generic Load Data Function
    
    private func load <T:Decodable>(url: URL) -> AnyPublisher<T,Error> {
        // Maybe take in string and try to make a url here instead -> Could be efficient
        //TODO: Add better error handling around URL errors/decoding errors
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


