//
//  RecipeDetail.swift
//  RecipeGuru
//
//  Created by Justin Knight on 9/25/23.
//

import Foundation
import ComposableArchitecture



struct RecipeDetail: Reducer {
    var body: some ReducerOf<RecipeDetail>  {
        Reduce { state, action in
            switch action {
            case .favoriteButtonTapped:
                state.isRecipeFavorited = !state.isRecipeFavorited
                return .none
            
            }
        }
    }
    enum Action: Equatable {
        case favoriteButtonTapped
    }
    
    struct State: Equatable {
        var isRecipeFavorited: Bool = false
    }
    
}
