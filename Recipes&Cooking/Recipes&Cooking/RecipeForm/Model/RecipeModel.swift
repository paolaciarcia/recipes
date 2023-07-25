import Foundation
import RealmSwift

class RecipeModel: Object {
    @objc dynamic var dishImage: Data?
    @objc dynamic var dishName: String = ""
    @objc dynamic var portions: String = ""
    @objc dynamic var time: String = ""
    @objc dynamic var ingridients: String = ""
    @objc dynamic var instructions: String = ""
    @objc dynamic var dishTextFieldCount = 0
    @objc dynamic var portionsTextFieldCount = 0
    @objc dynamic var timeTextFieldCount = 0
    @objc dynamic var ingridientsCount = 0
    @objc dynamic var instructionsCount = 0
}
