

import Foundation
import UIKit


//struct Recipe {
//    var name: String = ""
//    var portions: String = ""
//    var timePrepare: String = ""
//    var ingredients: String = ""
//    var instructions: String = ""
//    var image: UIImage? = UIImage(named: "emptyState")
//
//    static func saveImage(_ image: UIImage, forRecipe recipe: Recipe) {
//        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(recipe.name)
//      if let jpgData = image.jpegData(compressionQuality: 0.7) {
//        try? jpgData.write(to: imageURL, options: .atomicWrite)
//      }
//    }
//  }

extension FileManager {
  static var documentDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}
