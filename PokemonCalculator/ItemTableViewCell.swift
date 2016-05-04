//
//  ItemTableViewCell.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/29/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ItemName: UILabel!
    
    @IBOutlet weak var ItemPicture: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
