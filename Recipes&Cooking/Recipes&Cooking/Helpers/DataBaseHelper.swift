//
//  DataBaseHelper.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 19/07/23.
//

import UIKit
import CoreData

struct DataBaseHelper {
    static func saveRecipe(recipeModel: RecipeModel) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newRecipe = Recipe(context: context)

        recipeModel.dishImage?.pngData() 
        newRecipe.image = recipeModel.dishImage?.pngData()
        newRecipe.name = recipeModel.dishName
        newRecipe.portions = recipeModel.portions
        newRecipe.timePrepare = recipeModel.time
        newRecipe.ingredients = recipeModel.ingridients
        newRecipe.instructions = recipeModel.instructions
        
        do {
            try context.save()
            print("Image saved to Core Data successfully!")
        } catch {
            print("Failed to save image: \(error)")
        }
    }
}
