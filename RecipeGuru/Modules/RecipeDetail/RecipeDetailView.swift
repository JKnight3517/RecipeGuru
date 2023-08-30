//
//  RecipeDetailView.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    init(viewModel: RecipeDetailViewModel) {
        self.viewModel = viewModel
    }
    
  
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text(viewModel.recipeDetails.title)
                    .padding(.leading, 20)
                    .multilineTextAlignment(.center)
                Image("recipe_placeholder")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()
                HStack {
                    Text("Cooking Time: \(viewModel.recipeDetails.readyInMinutes) minutes")
                        .font(.body)
                        .padding(.leading, 15)
                    Spacer()
                    Text("Servings: \(viewModel.recipeDetails.servings)")
                        .padding(.trailing, 20)
                    
                }
                Divider()
                LazyVStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.title)
                    Spacer().frame(height: 15)
                    ForEach(viewModel.recipeDetails.extendedIngredients) { ingredient in
                        Text("- " + ingredient.original)
                    }
                    Divider()
                    Text("Recipe")
                        .font(.title)
                    Spacer().frame(height: 15)
                    ForEach(viewModel.recipeInstructions.steps, id: \.number) { step in
                        Text("\(step.number). \(step.step)")
                    }
                    
                    
                    
                }
                .padding([.leading, .trailing], 15)
            }.onAppear{
                viewModel.getRecipeDetails()
                viewModel.getRecipeInstructions()
            }
        }.navigationTitle("Recipe Details")
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(viewModel: MockRecipeDetailViewModel(recipeId: 1))
    }
}
