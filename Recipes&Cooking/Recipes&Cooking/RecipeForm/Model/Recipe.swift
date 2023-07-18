

import Foundation
import UIKit


struct Recipe {
    var name: String = ""
    var nameCount: Int = 0
    var portions: String = ""
    var timePrepare: String = ""
    var ingredients: String = ""
    var instructions: String = ""
    var isButtonEnable: Bool = true
    var buttonBackgroundColor: UIColor = .systemGray4
    var buttonTitleColor: UIColor = .systemGray
    var image: UIImage? = UIImage(named: "imageTest")

    func isValid() -> Bool {
        return nameCount > 3 //&& portions.count > 1 && timePrepare.count > 3 && ingredients.count > 1 && instructions.count > 1
    }

    static func saveImage(_ image: UIImage, forRecipe recipe: Recipe) {
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(recipe.name)
      if let jpgData = image.jpegData(compressionQuality: 0.7) {
        try? jpgData.write(to: imageURL, options: .atomicWrite)
      }
    }
  }

extension FileManager {
  static var documentDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}
