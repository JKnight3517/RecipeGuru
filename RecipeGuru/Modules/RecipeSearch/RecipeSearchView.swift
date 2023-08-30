//
//  ContentView.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import SwiftUI

struct RecipeSearchView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel = RecipeSearchViewModel()
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            NavigationView {
                List($viewModel.recipes) { recipe in
                    RecipeCard(recipe: recipe).background(
                        NavigationLink("", destination: RecipeDetailView(viewModel: RecipeDetailViewModel(viewContext: viewContext, recipeId: recipe.id)))
                            .opacity(0.0)
                    )
                    
                }
                .scrollContentBackground(.hidden)
                .searchable(text: $searchText, prompt: "Search for recipes") {
                    if viewModel.recipes.isEmpty {
                        Text(searchText.isEmpty ? "Use the search bar to look for recipes" : "No Recipes Found")
                    }
                }
                .onSubmit(of: .search) {
                    viewModel.searchForRecipes(searchString: searchText)
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
