//
//  RecipeCard.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import SwiftUI

struct RecipeCard: View {
    @Binding var recipe: ShortRecipe
    var body: some View {
        VStack(alignment: .center) {
            
            RecipeImageView(imageUrl: recipe.imageUrl)
            Text(recipe.title)
                .font(.custom("Georgia", size: 15, relativeTo: .title))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
        }
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard(recipe: .constant(testRecipe))
    }
}
