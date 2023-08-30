//
//  RecipeDetailResponse.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import Foundation



struct RecipeDetail: Decodable {
    var id: Int
    var title: String
    var image: String
    var servings: Int
    var readyInMinutes: Int
    var extendedIngredients: [Ingredient]
}



struct Ingredient: Decodable, Identifiable {
    let id: Int
    let name: String
    let origianl: String // example: 3 Scallions, chopped white and green parts seperated
}
    
let testIngredients = [Ingredient(id: 1001,
                                  name: "butter",
                                  origianl:  "1 tbsp butter"),
                       Ingredient(id: 10011135,
                                  name: "cauliflower florets",
                                  origianl: "about 2 cups frozen cauliflower florets, thawed, cut into bite-sized pieces")]

let testRecipeDetailResponse = RecipeDetail(id: 716429, title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs", image: "https://spoonacular.com/recipeImages/716429-556x370.jpg", servings: 4, readyInMinutes: 40, extendedIngredients: testIngredients)

