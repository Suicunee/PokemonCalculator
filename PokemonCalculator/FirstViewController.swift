//
//  FirstViewController.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/4/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    var pokemonArray = [Pokemon]()
    var audioPlayer: AVAudioPlayer!
    let path = NSBundle.mainBundle().pathForResource("PokemonMusic/battle1", ofType: "mp3")!

    
    @IBAction func playMusic(sender: AnyObject) {
        let url = NSURL(fileURLWithPath: path)
        do {
            let sound = try AVAudioPlayer(contentsOfURL: url)
            audioPlayer = sound
            audioPlayer.numberOfLoops = 3
            sound.play()
        } catch {
            // couldn't load file :(
        }

    }
    
    @IBAction func stopMusic(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        pokemonArray = appDelegate!.pokemonArray
        
        
        // Removed deprecated use of AVAudioSessionDelegate protocol

        
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
            if (pokemonArray[path!.row].pokemonType2.pokemonType!) == "null" {
                pokemonDetail.pokeType2 = ""
            }
            else {
                pokemonDetail.pokeType2 = (pokemonArray[path!.row].pokemonType2.pokemonType!)
            }
            pokemonDetail.pokemonHp = String(pokemonArray[path!.row].hp!)
            pokemonDetail.pokemonAtk = String(pokemonArray[path!.row].attack!)
            pokemonDetail.pokemonDef = String(pokemonArray[path!.row].defense!)
            pokemonDetail.pokemonSpa = String(pokemonArray[path!.row].specialAttack!)
            pokemonDetail.pokemonSpd = String(pokemonArray[path!.row].specialDefense!)
            pokemonDetail.pokemonSpe = String(pokemonArray[path!.row].speed!)
            
            pokemonDetail.pokemonID = "#" + getID(path!.row)
            
            let url = pokemonArray[path!.row].pokemonPictURL!
            pokemonDetail.pokemonImage = getImageByURL(url)
            
        }
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PokemonTableViewCell
        cell.pokemonName.text = pokemonArray[indexPath.row].name
        let url = pokemonArray[indexPath.row].pokemonPictURL
        cell.pokemonImage.image = getImageByURL(url!)
        cell.pokemonID.text = "#" + getID(indexPath.row)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print("selected \(indexPath.row) row")
        
    }
    
    func getImageByURL(pokemonURL: String) -> UIImage {
        let url = NSURL(string: pokemonURL)
        let data = NSData(contentsOfURL: url!)
        return UIImage(data: data!)!
    }
    
    func getID(id: Int) -> String {
        var string = String(id + 1)
        if string.characters.count == 1 {
            string = "00" + string
        }
        else if string.characters.count == 2 {
            string = "0" + string
        }
        return string
    }
    

}

