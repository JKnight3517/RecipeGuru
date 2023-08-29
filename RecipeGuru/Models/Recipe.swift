//
//  Recipe.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import Foundation



struct Recipe: Codable {
    
    let id: Int
    let title: String
    let imageUrl: String

    
    enum CodingKeys: String, CodingKey {
        case id, title
        case imageUrl = "image"
    }
}
    
