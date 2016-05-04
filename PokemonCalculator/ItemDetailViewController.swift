//
//  ItemDetailViewController.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/28/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    
    var name:String = ""
    var descript:String = ""
    var itemImg: UIImage?
    
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemDescription: UITextView!
    @IBOutlet weak var ItemImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemName.text = name
        ItemDescription.text = descript
        ItemImage.image = itemImg
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
