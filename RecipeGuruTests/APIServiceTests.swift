//
//  APIServiceTests.swift
//  RecipeGuruTests
//
//  Created by Justin Knight on 8/31/23.
//

import XCTest
import Combine
@testable import RecipeGuru

// TODO: Finish writing API Tests
final class APIServiceTests: XCTestCase {

    var mockApiService: APIServiceSuccessMock!
    var recipeSearchSut: RecipeSearchViewModel!
    var recipeDetailSut: RecipeDetailViewModel!
    
    override func setUp() {
        super.setUp()
        mockApiService = APIServiceSuccessMock()
        recipeSearchSut  = RecipeSearchViewModel(api: mockApiService, viewContext: PersistenceController.shared.container.viewContext)
        
    }
    
    
    
    func test_recipe_search_success() {
        
    }
    
    func test_recipe_details_success() {
        
    }
    
    func test_recipe_instructions_success() {
        
    }

        

}
