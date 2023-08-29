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
            List(viewModel.recipes) { recipe in
                HStack {
                    Text("\(recipe.id)")
                    Spacer()
                    Text("\(recipe.title)")
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.searchForRecipes(searchString: "pasta")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearchView(viewModel: MockRecipeSearchViewModel())
    }
}
