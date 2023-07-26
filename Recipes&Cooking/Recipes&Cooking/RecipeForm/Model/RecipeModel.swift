import Foundation
import SwiftData

@Model
class RecipeModel {
   var dishImage: Data?
   var dishName: String = ""
   var portions: String = ""
   var time: String = ""
   var ingridients: String = ""
   var instructions: String = ""
    var dishTextFieldCount: Int = 0
   var portionsTextFieldCount: Int = 0
   var timeTextFieldCount: Int = 0
   var ingridientsCount: Int = 0
   var instructionsCount: Int = 0

    init(dishImage: Data? = nil, dishName: String = "", portions: String = "", time: String = "", ingridients: String = "", instructions: String = "", dishTextFieldCount: Int = 0, portionsTextFieldCount: Int = 0, timeTextFieldCount: Int = 0, ingridientsCount: Int = 0, instructionsCount: Int = 0) {
        self.dishImage = dishImage
        self.dishName = dishName
        self.portions = portions
        self.time = time
        self.ingridients = ingridients
        self.instructions = instructions
        self.dishTextFieldCount = dishTextFieldCount
        self.portionsTextFieldCount = portionsTextFieldCount
        self.timeTextFieldCount = timeTextFieldCount
        self.ingridientsCount = ingridientsCount
        self.instructionsCount = instructionsCount
    }
}
