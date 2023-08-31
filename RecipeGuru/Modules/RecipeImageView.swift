//
//  RecipeImageView.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/31/23.
//

import SwiftUI

struct RecipeImageView: View {
    
    @State var imageUrl: String
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView("Loading...")
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding()
                
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
    }
}

struct RecipeImageView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeImageView(imageUrl: testRecipe.imageUrl)
    }
}
