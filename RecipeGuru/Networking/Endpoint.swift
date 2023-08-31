//
//  Endpoint.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/31/23.
//

import Foundation




enum Endpoint {
    case search(search: String, offset: Int)
    case detail(id: Int)
    case instructions(id: Int)
}

extension Endpoint {
    
    
    var host: String { "api.spoonacular.com" }
    
    var path: String {
        switch self {
        case .search:
            return "/recipes/complexSearch"
        case .detail(let id):
            return "/recipes/\(id)/information"
        case .instructions(let id):
            return "/recipes/\(id)/analyzedInstructions"
        }
    }
    
    
    var queryItems: [String : String] {
        var queryItems: [String : String] = ["apiKey":"b0f00832a4f64ccf828ee1ddd5da2693"]
        
        switch self {
        case .search(let searchString, let offset):
            queryItems["query"] = searchString
            queryItems["offset"] = String(offset)
            queryItems["number"] = "10"
            return queryItems
        case .detail, .instructions:
            return queryItems
            
        }

    }
}


extension Endpoint {
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems = [URLQueryItem]()
        
        queryItems.forEach { item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        
        
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}
