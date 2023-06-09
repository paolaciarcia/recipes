

import Foundation
import UIKit


class Recipe {
    var image : UIImage? {
        Recipe.loadImage(forRecipe: self)
    }
    var name: String
    var timePrepare: Int
    var portions: Int
    var ingredients: String
    var instructions: String
    
    init(name: String, timePrepare: Int, portions: Int, ingredients: String, instructions: String, image: UIImage?) {
        
        self.name = name
        self.timePrepare = timePrepare
        self.portions = portions
        self.ingredients = ingredients
        self.instructions = instructions        
    }
    
    func isValid() -> Bool {
        return !(name.isEmpty || ingredients.isEmpty || instructions.isEmpty || timePrepare == nil || portions == nil)
    }
    
    static func saveImage(_ image: UIImage, forRecipe recipe: Recipe) {
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(recipe.name)
      if let jpgData = image.jpegData(compressionQuality: 0.7) {
        try? jpgData.write(to: imageURL, options: .atomicWrite)
      }
    }
    
    static func loadImage(forRecipe recipe: Recipe) -> UIImage? {
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(recipe.name)
      return UIImage(contentsOfFile: imageURL.path)
    }
  }

extension FileManager {
  static var documentDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}






