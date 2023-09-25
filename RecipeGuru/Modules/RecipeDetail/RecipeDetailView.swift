//
//  RecipeDetailView.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import SwiftUI
import ComposableArchitecture

struct RecipeDetailView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    let store: StoreOf<RecipeDetail>
    
    init(viewModel: RecipeDetailViewModel, store: StoreOf<RecipeDetail> ) {
        self.viewModel = viewModel
        self.store = store
    }
    
  
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            
            
            ScrollView {
                VStack(alignment: .center) {
                    Text(viewModel.recipeSummary?.title ?? "")
                        .padding(.leading, 20)
                        .multilineTextAlignment(.center)
                    if let imageData = viewModel.recipeSummary?.imageData, let image = UIImage(data:  imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .padding()
                    } else {
                        RecipeImageView(url: viewModel.recipeSummary?.imageUrl ?? "")
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
                        viewStore.send(.favoriteButtonTapped)
                        
                    } label: {
                        Spacer()
                        Text(viewStore.isRecipeFavorited ? "Remove from Favorites" : "Mark as Favorite")
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
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(viewModel: MockRecipeDetailViewModel(viewContext: PersistenceController.shared.container.viewContext, recipeId: 1),
                         store: Store.init(initialState: RecipeDetail.State()) {
            RecipeDetail()._printChanges()
        })
    }
}
