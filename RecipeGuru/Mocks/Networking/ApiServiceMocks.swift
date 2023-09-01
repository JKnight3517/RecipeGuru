//
//  ApiServiceMocks.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/31/23.
//

import Foundation
import Combine

//TODO: Use in API Tests

class APIServiceSuccessMock: APIService {
    var fetchRecipeSearchResult: AnyPublisher<RecipeSearchResponse, Error>?
    var fetchRecipeDetailResult: AnyPublisher<RecipeDetail, Error>?
    var fetchRecipeInstructionsResult: AnyPublisher<RecipeInstructions,Error>?
    
    override func loadRecipeSearchResults(endpoint: Endpoint) -> AnyPublisher<RecipeSearchResponse, Error> {
        if let result = fetchRecipeSearchResult {
            return result
        } else {
            return Fail(error: APIService.APIError.custom(error: "Failed to provide search publisher")).eraseToAnyPublisher()
        }
    }
    
    override func loadRecipeDetail(endpoint: Endpoint) -> AnyPublisher<RecipeDetail, Error> {
        if let result = fetchRecipeDetailResult {
            return result
        } else {
            return Fail(error: APIService.APIError.custom(error: "Failed to provide details publisher")).eraseToAnyPublisher()
        }
    }
    
    override func loadRecipeInstructions(endpoint: Endpoint) -> AnyPublisher<RecipeInstructions, Error> {
        if let result = fetchRecipeInstructionsResult {
            return result
        } else {
            return Fail(error: APIService.APIError.custom(error: "Failed to provide instructions publisher")).eraseToAnyPublisher()
        }
    }
    
    
    
}
