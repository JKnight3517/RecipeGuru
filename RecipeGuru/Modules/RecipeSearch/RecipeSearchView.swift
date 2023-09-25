//
//  ContentView.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import SwiftUI
import ComposableArchitecture

struct RecipeSearchView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel = RecipeSearchViewModel(viewContext: PersistenceController.shared.container.viewContext)
    @State private var searchText = ""
    
    var body: some View {
        TabView {
            //MARK: Search Tab
            VStack {
                NavigationView {
                    List {
                        ForEach($viewModel.recipes) { recipe in
                            RecipeCard(recipe: recipe).background(
                                NavigationLink("", destination:RecipeDetailView(
                                    viewModel: RecipeDetailViewModel(viewContext: viewContext,
                                                                     recipeId: recipe.id),
                                    store: Store.init(initialState: RecipeDetail.State()) {
                                        RecipeDetail()._printChanges()
                                    }))
                                .opacity(0.0)
                            ) .listRowSeparator(.hidden)
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
            
            //MARK: Favorites Tab
            VStack(alignment: .center) {
                NavigationView {
                    
                    if viewModel.savedRecipes.count > 0 {
                        List {
                            Section("Favorites") {
                                ForEach($viewModel.savedRecipes) { recipe in
                                    RecipeCard(recipe: recipe).background(
                                        NavigationLink("", destination: RecipeDetailView(viewModel: RecipeDetailViewModel(viewContext: viewContext, recipeId: recipe.id), store: Store.init(initialState: RecipeDetail.State()) {
                                            RecipeDetail()._printChanges()
                                        }))
                                            .opacity(0.0)
                                    ).listRowSeparator(.hidden)
                                }
                            }.headerProminence(.increased)
                        }
                        .scrollContentBackground(.hidden)
                    } else {
                        Text("No recipes marked as favorite")
                    }
                }
            }
            .tabItem {
                Label("Favorites", systemImage: "star")
            }
            .onAppear() {
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
