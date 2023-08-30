//
//  RecipeSummary.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/30/23.
//

import Foundation



struct RecipeSummary {
    let id: Int
    let title: String
    let imageUrl: String
    let readyInMinutes: Int
    let servings: Int
    let isFavorite: Bool
    let instructions: [String]
    let ingredients: [String]
}

let testRecipeSummary = RecipeSummary(id: 1,
                                      title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs",
                                      imageUrl: "https://spoonacular.com/recipeImages/716429-556x370.jpg",
                                      readyInMinutes: 40,
                                      servings: 0,
                                      isFavorite: false,
                                      instructions: [
                                      "1. Preheat the Oven to 200 degrees",
                                      "2. Whisk together the dry ingredients in a medium bowl",
                                      "3. Whisk together wet ingreidents in a small bowl and then combine with dry ingredients"
                                      ],
                                      ingredients: ["1 tbsp butter",
                                                    "2 Cups Water",
                                                    "1 Cup White Whine",
                                                    "about 2 cups frozen cauliflower florets, thawed, cut into bite-sized pieces"])




