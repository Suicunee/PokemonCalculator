//
//  PokemonTableViewCell.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/6/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
