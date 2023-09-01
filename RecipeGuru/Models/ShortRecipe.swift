//
//  Recipe.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import Foundation



struct ShortRecipe: Codable, Identifiable {
    
    let id: Int
    let title: String
    let imageUrl: String
    let imageData: Data? = nil

    
    enum CodingKeys: String, CodingKey {
        case id, title
        case imageUrl = "image"
    }
    
    

}

let testShortRecipes: [ShortRecipe] = [
    ShortRecipe(id: 716429,
           title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs",
           imageUrl: "https://spoonacular.com/recipeImages/716429-312x231.jpg"),
ShortRecipe(id: 715538,
       title: "What to make for dinner tonight?? Bruschetta Style Pork & Pasta",
       imageUrl: "https://spoonacular.com/recipeImages/715538-312x231.jpg")]
let testRecipe: ShortRecipe = ShortRecipe(id: 716429,
           title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs",
           imageUrl: "https://spoonacular.com/recipeImages/716429-312x231.jpg")


let noDataRecipe = ShortRecipe(id: -1, title: "No recipe found", imageUrl: "")
    

