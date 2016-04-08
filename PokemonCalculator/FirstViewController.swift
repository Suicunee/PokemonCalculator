//
//  FirstViewController.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/4/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let baseURL = "http://pokeapi.co/api/v1/pokemon/"
    var pokemonArray = [Pokemon]()
    let mew = Pokemon(name:"Mew", pokemonID:151)
    let mewtwo = Pokemon(name: "Mewtwo", pokemonID:150)

    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 1...151{
            pokemonArray.append(getPokeData(index))
//            getPokemonData(index) { pokemon in
//                if pokemon.name != nil {
//                    print(pokemon.name)
//                    self.pokemonArray.append(pokemon)
//                }
//            }
            
        }
//        print(pokemonArray.count)
//        pokemonArray.append(mew)
//        pokemonArray.append(mewtwo)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pokeName" {
            let pokemonDetail:PokemonDetailController = segue.destinationViewController as! PokemonDetailController
            print("segue selected")
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
            //print(pokemonArray[path!.row].pokemonPictURL!)
            
            let url = NSURL(string: pokemonArray[path!.row].pokemonPictURL!)
            let data = NSData(contentsOfURL: url!)
            pokemonDetail.pokemonImage = UIImage(data: data!)
            
        }
        
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PokemonTableViewCell
        //print(pokemonArray[indexPath.row].name)
        cell.pokemonName.text = pokemonArray[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected \(indexPath.row) row")
        
    }
    
    // background thread
    func getPokeData(index: Int) -> Pokemon {
        var pokemon = Pokemon()
        let url = NSURL(string: baseURL + String(index))
        let request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        // Semaphore
        let semaphore = dispatch_semaphore_create(0)
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            if data == data {
                
                do{
                    //Get json 
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    //print(json)
                    //Get pokemon index
                    pokemon.pokemonID = index
                    
                    //Get pokemon name
                    if let name = json["name"] as? String{
                        pokemon.name = name
                    }
                    
                    //Get pokemon types
                    if let typeArr = json["types"] as? Array<Dictionary<String,AnyObject>>{

                        let dict = typeArr[0] as? [String: AnyObject]
                        let type = dict!["name"] as? String
                        pokemon.pokemonType1 = Type(str:type!)
                        if typeArr.count == 2 {
                            
                            let dict2 = typeArr[1] as? [String: AnyObject]
                            let type2 = dict2!["name"] as? String
                            pokemon.pokemonType2 = Type(str:type2!)
                        }
                        
                    }
                    
                    if let ability = json["abilities"] as? Array<Dictionary<String,AnyObject>>{
                        for dict in ability {
                            if let abilityName = dict["name"] as? String {
                                pokemon.pokemonAbility.append(abilityName)
                            }
                        }
                    }
                    
                    //Get pokemon stats
                    if let speed = json["speed"] as? Int{
                        pokemon.speed = speed
                    }
                    
                    if let specialAtk = json["sp_atk"] as? Int{
                        pokemon.specialAttack = specialAtk
                    }
                    
                    if let specialDef = json["sp_def"] as? Int{
                        pokemon.specialDefense = specialDef
                    }
                    
                    if let hp = json["hp"] as? Int{
                        pokemon.hp = hp
                    }
                    
                    if let atk = json["attack"] as? Int{
                        pokemon.attack = atk
                    }
                    
                    if let def = json["defense"] as? Int{
                        pokemon.defense = def
                    }
                    
                    pokemon.pokemonPictURL = "http://pokeapi.co/media/img/" + String(index) + ".png"
                    //print(pokemon.pokemonPictURL)
                    
                }catch {
                    print("Error with Json: \(error)")
                }

            } else {
                print(error)
            }
            dispatch_semaphore_signal(semaphore)
        }
        
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return pokemon
    }
    

    

}

