//
//  RecipeSearchResponse.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import Foundation


//TODO: Try with no results

struct RecipeSearchResponse: Decodable {
    let offset: Int
    let number: Int
    let results: [Recipe]
    let totalResults: Int
}
