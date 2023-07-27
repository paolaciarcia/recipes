//
//  DataBaseHelper.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 19/07/23.
//

import UIKit
import SwiftData

class DataBaseHelper {
    static var shared = DataBaseHelper()
    var container: ModelContainer?
    var context: ModelContext?

    init() {
        do {
            container = try ModelContainer(for: [RecipeModel.self])
            if let container { context = ModelContext(container) }
        } catch {
            print(error)
        }
    }

    func saveRecipe(recipeModel: RecipeModel) {
        if let context {
            context.insert(recipeModel)
        }
    }

    func deleteRecipe(recipeModel: RecipeModel) {
        let recipeToBeDeleted = recipeModel
        if let context{
            context.delete(recipeToBeDeleted)
        }
    }

    func fetchTasks(onCompletion: @escaping([RecipeModel]?, Error?) -> Void) {
        let descriptor = FetchDescriptor<RecipeModel>()

        if let context {
            do {
                let data = try context.fetch(descriptor)
                onCompletion(data, nil)
            } catch {
                onCompletion(nil, error)
            }
        }
    }
}
