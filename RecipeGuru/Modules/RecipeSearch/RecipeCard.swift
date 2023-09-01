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
        
        HStack {
            Spacer()
            VStack(alignment: .center) {
                if let imageData = recipe.imageData, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .padding()
                } else {
                    RecipeImageView(url: recipe.imageUrl)
                }
        
                Text(recipe.title)
                    .font(.custom("Georgia", size: 15, relativeTo: .title))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
            }
            Spacer()
        }
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard(recipe: .constant(testRecipe))
    }
}
