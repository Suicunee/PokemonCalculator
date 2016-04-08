//
//  Pokemon.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/5/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    var name: String?
    var pokemonID: Int?
    var pokemonType1:Type?
    var pokemonType2 = Type(str: "null")// default null
    var hp: Int?
    var attack: Int?
    var defense: Int?
    var specialAttack: Int?
    var specialDefense: Int?
    var speed: Int?
    var pokemonEVStats = [String: Int]()
    var pokemonFinalStats = [String: Int]()
    var pokemonAbility = [String]()
    var pokemonPictURL:String?
    
    init() {
        
    }
    
    init(name:String, pokemonID: Int){
        self.name = name
        self.pokemonID = pokemonID
    }
    
    
    
    
}
