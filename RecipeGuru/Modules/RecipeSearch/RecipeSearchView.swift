//
//  ContentView.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import SwiftUI

struct RecipeSearchView: View {
    
    @ObservedObject var viewModel = RecipeSearchViewModel()
    
    var body: some View {
        VStack {
            NavigationStack{
                List($viewModel.recipes) { recipe in
                    
                    NavigationLink(destination: RecipeDetailView(recipeId: recipe.id)) {
                        RecipeCard(recipe: recipe)
                    }
                    
                }
                .padding()
                .onAppear {
                    viewModel.searchForRecipes(searchString: "pasta")
                }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearchView(viewModel: MockRecipeSearchViewModel())
    }
}
