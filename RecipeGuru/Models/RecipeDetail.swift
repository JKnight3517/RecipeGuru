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
    let original: String // example: 3 Scallions, chopped white and green parts seperated
}
    
let testIngredients = [Ingredient(id: 1001,
                                  name: "butter",
                                  original:  "1 tbsp butter"),
                       Ingredient(id: 10011135,
                                  name: "cauliflower florets",
                                  original: "about 2 cups frozen cauliflower florets, thawed, cut into bite-sized pieces")]

let testRecipeDetailResponse = RecipeDetail(id: 716429, title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs", image: "https://spoonacular.com/recipeImages/716429-556x370.jpg", servings: 4, readyInMinutes: 40, extendedIngredients: testIngredients)


let noRecipeDetailResponse = RecipeDetail(id: -999, title: "No Recipe Information Found", image: "", servings: 0, readyInMinutes: 0, extendedIngredients: [])

