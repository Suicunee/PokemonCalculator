//
//  PokemonDetailController.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/6/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import UIKit

class PokemonDetailController: UIViewController {
    
    var pokeName:String = ""
    var pokeType1:String = ""
    var pokeType2:String = ""
    
    var pokemonHp:String = ""
    var pokemonAtk:String = ""
    var pokemonDef:String = ""
    var pokemonSpa:String = ""
    var pokemonSpd:String = ""
    var pokemonSpe:String = ""
    
    var pokemonImage: UIImage?
//
    
    var pokemon:Pokemon?
    
    @IBOutlet weak var Label: UILabel! // pokemonName
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var type2: UILabel!

    @IBOutlet weak var pokeHP: UILabel!
    @IBOutlet weak var pokeAtk: UILabel!
    @IBOutlet weak var pokeDef: UILabel!
    @IBOutlet weak var pokeSpa: UILabel!
    @IBOutlet weak var pokeSpd: UILabel!
    @IBOutlet weak var pokeSpe: UILabel!
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Label.text = pokeName
        type1.text = pokeType1
        type2.text = pokeType2
        
        pokeHP.text = pokemonHp
        pokeAtk.text = pokemonAtk
        pokeDef.text = pokemonDef
        pokeSpa.text = pokemonSpa
        pokeSpd.text = pokemonSpd
        pokeSpe.text = pokemonSpe
        pokemonImageView.image = pokemonImage
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
