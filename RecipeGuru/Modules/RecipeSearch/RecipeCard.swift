//
//  RecipeCard.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import SwiftUI

struct RecipeCard: View {
    @Binding var recipe: Recipe
    var body: some View {
        ZStack(alignment: .bottomLeading) {

                Image("recipe_placeholder")
                        .resizable()
                        .scaledToFit()
                Text(recipe.title)
                        .font(.custom("Georgia", size: 20, relativeTo: .title))
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .shadow(radius: 5)
                
            
        }
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard(recipe: .constant(testRecipe))
    }
}
