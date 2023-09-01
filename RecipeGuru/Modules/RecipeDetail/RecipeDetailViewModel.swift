//
//  RecipeDetailViewModel.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/30/23.
//

import Foundation
import Combine
import CoreData

protocol RecipeDetailViewModelProtocol: ObservableObject {
    init(api: APIService, viewContext: NSManagedObjectContext, recipeId: Int)
    func loadData()
}



class RecipeDetailViewModel: RecipeDetailViewModelProtocol {
    
    @Published var showError: Bool = false
    @Published var recipeSummary: RecipeSummary?
    
    private var viewContext: NSManagedObjectContext
    private var recipeId: Int
    private let apiService: APIService
    var recipeImageData: Data?
    var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    required init(api: APIService = APIService(),
                  viewContext: NSManagedObjectContext,
                  recipeId: Int) {
        self.apiService = api
        self.viewContext = viewContext
        self.recipeId = recipeId
    }
    
    func loadData() {
        if let recipe = fetchSavedRecipe() {
            DispatchQueue.main.async { [ weak self] in
                self?.recipeSummary = RecipeSummary(id: Int(recipe.id),
                                                    title: recipe.title ?? "",
                                                    imageUrl: "",
                                                    imageData: recipe.image,
                                                    readyInMinutes: Int(recipe.readyInMinutes),
                                                    servings: Int(recipe.servings),
                                                    isFavorite: recipe.isFavorite,
                                                    instructions: recipe.instructions ?? [],
                                                    ingredients: recipe.ingredients ?? [])
            }
            
        } else {
            getDetails()
        }
    }
    
    
    private func fetchSavedRecipe() -> LocalRecipe? {
        do {
            let recipes = try viewContext.fetch(LocalRecipe.fetchRequest())
            print(recipes.count)
            return recipes.first(where: {$0.id == recipeId})
        }
        catch {
            print("Error fetching local data")
            return nil
        }
        
        
    }
    
    func removeRecipe() {
        if let recipe = createLocalRecipe() {
            viewContext.delete(recipe)
            do {
                try self.viewContext.save()
            } catch {
                print("Failed to delete recipe")
            }
        }
        
    }
    
    func toggleFavorite() {
        if recipeSummary?.isFavorite ?? false {
            removeRecipe()
        } else {
            saveRecipe()
        }
    }
    
    private func saveRecipe() {
        if createLocalRecipe() != nil {
            do {
                try self.viewContext.save()
            }
            catch {
                print("Failed to Save Recipe")
            }
        }
    }
    
    
    private func createLocalRecipe() -> LocalRecipe? {
        guard let recipeSummary = recipeSummary else { return nil}
        let imageData = ImageCache.shared.get(forKey: recipeSummary.imageUrl)?.pngData()
        
        let newRecipe = LocalRecipe(context: viewContext)
        newRecipe.id = Int64(recipeSummary.id)
        newRecipe.title = recipeSummary.title
        newRecipe.image = imageData
        newRecipe.isFavorite = true
        newRecipe.readyInMinutes = Int64(recipeSummary.readyInMinutes)
        newRecipe.servings = Int64(recipeSummary.servings)
        newRecipe.ingredients = recipeSummary.ingredients
        newRecipe.instructions = recipeSummary.instructions
        return newRecipe
    }
    
    
    private func getDetails() {
        let detailsPublisher = apiService.load(endpoint: .detail(id: recipeId), type: RecipeDetail.self)
        let instructionsPublisher = apiService.load(endpoint: .instructions(id: recipeId), type: [RecipeInstructions].self)
        
        Publishers.CombineLatest(detailsPublisher, instructionsPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    print("Finished")
                }
                
            }, receiveValue: { [weak self] details, instructions  in
                var recipeInstructions: [String] = []
                if let first = instructions.first {
                    recipeInstructions = first.steps.map({"\($0.number). \($0.step)"})
                }
                
                self?.recipeSummary =  RecipeSummary(id: details.id,
                                                     title: details.title,
                                                     imageUrl: details.image,
                                                     imageData: nil,
                                                     readyInMinutes: details.readyInMinutes,
                                                     servings: details.servings,
                                                     isFavorite: false,
                                                     instructions: recipeInstructions,
                                                     ingredients: details.extendedIngredients.map({$0.original}))
            })
            .store(in: &cancellables)
    }
}


class MockRecipeDetailViewModel: RecipeDetailViewModel {
    
    override func loadData() {
        recipeSummary = testRecipeSummary
    }
}
