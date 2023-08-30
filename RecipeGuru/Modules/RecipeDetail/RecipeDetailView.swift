//
//  RecipeDetailView.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    init(viewModel: RecipeDetailViewModel) {
        self.viewModel = viewModel
    }
    
  
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text(viewModel.recipeDetails.title)
                    .padding(.leading, 20)
                    .multilineTextAlignment(.center)

                AsyncImage(url: URL(string: viewModel.recipeDetails.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView("Loading...")
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(20)
                            .padding()
                        //Store the image
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
               
                HStack {
                    Text("Cooking Time: \(viewModel.recipeDetails.readyInMinutes) minutes")
                        .font(.body)
                        .padding(.leading, 20)
                    Spacer()
                    Text("Servings: \(viewModel.recipeDetails.servings)")
                        .padding(.trailing, 20)
                    
                }

                
                Button {
                    viewModel.markAsFavorite()
                } label: {
                    Spacer()
                    Text("Mark as Favorite")
                    Spacer()
                }
                .padding(10)
                .background(.green, in: Capsule())
                .foregroundColor(.white)
                .padding([.leading, .trailing], 20)

                Divider()
                LazyVStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.title)
                    Spacer().frame(height: 15)
                    ForEach(viewModel.recipeDetails.extendedIngredients) { ingredient in
                        Text("- " + ingredient.original)
                    }
                    Divider()
                    Text("Recipe")
                        .font(.title)
                    Spacer().frame(height: 15)
                    ForEach(viewModel.recipeInstructions.steps, id: \.number) { step in
                        Text("\(step.number). \(step.step)")
                    }
                    
                    
                    
                }
                .padding([.leading, .trailing], 20)
            }.onAppear{
                viewModel.getRecipeDetails()
                viewModel.getRecipeInstructions()
            }
        }.navigationTitle("Recipe Details")
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(viewModel: MockRecipeDetailViewModel(recipeId: 1))
    }
}
