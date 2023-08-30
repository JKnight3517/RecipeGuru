//
//  RecipeInstructrions.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/30/23.
//

import Foundation



struct RecipeInstructions: Codable {
    let name : String
    let steps: [RecipeStep]
}

struct RecipeStep: Codable {
    let number: Int
    let step: String
}


let testRecipeSteps = [RecipeStep(number: 1, step: "Preheat the over to 200 degrees F."),
                       RecipeStep(number: 2, step: "Whisk together the flour, pecans, granulated sugar, light brown sugar, baking powder, baking soda, and salt in a medium bowl."),
                       RecipeStep(number: 3, step: "Whisk together the eggs, buttermilk, butter and vanilla extract and vanilla bean in a small bowl.")]

let testRecipeInstrcutions = RecipeInstructions(name: "Pasta", steps: testRecipeSteps)

let noDataRecipeInstructions = RecipeInstructions(name: "No Instructions Found", steps: [])
