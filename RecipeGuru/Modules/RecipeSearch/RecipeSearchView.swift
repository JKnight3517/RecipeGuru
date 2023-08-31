//
//  ContentView.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import SwiftUI

struct RecipeSearchView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel = RecipeSearchViewModel(viewContext: PersistenceController.shared.container.viewContext)
    @State private var searchText = ""
    
    var body: some View {
        TabView {
            VStack {
                NavigationView {
                    List {
                        ForEach($viewModel.recipes) { recipe in
                            RecipeCard(recipe: recipe).background(
                                NavigationLink("", destination: RecipeDetailView(viewModel: RecipeDetailViewModel(viewContext: viewContext, recipeId: recipe.id)))
                                    .opacity(0.0)
                            )
                        }

                        
                        if viewModel.allRecipesLoaded == false {
                                        ProgressView()
                                        .onAppear {
                                            viewModel.searchForRecipes(searchString: searchText)
                                        }
                                    }
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
            }.tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            VStack {
                NavigationView {
                    if viewModel.savedRecipes.count > 0 {
                        List($viewModel.savedRecipes) { recipe in
                            RecipeCard(recipe: recipe).background(
                                NavigationLink("", destination: RecipeDetailView(viewModel: RecipeDetailViewModel(viewContext: viewContext, recipeId: recipe.id)))
                                    .opacity(0.0)
                            )
                            
                        }
                        .scrollContentBackground(.hidden)
                    } else {
                        Text("No recipes marked as favorite")
                    }
                }
            }.tabItem {
                Label("Favorites", systemImage: "star")
            }.onAppear() {
                viewModel.fetchFavoritedRecipes()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearchView(viewModel: MockRecipeSearchViewModel( viewContext: PersistenceController.shared.container.viewContext))
    }
}
