//
//  RecipeDetailView.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @State var recipeDetail = testRecipeDetailResponse
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("Past Dish")
                    .padding(.leading, 20)
                Image("recipe_placeholder")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()
                HStack {
                    Text(" Cooking Time: 45 Minutes")
                        .font(.body)
                        .padding(.leading, 15)
                    Spacer()
                    Text("Servings: 3")
                        .padding(.trailing, 20)
                    
                }
                Divider()
                HStack {
                    Text("Ingredients")
                        .padding(.leading, 20)
                        .font(.title)
                    Spacer()
                }
                VStack(alignment: .leading) {
                    ForEach(recipeDetail.extendedIngredients) { ingredient in
                        Text(ingredient.origianl)
                    }
                }
                    
                
                
          
               
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView()
    }
}
