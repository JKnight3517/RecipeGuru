//
//  RecipeSearchViewModel.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import Foundation
import Combine
import CoreData



protocol RecipeSearchViewModelProtocol: ObservableObject {
    var recipes: [ShortRecipe] { get set }
    init(api: APIService, viewContext: NSManagedObjectContext)
    func searchForRecipes(searchString: String)
    
}



class RecipeSearchViewModel: RecipeSearchViewModelProtocol {
   
    @Published var recipes: [ShortRecipe]
    @Published var savedRecipes: [ShortRecipe]
    private var viewContext: NSManagedObjectContext
    private let apiService: APIService
    private var recipeSearchOffset: Int = 0
    var allRecipesLoaded: Bool = true
    private var searchString: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    required init(api: APIService = APIService(),
                  viewContext: NSManagedObjectContext) {
        self.apiService = api
        self.viewContext = viewContext
        self.recipes = []
        self.savedRecipes = []
    }
    
    func searchForRecipes(searchString: String) {
        if self.searchString != searchString {
            self.searchString = searchString
            recipeSearchOffset = 0
            allRecipesLoaded = false
            recipes.removeAll()
        }
        
        let endpoint = Endpoint.search(search: searchString, offset: recipeSearchOffset)
        
        apiService.loadRecipeSearchResults(endpoint: endpoint)
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
                self?.recipes.append(contentsOf: response.results)
                self?.recipeSearchOffset += response.number
                print("Response: \(response.results)")
                self?.allRecipesLoaded  = self?.recipes.count ?? 0 > response.number
            }
            .store(in: &cancellables)

    }
    
    func fetchFavoritedRecipes() {
        do {
           let recipes = try viewContext.fetch(LocalRecipe.fetchRequest())
            let shortRecipes = recipes.map({ShortRecipe(id: Int($0.id), title: $0.title ?? "", imageUrl: "", imageData: $0.image)})
            DispatchQueue.main.async { [weak self] in
                self?.savedRecipes = shortRecipes
            }
        }
        catch {
            print("Error fetching local data")
        }
        
    }
    
}


class MockRecipeSearchViewModel: RecipeSearchViewModel {
    
    override func searchForRecipes(searchString: String) {
        self.recipes = testShortRecipes
    }
}


