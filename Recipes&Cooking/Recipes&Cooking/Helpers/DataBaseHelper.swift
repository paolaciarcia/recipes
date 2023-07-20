//
//  DataBaseHelper.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 19/07/23.
//

import UIKit
import CoreData

struct DataBaseHelper {
    static func saveImageToCoreData(dishName: String, portions: String, time: String, ingridients: String, instructions: String, dishImage: UIImage) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newRecipe = Recipe(context: context)

        newRecipe.image = dishImage.pngData()
        newRecipe.name = dishName
        newRecipe.portions = portions
        newRecipe.timePrepare = time
        newRecipe.ingredients = ingridients
        newRecipe.instructions = instructions
        
        do {
            try context.save()
            print("Image saved to Core Data successfully!")
        } catch {
            print("Failed to save image: \(error)")
        }
    }
}
