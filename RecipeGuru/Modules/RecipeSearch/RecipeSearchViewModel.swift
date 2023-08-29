//
//  RecipeSearchViewModel.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import Foundation
import Combine






class RecipeSearchViewModel: ObservableObject {
    @Published var recipes: [Recipe]
    private let apiService: APIService
    
    private var cancellables = Set<AnyCancellable>()
    
    required init(api: APIService = APIService()) {
        self.apiService = api
        self.recipes = []
    }
    
    func searchForRecipes(searchString: String) {
        apiService.loadRecipes(searchString: searchString)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.recipes = [noDataRecipe]
                case .finished:
                    break
                }
            } receiveValue: { [weak self] recipes in
                self?.recipes = recipes
            }
            .store(in: &cancellables)

    }
}
