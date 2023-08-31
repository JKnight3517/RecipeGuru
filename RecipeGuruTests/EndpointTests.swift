//
//  EndpointTests.swift
//  RecipeGuruTests
//
//  Created by Justin Knight on 8/31/23.
//

import XCTest
@testable import RecipeGuru

final class EndpointTests: XCTestCase {
    private let expectedHost = "api.spoonacular.com"
    private let baseQueryItem = ["apiKey":"b0f00832a4f64ccf828ee1ddd5da2693"]
 
    func test_search_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.search(search: "chicken", offset: 0)
        
        XCTAssertEqual(endpoint.host, expectedHost, "The host should be api.spoonacular.com")
        XCTAssertEqual(endpoint.path, "/recipes/complexSearch", "The path should be /recipes/complexSearch")
        XCTAssertEqual(endpoint.queryItems,
                       ["query":"chicken",
                        "offset" : "0",
                        "number": "10",
                        "apiKey": "b0f00832a4f64ccf828ee1ddd5da2693"],
                       "The query items should be query:chicken, offSet : 0, number: 10, apiKey: b0f00832a4f64ccf828ee1ddd5da2693")
    }
    
    func test_recipe_detail_endpoint_request_is_valid() {
       
        let id = 1
        let endpoint = Endpoint.detail(id: id)
        
        XCTAssertEqual(endpoint.host, expectedHost, "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/recipes/\(id)/information", "The path should be /recipes/\(id)/information")
       
        XCTAssertEqual(endpoint.queryItems,
                      baseQueryItem,
                       "The query items should be apiKey: b0f00832a4f64ccf828ee1ddd5da2693")
    
        XCTAssertEqual(endpoint.url?.absoluteString,
                       "https://api.spoonacular.com/recipes/\(id)/information?apiKey=b0f00832a4f64ccf828ee1ddd5da2693",
                       "The generated url doesn't match expected endpoint")

    }
    
    func test_recipe_instructions_endpoint_request_is_valid() {
        let id = 1
        let endpoint = Endpoint.instructions(id: id)
        XCTAssertEqual(endpoint.host, expectedHost, "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/recipes/\(id)/analyzedInstructions", "The path should be /recipes/\(id)/analyzedInstructions")

        XCTAssertEqual(endpoint.queryItems,
                      baseQueryItem,
                       "The query items should be apiKey: b0f00832a4f64ccf828ee1ddd5da2693")

        XCTAssertEqual(endpoint.url?.absoluteString,
                       "https://api.spoonacular.com/recipes/\(id)/analyzedInstructions?apiKey=b0f00832a4f64ccf828ee1ddd5da2693",
                       "The generated url doesn't match expected endpoint")


    }
                                       
                                       

}
