//
//  DataBaseHelper.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 19/07/23.
//

import UIKit
import CoreData

final class DataBaseHelper {
    static func displayImageFromCoreData() -> Data? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()

        do {
            let imageEntities = try context.fetch(fetchRequest)
            if let imageEntity = imageEntities.first,
               let imageData = imageEntity.image {
                return imageData
            }
        } catch {
            print("Failed to fetch image: \(error)")
        }
        return nil
    }
}
