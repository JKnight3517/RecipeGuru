//
//  RecipeSearchViewModel.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import Foundation
import Combine



protocol RecipeSearchViewModelProtocol: ObservableObject {
    var recipes: [Recipe] { get set }
    init(api: APIService)
    func searchForRecipes(searchString: String)
    
}



class RecipeSearchViewModel: RecipeSearchViewModelProtocol {
   
    
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
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.recipes = [noDataRecipe]
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.recipes = response.results
            }
            .store(in: &cancellables)

    }
}


class MockRecipeSearchViewModel: RecipeSearchViewModel {
    
    override func searchForRecipes(searchString: String) {
        self.recipes = testRecipes
    }
}


