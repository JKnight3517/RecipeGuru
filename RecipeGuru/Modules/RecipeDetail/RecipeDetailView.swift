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
                Text(viewModel.recipeSummary?.title ?? "")
                    .padding(.leading, 20)
                    .multilineTextAlignment(.center)

                AsyncImage(url: URL(string: viewModel.recipeSummary?.imageUrl ?? "")) { phase in
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
               
                HStack {
                    if let readyInMinutes = viewModel.recipeSummary?.readyInMinutes {
                        Text("Cooking Time: \(readyInMinutes) minutes")
                            .font(.body)
                            .padding(.leading, 20)
                    }
                    Spacer()
                    if let servings = viewModel.recipeSummary?.servings {
                        Text("Servings: \(servings)")
                            .padding(.trailing, 20)
                    }
                    
                }

                
                Button {
                    viewModel.toggleFavorite()
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
                    ForEach(viewModel.recipeSummary?.ingredients ?? [], id:\.self) { ingredient in
                        Text("- " + ingredient)
                    }
                    Divider()
                    Text("Recipe")
                        .font(.title)
                    Spacer().frame(height: 15)
                    ForEach(viewModel.recipeSummary?.instructions ?? [], id: \.self) { step in
                        Text(step)
                    }
                    
                    
                    
                }
                .padding([.leading, .trailing], 20)
            }.onAppear{
                viewModel.loadData()
            }
        }.navigationTitle("Recipe Details")
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(viewModel: MockRecipeDetailViewModel(viewContext: PersistenceController.shared.container.viewContext, recipeId: 1))
    }
}
