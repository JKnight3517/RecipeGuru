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
            
            AsyncImage(url: URL(string: recipe.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView("Loading...")
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 350, height: 250, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                case .failure:
                    Image(systemName: "fork.knife.circle")
                        .font(.title)
                        .frame(width: 150, height: 150)
                @unknown default:
                    Image(systemName: "fork.knife.circle")
                        .font(.title)
                        .frame(width: 150, height: 150)
                }
            }
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
