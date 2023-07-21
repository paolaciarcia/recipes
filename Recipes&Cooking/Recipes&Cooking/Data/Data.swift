//
//  Data.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 21/07/23.
//

import Foundation
import RealmSwift

final class DataObject: Object {
    dynamic var name: String = ""
    dynamic var dishName: String = ""
    dynamic var portions: String = ""
    dynamic var time: String = ""
    dynamic var ingridients: String = ""
    dynamic var instructions: String = ""
    dynamic var dishTextFieldCount = 0
    dynamic var portionsTextFieldCount = 0
    dynamic var timeTextFieldCount = 0
    dynamic var ingridientsCount = 0
    dynamic var instructionsCount = 0
}
