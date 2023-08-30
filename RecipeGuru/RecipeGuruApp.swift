//
//  RecipeGuruApp.swift
//  RecipeGuru
//
//  Created by Justin Knight on 8/29/23.
//

import SwiftUI

@main
struct RecipeGuruApp: App {
    
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            RecipeSearchView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
