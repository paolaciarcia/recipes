//
//  DataBaseHelper.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 19/07/23.
//

import UIKit
import RealmSwift

struct DataBaseHelper {
    static func saveRecipe(recipeModel: RecipeModel) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(recipeModel)
            }
        } catch {
            print("Failed to save Recipe: \(error)")
        }
    }
}
