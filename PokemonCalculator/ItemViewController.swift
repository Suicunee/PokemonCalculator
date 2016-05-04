//
//  ItemViewController.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/28/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var itemArray = [String]()
    var itemDict = [String: AnyObject]()
    let itemURL = "http://pokeapi.co/media/sprites/items/"
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        itemDict = appDelegate!.itemDict
        itemArray = Array(itemDict.keys)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "itemIdentifier" {
            let itemDetail:ItemDetailViewController = segue.destinationViewController as! ItemDetailViewController
            let cell = sender as! ItemTableViewCell
            let path = myTableView.indexPathForCell(cell)
            let name = itemArray[path!.row]
            itemDetail.name = name
            itemDetail.descript = itemDict[name] as! String
            itemDetail.itemImg = getImageByName(name)
        }
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemViewCell", forIndexPath: indexPath) as! ItemTableViewCell
        let name = itemArray[indexPath.row]
        cell.ItemName.text = name
        cell.ItemPicture.image = getImageByName(name)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print("selected \(indexPath.row) row")
    }
    
    /*
     * Get item imageg based on name
     */
    func getImageByName(name: String) -> UIImage {
        var image = UIImage()
        let myString = itemURL + name + ".png"
        let url = NSURL(string: myString)
        let data = NSData(contentsOfURL: url!)
        if data == nil {
            return image
        }
        else {
            image = UIImage(data: data!)!
        }
        return image
    }
    
    
}