//
//  FirstViewController.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/4/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import UIKit
import Foundation

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    let baseURL = "http://pokeapi.co/api/v1/pokemon/"
    var pokemonArray = [Pokemon]()
    let mew = Pokemon(name:"Mew", pokemonID:151)
    let mewtwo = Pokemon(name: "Mewtwo", pokemonID:150)

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        pokemonArray = appDelegate!.pokemonArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pokeName" {
            let pokemonDetail:PokemonDetailController = segue.destinationViewController as! PokemonDetailController
            let cell = sender as! PokemonTableViewCell
            let path = myTableView.indexPathForCell(cell)
            
            pokemonDetail.pokeName = pokemonArray[path!.row].name!
            pokemonDetail.pokeType1 = (pokemonArray[path!.row].pokemonType1?.pokemonType!)!
            pokemonDetail.pokeType2 = (pokemonArray[path!.row].pokemonType2.pokemonType!)
            pokemonDetail.pokemonHp = String(pokemonArray[path!.row].hp!)
            pokemonDetail.pokemonAtk = String(pokemonArray[path!.row].attack!)
            pokemonDetail.pokemonDef = String(pokemonArray[path!.row].defense!)
            pokemonDetail.pokemonSpa = String(pokemonArray[path!.row].specialAttack!)
            pokemonDetail.pokemonSpd = String(pokemonArray[path!.row].specialDefense!)
            pokemonDetail.pokemonSpe = String(pokemonArray[path!.row].speed!)
            
            let url = NSURL(string: pokemonArray[path!.row].pokemonPictURL!)
            let data = NSData(contentsOfURL: url!)
            pokemonDetail.pokemonImage = UIImage(data: data!)
            
        }
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PokemonTableViewCell
        cell.pokemonName.text = pokemonArray[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print("selected \(indexPath.row) row")
        
    }

    

}

