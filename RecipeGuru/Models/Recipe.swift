//
//  Recipe.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import Foundation



struct Recipe: Codable, Identifiable {
    
    let id: Int
    let title: String
    let imageUrl: String

    
    enum CodingKeys: String, CodingKey {
        case id, title
        case imageUrl = "image"
    }
    
    

}

let testRecipes: [Recipe] = [
    Recipe(id: 716429,
           title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs",
           imageUrl: "https://spoonacular.com/recipeImages/716429-312x231.jpg"),
Recipe(id: 715538,
       title: "What to make for dinner tonight?? Bruschetta Style Pork & Pasta",
       imageUrl: "https://spoonacular.com/recipeImages/715538-312x231.jpg")]
let testRecipe: Recipe = Recipe(id: 716429,
           title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs",
           imageUrl: "https://spoonacular.com/recipeImages/716429-312x231.jpg")


let noDataRecipe = Recipe(id: -1, title: "No recipe found", imageUrl: "")
    

