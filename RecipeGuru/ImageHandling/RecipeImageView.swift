//
//  RecipeImageView.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/31/23.
//

import SwiftUI

//Image view that trys to load an image from the cache or downloads it. Otherwise it will show a default image

struct RecipeImageView: View {
    
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding()
                
            } else {
                Image(systemName: "fork.knife.circle")
                    .padding()
                    .font(.largeTitle)
            }
        }
    }
}

struct RecipeImageView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeImageView(url: testRecipe.imageUrl)
    }
}




