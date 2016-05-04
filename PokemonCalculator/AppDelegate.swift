//
//  AppDelegate.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/4/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var pokemonArray = [Pokemon]()
    var pokemonSkillArray = [String]()
    var pokemonSkillPowerDict = [String: Int]()
    var pokemonSkillTypeDict = [String: Type]()
    var pokemonSkillDamageClassDict = [String: String]()
    var itemDict = [String: String]()
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        for index in 0...717{
            pokemonArray.append(getPokemon(index))
        }
        for index in 0...620 {
            let (skillName, skillPower, Type, damageClass) = getPokemonSkillTuple(index)
            pokemonSkillArray.append(skillName)
            pokemonSkillPowerDict[skillName] = skillPower
            pokemonSkillTypeDict[skillName] = Type
            pokemonSkillDamageClassDict[skillName] = damageClass

        }
        for index in 0...745 {
            let (itemName, itemDescription) = getItem(index)
            itemDict[itemName] = itemDescription
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /*
     * Parse skill information into skill dicts
     * Skill name is parsed
     * Skill power is parsed
     * Skill damage class is parsed
     * Skill type is parsed
     */
    
    func getPokemon(index: Int) -> Pokemon {
        var pokemon = Pokemon()
        if let path = NSBundle.mainBundle().pathForResource("PokemonData/pokemon", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    let pokemonDict = jsonResult[index] as! [String : AnyObject]
                    parsePokemon(pokemonDict, pokemon: pokemon)
                    pokemon.pokemonPictURL = "http://pokeapi.co/media/img/" + String(index + 1) + ".png"
                } catch {}
            } catch {}
        }
        return pokemon
    }
    
    /*
     * Parsing Pokemon stats
     * HP
     * Speed
     * Attack
     * Defense
     * Special attack
     * Special Defense
     * Speed
     * Name
     * Type
     */
    func parsePokemon(pokemonDict: [String: AnyObject], pokemon: Pokemon) -> Pokemon {
        
        if let speed = pokemonDict["speed"] as? Int{
            pokemon.speed = speed
        }
        if let attack = pokemonDict["attack"] as? Int{
            pokemon.attack = attack
        }
        if let defense = pokemonDict["defense"] as? Int{
            pokemon.defense = defense
        }
        if let hp = pokemonDict["hp"] as? Int{
            pokemon.hp = hp
        }
        if let sp_atk = pokemonDict["sp_atk"] as? Int{
            pokemon.specialAttack = sp_atk
        }
        if let sp_def = pokemonDict["sp_def"] as? Int{
            pokemon.specialDefense = sp_def
        }
        
        if let name = pokemonDict["name"] as? String{
            pokemon.name = name
        }
        
        if let typeArr = pokemonDict["types"] as? Array<Dictionary<String,AnyObject>>{
            
            let dict = typeArr[0] as? [String: AnyObject]
            let type = dict!["name"] as? String
            pokemon.pokemonType1 = Type(str:(type?.uppercaseString)!)
            if typeArr.count == 2 {
                let dict2 = typeArr[1] as? [String: AnyObject]
                let type2 = dict2!["name"] as? String
                pokemon.pokemonType2 = Type(str:(type2?.uppercaseString)!)
            }
        }
        return pokemon
    }
    
    
    /*
     * Parse skill information into skill dicts
     * Several information in the dictionary:
     * Skill name (String)
     * Skill power (int)
     * Skill damage class (String)
     * Skill type (String)
     */
    func getPokemonSkillTuple(index: Int) -> (String, Int, Type, String) {
        var skillName = ""
        var skillPower = 0
        var type = Type(str: "")
        var damageClass = ""
        var dict = [String: AnyObject]()
        if let path = NSBundle.mainBundle().pathForResource("PokemonData/skill", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    
                    dict = jsonResult[index] as! [String : AnyObject]
                    skillName = dict["name"] as! String
                    
                    if let power = dict["power"] as? Int {
                        skillPower = power
                    }
                    
                    let pokeType = dict["type"] as! [String: AnyObject]
                    let typeName = pokeType["name"] as! String
                    type.pokemonType = typeName.uppercaseString
                    
                    let pokeDamageClass = dict["damage_class"] as! [String: AnyObject]
                    let myClass = pokeDamageClass["name"] as! String
                    damageClass = myClass

                } catch {}
            } catch {}
        }
        return (skillName, skillPower, type, damageClass)
    }
    
    
    /*
     * Parse item information
     * name: name of item
     * itemdescription: the description of item
     */
    func getItem(index: Int) -> (String, String) {
        var itemName = ""
        var itemDescription = ""
        var dict = [String: AnyObject]()
        if let path = NSBundle.mainBundle().pathForResource("PokemonData/item", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    
                    dict = jsonResult[index] as! [String : AnyObject]
                    itemName = dict["name"] as! String
                    
                    if let effectEntries = dict["effect_entries"] as? Array<Dictionary<String,AnyObject>>{
                        if effectEntries.count >= 1 {
                            let effect = effectEntries[0] as! [String: AnyObject]
                            let description = effect["effect"] as! String
                            itemDescription = NSString(bytes: description, length: description.characters.count, encoding: NSUTF8StringEncoding) as! String
                        }
                        else {
                            itemDescription = "No Description for this Item"
                        }
                        
                    }
                } catch {}
            } catch {}
        }
        
        return (itemName, itemDescription)
    }

}

