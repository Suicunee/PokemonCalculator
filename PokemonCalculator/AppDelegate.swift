//
//  AppDelegate.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/4/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var pokemonArray = [Pokemon]()
    var pokemonSkillArray = [String]()
    var pokemonSkillPowerDict = [String: Int]()
    var pokemonSkillTypeDict = [String: Type]()
    var pokemonSkillDamageClassDict = [String: String]()
    let mew = Pokemon(name:"Mew", pokemonID:151)
    let mewtwo = Pokemon(name: "Mewtwo", pokemonID:150)
    let baseURL = "http://pokeapi.co/api/v1/pokemon/"
    let typeBaseURL = "http://pokeapi.co"


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        for index in 1...9{
            pokemonArray.append(getPokeData(index))
        }
        
        for index in 0...8 {
            let pokeArray = Array(pokemonArray[index].pokemonSkills.keys)
            for skill in pokeArray {
                pokemonSkillArray.append(skill)
            }
        }
        pokemonSkillArray = Array(Set(pokemonSkillArray))
        
        for index in 0...8 {
            let pokemonSkills = pokemonArray[index].pokemonSkills
            for key in pokemonSkills.keys {
                let pokemonSkillURL = pokemonSkills[key]
                let (skillPower, Type, damageClass) = getPokemonSkillPowerAndType(pokemonSkillURL!)
                pokemonSkillPowerDict[key] = skillPower
                pokemonSkillTypeDict[key] = Type
                pokemonSkillDamageClassDict[key] = damageClass
                
            }
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
    
    func getPokeData(index: Int) -> Pokemon {
        var pokemon = Pokemon()
        let url = NSURL(string: baseURL + String(index))
        let request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        // Semaphore
        let semaphore = dispatch_semaphore_create(0)
        //dispatch_async(dispatch_get_global_queue(priority, 0)) {
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
                        pokemon.pokemonType1 = Type(str:(type?.uppercaseString)!)
                        if typeArr.count == 2 {
                            
                            let dict2 = typeArr[1] as? [String: AnyObject]
                            let type2 = dict2!["name"] as? String
                            pokemon.pokemonType2 = Type(str:(type2?.uppercaseString)!)
                        }
                        
                    }
                    
                    if let ability = json["abilities"] as? Array<Dictionary<String,AnyObject>>{
                        for dict in ability {
                            if let abilityName = dict["name"] as? String {
                                pokemon.pokemonAbility.append(abilityName)
                            }
                        }
                    }
                    
                    if let moves = json["moves"] as? Array<Dictionary<String,AnyObject>> {
                        for dict in moves {
                            let skillname = dict["name"] as? String
                            let skillURI = dict["resource_uri"] as? String
                            //pokemon.pokemonSkills.append((name:skillname!,power:skillURI!))
                            pokemon.pokemonSkills[skillname!] = skillURI
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
                    
                }catch {
                    print("Error with Json: \(error)")
                }
                
            } else {
                print(error)
            }
            dispatch_semaphore_signal(semaphore)
        }
        
        task.resume()
        //}
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return pokemon
    }
    
    /*
     * Parse skill information into skill dicts
     * Skill name is parsed
     * Skill power is parsed
     * Skill damage class is parsed
     * Skill type is parsed
     */
    
    func getPokemonSkillPowerAndType(skillURL: String) -> (Int, Type, String) {
        var skillPower = 0
        var type = Type(str: "")
        var damageClass = ""
        var urlArray = skillURL.componentsSeparatedByString("/")
        urlArray[2] = "v2"
        let newURL = urlArray.joinWithSeparator("/")
        
        let url = NSURL(string: typeBaseURL + newURL)
        let request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let semaphore = dispatch_semaphore_create(0)
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            if data == data {
                
                do{
                    //Get json
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    //Get pokemon name
                    if let power = json["power"] as? Int{
                        skillPower = power
                    }
                    if let pokeType = json["type"] as? [String: AnyObject] {
                        let typeName = pokeType["name"] as? String
                        type.pokemonType = typeName?.uppercaseString
                    }
                    if let pokeDamageClass = json["damage_class"] as? [String: AnyObject] {
                        let myClass = pokeDamageClass["name"] as? String
                        damageClass = myClass!
                    }

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
        return (skillPower, type, damageClass)
    }

}

