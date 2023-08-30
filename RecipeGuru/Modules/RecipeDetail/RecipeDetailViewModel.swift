//
//  RecipeDetailViewModel.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/30/23.
//

import Foundation
import Combine

protocol RecipeDetailViewModelProtocol: ObservableObject {
    init(api: APIService, recipeId: Int)
    func getRecipeDetails()
    func getRecipeInstructions()
}



class RecipeDetailViewModel: RecipeDetailViewModelProtocol {
    
    @Published var recipeDetails: RecipeDetail
    @Published var recipeInstructions: RecipeInstructions

    private var recipeId: Int
    private let apiService: APIService
    var recipeImageData: Data?
    
    private var cancellables = Set<AnyCancellable>()
    
    required init(api: APIService = APIService(), recipeId: Int) {
        self.apiService = api
        self.recipeDetails = emptyRecipeDetail
        self.recipeInstructions = emptyRecipeInstructions
        self.recipeId = recipeId
    }
    
    func getRecipeDetails() {
        apiService.loadRecipeDetails(id: recipeId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.recipeDetails = noRecipeDetailResponse
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.recipeDetails = response
            }
            .store(in: &cancellables)
    }
    
    func getRecipeInstructions() {
        apiService.loadRecipeInstructions(id: recipeId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.recipeInstructions = noRecipeInstructions
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let instructions = response.first else {
                    self?.recipeInstructions = noRecipeInstructions
                    return
                }
                self?.recipeInstructions = instructions
            }
            .store(in: &cancellables)
    }
    
    
    
    
    func markAsFavorite() {
        print("Favorited")
        
        
    }
}


class MockRecipeDetailViewModel: RecipeDetailViewModel {
    
    override func getRecipeDetails() {
        self.recipeDetails = testRecipeDetailResponse
    }
    override func getRecipeInstructions() {
        self.recipeInstructions = testRecipeInstrcutions
    }
}
