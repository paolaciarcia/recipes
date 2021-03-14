//
//  INgrediente.swift
//  AMov1920P2ios1
//
//  Created by Marco on 04/01/2020.
//  Copyright © 2020 DEIS-ISEC. All rights reserved.
//

import Foundation
import UIKit

class Ingredientes {
    //var nome : String
    //var quantidade : Double
    //var unidade : String
    var modoPreparo : String
    var serves : Int
    
    init(nome: String, quantidade: Double, unidade : String, modoPreparo: String, serves: Int){
        self.nome = nome
        self.quantidade = quantidade
        self.unidade = unidade
        self.modoPreparo = modoPreparo
        self.serves = serves
    }
    
    func isValid() -> Bool {
        return !(nome.isEmpty && unidade.isEmpty && modoPreparo.isEmpty)
    }
    
    var description : String {
        return "Ingredientes: \(nome) Qnt:\(quantidade), \(unidade), \(modoPreparo)"
    }
}
