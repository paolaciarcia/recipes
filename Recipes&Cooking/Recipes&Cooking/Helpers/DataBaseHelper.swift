//
//  DataBaseHelper.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 19/07/23.
//

import UIKit
import CoreData

struct DataBaseHelper {
    static let shareInstance = DataBaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveImage(data: Data) {
        let newRecipe = Recipe(context: context)
        newRecipe.image = data
        do {
            try context.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchImage() -> [Recipe] {
        var fetchingImage = [Recipe]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [Recipe]
        } catch {
            print("Error while fetching the image")
        }
        return fetchingImage
    }
}
