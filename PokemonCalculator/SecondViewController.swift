//
//  SecondViewController.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/4/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{

    // pop up window
    @IBAction func calculate(sender: AnyObject) {
        let string1 = generateResultMessage1()
        let string2 = generateResultMessage2()
        let alertController = UIAlertController(title: "Calculation", message:
            string1 + "\n" + string2 , preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "close", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    /*
     * PokemonArray: Store each pokemon parsed
     * PokemonSkillArray: Store each skill parsed
     * PokemonSkillPowerDict: Store a key value pair where skillname = key and skillpower = value
     * PokemonSkillDamageClassDict: Store a key value pair where skillname = key and skillDamageClass = value
     * PokemonSkillTypeDict: Store a key value pair where skillname = key and skillType = value
     * NatureArray: Store each nature, which has effect on final pokemon stat value
     * ItemArray: Store each item
     * ItemDict: Store a key value pair where itemname = key and itempower = value
     */
    var pokemonArray = [Pokemon]()
    var pokemonSkillArray = [String]()
    
    var pokemonSkillPowerDict = [String: Int]()
    var pokemonSkillTypeDict = [String: Type]()
    var pokemonSkillDamageClassDict = [String: String]()
    
    var natureArray = ["Adamant", "Bashful", "Bold", "Brave", "Calm", "Careful", "Docile", "Gentle", "Hardy", "Hasty", "Impish", "Jolly", "Lax", "Lonely", "Mild", "Modest", "Naive", "Naughty", "Quiet", "Quirky", "Rash", "Relaxed", "Sassy", "Serious", "Timid"]
    
    var itemArray = [String]()
    var itemDict = [String:Int]()
    
    var textFieldFlag = 1
    
    // Information of Pokemon1
    
    @IBOutlet weak var pokemonTextField1: UITextField!
    @IBOutlet weak var pokemonPickerView: UIPickerView!
    @IBOutlet weak var skillPickerView: UIPickerView!
    @IBOutlet weak var naturePickerView: UIPickerView!
    
    
    @IBOutlet weak var pokemon1Item: UITextField!
    @IBOutlet weak var pokemon1Nature: UITextField!
    
    @IBOutlet weak var pokemon1HP: UITextField!
    @IBOutlet weak var pokemon1ATK: UITextField!
    @IBOutlet weak var pokemon1DEF: UITextField!
    @IBOutlet weak var pokemon1SPA: UITextField!
    @IBOutlet weak var pokemon1SPD: UITextField!
    @IBOutlet weak var pokemon1SPE: UITextField!
    
    @IBOutlet weak var pokemon1HPFinal: UILabel!
    @IBOutlet weak var pokemon1ATKFinal: UILabel!
    @IBOutlet weak var pokemon1DEFFinal: UILabel!
    @IBOutlet weak var pokemon1SPAFinal: UILabel!
    @IBOutlet weak var pokemon1SPDFinal: UILabel!
    @IBOutlet weak var pokemon1SPEFinal: UILabel!
    
    
    @IBOutlet weak var pokemon1Skill1: UITextField!
    @IBOutlet weak var pokemon1Skill2: UITextField!
    @IBOutlet weak var pokemon1Skill3: UITextField!
    @IBOutlet weak var pokemon1Skill4: UITextField!
    
    // Information of Pokemon2
    
    @IBOutlet weak var pokemonTextField2: UITextField!
    @IBOutlet weak var pokemon2Item: UITextField!
    @IBOutlet weak var pokemon2Nature: UITextField!
    
    @IBOutlet weak var pokemon2HP: UITextField!
    @IBOutlet weak var pokemon2ATK: UITextField!
    @IBOutlet weak var pokemon2DEF: UITextField!
    @IBOutlet weak var pokemon2SPA: UITextField!
    @IBOutlet weak var pokemon2SPD: UITextField!
    @IBOutlet weak var pokemon2SPE: UITextField!
    
    @IBOutlet weak var pokemon2HPFinal: UILabel!
    @IBOutlet weak var pokemon2ATKFinal: UILabel!
    @IBOutlet weak var pokemon2DEFFinal: UILabel!
    @IBOutlet weak var pokemon2SPAFinal: UILabel!
    @IBOutlet weak var pokemon2SPDFinal: UILabel!
    @IBOutlet weak var pokemon2SPEFinal: UILabel!
    
    
    @IBOutlet weak var pokemon2Skill1: UITextField!
    @IBOutlet weak var pokemon2Skill2: UITextField!
    @IBOutlet weak var pokemon2Skill3: UITextField!
    @IBOutlet weak var pokemon2Skill4: UITextField!
    
    // Control if we need to move the view up or down
    var didMoveKeyboard = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)

        // Get these variables from appdelegate.swift
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        pokemonArray = appDelegate!.pokemonArray
        pokemonSkillArray = appDelegate!.pokemonSkillArray
        
        pokemonSkillPowerDict = appDelegate!.pokemonSkillPowerDict
        pokemonSkillTypeDict = appDelegate!.pokemonSkillTypeDict
        pokemonSkillDamageClassDict = appDelegate!.pokemonSkillDamageClassDict
        
        
        /*
         * Initialize these UI where tag is for contrl
         */
        pokemonPickerView.delegate = self
        pokemonPickerView.dataSource = self
        pokemonPickerView.hidden = true
        
        skillPickerView.delegate = self
        skillPickerView.dataSource = self
        skillPickerView.hidden = true
        
        naturePickerView.delegate = self
        naturePickerView.dataSource = self
        naturePickerView.hidden = true
        
        pokemon1Nature.tag = 91
        pokemon1Nature.delegate = self
        
        pokemon2Nature.tag = 92
        pokemon2Nature.delegate = self
        
        pokemonTextField1.tag = 1
        pokemonTextField1.delegate = self
        
        pokemonTextField2.tag = 2
        pokemonTextField2.delegate = self
        
        pokemon1Skill1.tag = 31
        pokemon1Skill1.delegate = self
        pokemon1Skill2.tag = 32
        pokemon1Skill2.delegate = self
        pokemon1Skill3.tag = 33
        pokemon1Skill3.delegate = self
        pokemon1Skill4.tag = 34
        pokemon1Skill4.delegate = self
        
        pokemon2Skill1.tag = 41
        pokemon2Skill1.delegate = self
        pokemon2Skill2.tag = 42
        pokemon2Skill2.delegate = self
        pokemon2Skill3.tag = 43
        pokemon2Skill3.delegate = self
        pokemon2Skill4.tag = 44
        pokemon2Skill4.delegate = self
        
        // Set stats tag and delegate
        pokemon1HP.tag = 11
        pokemon1HP.delegate = self
        pokemon1HP.text = "0"
        pokemon1HP.keyboardType = UIKeyboardType.NumberPad
        pokemon1ATK.tag = 12
        pokemon1ATK.delegate = self
        pokemon1ATK.text = "0"
        pokemon1ATK.keyboardType = UIKeyboardType.NumberPad
        pokemon1DEF.tag = 13
        pokemon1DEF.delegate = self
        pokemon1DEF.text = "0"
        pokemon1DEF.keyboardType = UIKeyboardType.NumberPad
        pokemon1SPA.tag = 14
        pokemon1SPA.delegate = self
        pokemon1SPA.text = "0"
        pokemon1SPA.keyboardType = UIKeyboardType.NumberPad
        pokemon1SPD.tag = 15
        pokemon1SPD.delegate = self
        pokemon1SPD.text = "0"
        pokemon1SPD.keyboardType = UIKeyboardType.NumberPad
        pokemon1SPE.tag = 16
        pokemon1SPE.delegate = self
        pokemon1SPE.text = "0"
        pokemon1SPE.keyboardType = UIKeyboardType.NumberPad
        
        pokemon2HP.tag = 21
        pokemon2HP.delegate = self
        pokemon2HP.text = "0"
        pokemon2HP.keyboardType = UIKeyboardType.NumberPad
        pokemon2ATK.tag = 22
        pokemon2ATK.delegate = self
        pokemon2ATK.text = "0"
        pokemon2ATK.keyboardType = UIKeyboardType.NumberPad
        pokemon2DEF.tag = 23
        pokemon2DEF.delegate = self
        pokemon2DEF.text = "0"
        pokemon2DEF.keyboardType = UIKeyboardType.NumberPad
        pokemon2SPA.tag = 24
        pokemon2SPA.delegate = self
        pokemon2SPA.text = "0"
        pokemon2SPA.keyboardType = UIKeyboardType.NumberPad
        pokemon2SPD.tag = 25
        pokemon2SPD.delegate = self
        pokemon2SPD.text = "0"
        pokemon2SPD.keyboardType = UIKeyboardType.NumberPad
        pokemon2SPE.tag = 26
        pokemon2SPE.delegate = self
        pokemon2SPE.text = "0"
        pokemon2SPE.keyboardType = UIKeyboardType.NumberPad
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    /*
     * Set Corresponding size of picker view based on the type of picker view
     */
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pokemonPickerView {
             return pokemonArray.count
        }
        else if pickerView == skillPickerView {
            return pokemonSkillArray.count
        }
        else if pickerView == naturePickerView {
            return natureArray.count
        }
        return 1
    }

    /*
     * Set corresponding text of picker view based on the type of pickerview
     */
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pokemonPickerView {
            return pokemonArray[row].name
        }
        else if pickerView == skillPickerView{
            return pokemonSkillArray[row]
        }
        else if pickerView == naturePickerView {
            return natureArray[row]
        }
        return ""
    }
    
    /*
     * Set the corresponding text in different textfield based on the type of textfield and pickerview
     */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if textFieldFlag == 1{
            pokemonTextField1.text = pokemonArray[row].name
            updateFinalLabel1()
            pokemonPickerView.hidden = true
        }
        if textFieldFlag == 2{
            pokemonTextField2.text = pokemonArray[row].name
            updateFinalLabel2()
            pokemonPickerView.hidden = true
        }
        if textFieldFlag == 31 {
            pokemon1Skill1.text = pokemonSkillArray[row]
            skillPickerView.hidden = true
        }
        if textFieldFlag == 32 {
            pokemon1Skill2.text = pokemonSkillArray[row]
            skillPickerView.hidden = true
        }
        if textFieldFlag == 33 {
            pokemon1Skill3.text = pokemonSkillArray[row]
            skillPickerView.hidden = true
        }
        if textFieldFlag == 34 {
            pokemon1Skill4.text = pokemonSkillArray[row]
            skillPickerView.hidden = true
        }
        
        if textFieldFlag == 41 {
            pokemon2Skill1.text = pokemonSkillArray[row]
            skillPickerView.hidden = true
        }
        if textFieldFlag == 42 {
            pokemon2Skill2.text = pokemonSkillArray[row]
            skillPickerView.hidden = true
        }
        if textFieldFlag == 43 {
            pokemon2Skill3.text = pokemonSkillArray[row]
            skillPickerView.hidden = true
        }
        if textFieldFlag == 44 {
            pokemon2Skill4.text = pokemonSkillArray[row]
            skillPickerView.hidden = true
        }
        
        if textFieldFlag == 91 {
            pokemon1Nature.text = natureArray[row]
            resumeStat1()
            updateByNature1()
            naturePickerView.hidden = true
        }
        if textFieldFlag == 92 {
            pokemon2Nature.text = natureArray[row]
            resumeStat2()
            updateByNature2()
            naturePickerView.hidden = true
        }
        
    }
    
    /*
     * Hide corresponding pickerview based on the textfield type and pickerview type
     */
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.tag == 1 {
            pokemonPickerView.hidden = false
            textFieldFlag = 1
        }
        else if textField.tag == 2{
            pokemonPickerView.hidden = false
            textFieldFlag = 2
        }
        else if textField.tag == 31{
            skillPickerView.hidden = false
            textFieldFlag = 31
        }
        else if textField.tag == 32{
            skillPickerView.hidden = false
            textFieldFlag = 32
        }
        else if textField.tag == 33{
            skillPickerView.hidden = false
            textFieldFlag = 33
        }
        else if textField.tag == 34{
            skillPickerView.hidden = false
            textFieldFlag = 34
        }
        else if textField.tag == 41{
            skillPickerView.hidden = false
            textFieldFlag = 41
        }
        else if textField.tag == 42{
            skillPickerView.hidden = false
            textFieldFlag = 42
        }
        else if textField.tag == 43{
            skillPickerView.hidden = false
            textFieldFlag = 43
        }
        else if textField.tag == 44{
            skillPickerView.hidden = false
            textFieldFlag = 44
        }
        else if textField.tag == 91 {
            naturePickerView.hidden = false
            textFieldFlag = 91
        }
        else if textField.tag == 92 {
            naturePickerView.hidden = false
            textFieldFlag = 92
        }
        else {
            assignTextFieldFlag(textField.tag)
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
     * After we edit each corresponding textfield, we update data based on the type of textfield
     * Update the stats of pokemon selected and effort value input(case 11~16, 21~26)
     * Update the stats if nature is selected(case 91, 92)
     * textfield: corresponding textfield end editing
     */
    func textFieldDidEndEditing(textField: UITextField) {
        var pokemon1 = Pokemon()
        var pokemon2 = Pokemon()
        if pokemonTextField1.text != nil {
            pokemon1 = getPokemon(pokemonTextField1)
        }
        if pokemonTextField2.text != nil {
            pokemon2 = getPokemon(pokemonTextField2)
        }
        
        let effortValue = Int((textField.text)!)
        switch textField.tag {
        case 11:
            let pokemonHP = pokemon1.hp
            let result = calcPokemonHP(effortValue!, baseHP: pokemonHP!)
            pokemon1HPFinal.text = String(result)
        case 12:
            let pokemonATK = pokemon1.attack
            let result = calcPokemonStat(effortValue!, baseStat: pokemonATK!)
            pokemon1ATKFinal.text = String(result)
        case 13:
            let pokemonDEF = pokemon1.defense
            let result = calcPokemonStat(effortValue!, baseStat: pokemonDEF!)
            pokemon1DEFFinal.text = String(result)
        case 14:
            let pokemonSPA = pokemon1.specialAttack
            let result = calcPokemonStat(effortValue!, baseStat: pokemonSPA!)
            pokemon1SPAFinal.text = String(result)
        case 15:
            let pokemonSPD = pokemon1.specialDefense
            let result = calcPokemonStat(effortValue!, baseStat: pokemonSPD!)
            pokemon1SPDFinal.text = String(result)
        case 16:
            let pokemonSPE = pokemon1.speed
            let result = calcPokemonStat(effortValue!, baseStat: pokemonSPE!)
            pokemon1SPEFinal.text = String(result)
            
        case 21:
            let pokemonHP2 = pokemon2.hp
            let result = calcPokemonHP(effortValue!, baseHP: pokemonHP2!)
            pokemon2HPFinal.text = String(result)
        case 22:
            let pokemonATK = pokemon2.attack
            let result = calcPokemonStat(effortValue!, baseStat: pokemonATK!)
            pokemon2ATKFinal.text = String(result)
        case 23:
            let pokemonDEF = pokemon2.defense
            let result = calcPokemonStat(effortValue!, baseStat: pokemonDEF!)
            pokemon2DEFFinal.text = String(result)
        case 24:
            let pokemonSPA = pokemon2.specialAttack
            let result = calcPokemonStat(effortValue!, baseStat: pokemonSPA!)
            pokemon2SPAFinal.text = String(result)
        case 25:
            let pokemonSPD = pokemon2.specialDefense
            let result = calcPokemonStat(effortValue!, baseStat: pokemonSPD!)
            pokemon2SPDFinal.text = String(result)
        case 26:
            let pokemonSPE = pokemon2.speed
            let result = calcPokemonStat(effortValue!, baseStat: pokemonSPE!)
            pokemon2SPEFinal.text = String(result)
            
        case 91:
            resumeStat1()
            updateByNature1()
        case 92:
            resumeStat2()
            updateByNature2()
        default: break
        }
        
    }
    
    /*
     * Calculate the damage based on stats of two pokemons, skillpower and the damage class of skill
     * Attack: attack of pokemon
     * Defend: defense of pokemon
     * SPA: special attack of pokemon
     * SPD: special defence of pokemon
     * skillPower: skillpower of pokemon
     * damageClass: damage class of skill, either physical or special
     */
    func calcDamage(attack: Int, defend: Int, spa: Int, spd: Int, makeUp: Double, skillPower: Int, damageClass: String) -> Double {
        if damageClass == "physical" {
            return calcPhysicalDamage(attack, defend: defend, makeUp: makeUp, skillPower: skillPower)
        }
        if damageClass == "special" {
            return calcSpecialDamage(spa, spd: spd, makeUp: makeUp, skillPower: skillPower)
        }
        else {
            return 0.0
        }
    }
    
    // Calculation formula: （100 * 2 / 5 + 2）* skillpower * atk / def / 50 + 2
    
    func calcPhysicalDamage(attack: Int, defend: Int, makeUp: Double, skillPower: Int) -> Double {
        let result =  (42 * skillPower * attack / (defend * 50) + 2)
        let new = Double(result) * makeUp
        return new
    }
    
    func calcSpecialDamage(spa: Int, spd: Int, makeUp: Double, skillPower: Int) -> Double {
        let result =  42 * skillPower * spa / (spd * 50) + 2
        let new = Double(result) * makeUp
        return new
    }
    
    /*
     * Generate calculate result message based on the calculation for pokemon1
     */
    func generateResultMessage1() -> String {
        let HP = Double(pokemon2HPFinal.text!)!
        let damage11 = round(calcDamage11() * 100 / HP * 100) / 100
        let damage12 = round(calcDamage12() * 100 / HP * 100) / 100
        let damage13 = round(calcDamage13() * 100 / HP * 100) / 100
        let damage14 = round(calcDamage14() * 100 / HP * 100) / 100
        let string1 = "Skill 1 -> \(damage11*0.85) ~ \(damage11)%\n"
        let string2 = "Skill 2 -> \(damage12*0.85) ~ \(damage12)%\n"
        let string3 = "Skill 3 -> \(damage13*0.85) ~ \(damage13)%\n"
        let string4 = "Skill 4 -> \(damage14*0.85) ~ \(damage14)%\n"
        let result = "Pokemon1 to Pokemon2: \n" + string1 + string2 + string3 + string4
        print(result)
        return result
    }
    
    /*
     * Generate calculate result message based on the calculation for pokemon2
     */
    func generateResultMessage2() -> String {
        let HP = Double(pokemon1HPFinal.text!)!
        let damage21 = round(calcDamage21() * 100 / HP * 100) / 100
        let damage22 = round(calcDamage22() * 100 / HP * 100) / 100
        let damage23 = round(calcDamage23() * 100 / HP * 100) / 100
        let damage24 = round(calcDamage24() * 100 / HP * 100) / 100
        let string1 = "Skill 1 -> \(damage21*0.85) ~ \(damage21)%\n"
        let string2 = "Skill 2 -> \(damage22*0.85) ~ \(damage22)%\n"
        let string3 = "Skill 3 -> \(damage23*0.85) ~ \(damage23)%\n"
        let string4 = "Skill 4 -> \(damage24*0.85) ~ \(damage24)%\n"
        let result = "Pokemon2 to Pokemon1: \n" + string1 + string2 + string3 + string4
        print(result)
        return result
    }
    
    
    
    /*
     * Move frame up when keyboard covers the textfield
     */
    func keyboardWillShow(notification: NSNotification) {
        if textFieldFlag == 21 || textFieldFlag == 22 || textFieldFlag == 23
        || textFieldFlag == 24 || textFieldFlag == 25 || textFieldFlag == 26{
            if didMoveKeyboard == false {
                if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                    self.view.frame.origin.y -= keyboardSize.height
                    didMoveKeyboard = true
                }
            }
        }
    }
    
    /*
     * Move frame down after keyboard input is done
     */
    func keyboardWillHide(notification: NSNotification) {
        if didMoveKeyboard == true {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.view.frame.origin.y += keyboardSize.height
                didMoveKeyboard = false
            }
        }
    }
    
    /*
     * Assign textfieldflag based on the textfield tag
     * flag: textfield tag
     */
    func assignTextFieldFlag(flag: Int) {
        textFieldFlag = flag
    }
    
    /*
     * Calculate PokemonHP based on effortvalue and baseHP
     * Effortvalue: user input value
     * BaseHP: the base hp of pokemon
     */
    func calcPokemonHP(effortValue: Int, baseHP: Int) -> Int {
        let result = effortValue / 4 + baseHP * 2 + 31 + 110
        return result
    }
    
    /*
     * Calculate Pokemon stats other than HP based on effortvalue and base Stats
     * Effortvalue: user input value
     * BaseStat: the base Stat of pokemon
     */
    func calcPokemonStat(effortValue: Int, baseStat:Int) -> Int {
        let result = effortValue / 4 + baseStat * 2 + 31 + 5
        return result
    }
    
    /*
     * Get pokemon based on the text in the textfield
     * textField: textfield where pokemon name is included in
     */
    func getPokemon(textField: UITextField) -> Pokemon {
        var pokemon = Pokemon()
        if textField.tag == 1 {
            for item in pokemonArray {
                if item.name == textField.text {
                    pokemon = item
                    break
                }
            }
        }
        else if textField.tag == 2 {
            for item in pokemonArray {
                if item.name == textField.text {
                    pokemon = item
                    break
                }
            }
        }
        return pokemon
    }
    
    /*
     * Calculate the additional damage buff based on the skill type of and the type of defense pokemon
     * There are 4 cases: Immune to(0), SuperEffective(2), NotEffective(0.5), Normal(1)
     * type: skill type
     * pokemon: The defense pokemon
     */
    func calcMakeupByType(type: Type, pokemon: Pokemon) -> Double {
        var result = type.calcMultiplier((pokemon.pokemonType1?.pokemonType)!)
        if pokemon.pokemonType2.pokemonType != "" {
            result = result * type.calcMultiplier(pokemon.pokemonType2.pokemonType)
        }
        return result
    }
    
    /*
     * Calculate the damage buff based on the skill type and the type of pokemon which uses the skill
     * If they are the same, we get * 1.5 buff
     * If not, not buff
     * type: skill type
     * pokemon: The pokemon which uses the skill
     */
    func calcSameType(type: Type, pokemon: Pokemon) -> Double {
        var type1 = pokemon.pokemonType1?.pokemonType
        if type.pokemonType == type1 {
            return 1.5
        }
        if pokemon.pokemonType2.pokemonType != "" {
            var type2 = pokemon.pokemonType2.pokemonType
            if type.pokemonType == type2 {
                return 1.5
            }
        }
        return 1.0
    }
    
    /*
     * Here are the calculate damage functions for each skills
     * Pokemon1: Skill1, skill2, skill3, skill4 on pokemon2
     * Pokemon2: Skill1, skill2, skill3, skill4 on pokemon1
     */
    
    
    func calcDamage11() -> Double {
        if pokemon1Skill1.text! == "" {
            return 0.0
        }
        let atk = Int(pokemon1ATKFinal.text!)!
        let def = Int(pokemon2DEFFinal.text!)!
        let spa = Int(pokemon1SPAFinal.text!)!
        let spd = Int(pokemon2SPDFinal.text!)!
        let skillPower = Int(pokemonSkillPowerDict[pokemon1Skill1.text!]!)
        let damageClass = pokemonSkillDamageClassDict[pokemon1Skill1.text!]!
        
        let makeup = calcMakeupByType(pokemonSkillTypeDict[pokemon1Skill1.text!]!, pokemon: getPokemon(pokemonTextField2))
        let sameTypeBuff = calcSameType(pokemonSkillTypeDict[pokemon1Skill1.text!]!, pokemon: getPokemon(pokemonTextField1))
        let damage = calcDamage(atk, defend: def, spa: spa, spd: spd, makeUp: makeup*sameTypeBuff, skillPower: skillPower, damageClass: damageClass)
        return damage
    }
    
    func calcDamage12() -> Double {
        if pokemon1Skill2.text! == "" {
            return 0.0
        }
        let atk = Int(pokemon1ATKFinal.text!)!
        let def = Int(pokemon2DEFFinal.text!)!
        let spa = Int(pokemon1SPAFinal.text!)!
        let spd = Int(pokemon2SPDFinal.text!)!
        let skillPower = Int(pokemonSkillPowerDict[pokemon1Skill2.text!]!)
        let damageClass = pokemonSkillDamageClassDict[pokemon1Skill2.text!]!
        
        let makeup = calcMakeupByType(pokemonSkillTypeDict[pokemon1Skill2.text!]!, pokemon: getPokemon(pokemonTextField2))
        let sameTypeBuff = calcSameType(pokemonSkillTypeDict[pokemon1Skill2.text!]!, pokemon: getPokemon(pokemonTextField1))
        let damage = calcDamage(atk, defend: def, spa: spa, spd: spd, makeUp: makeup*sameTypeBuff, skillPower: skillPower, damageClass: damageClass)
        return damage
    }
    
    func calcDamage13() -> Double {
        if pokemon1Skill3.text! == "" {
            return 0.0
        }
        let atk = Int(pokemon1ATKFinal.text!)!
        let def = Int(pokemon2DEFFinal.text!)!
        let spa = Int(pokemon1SPAFinal.text!)!
        let spd = Int(pokemon2SPDFinal.text!)!
        let skillPower = Int(pokemonSkillPowerDict[pokemon1Skill3.text!]!)
        let damageClass = pokemonSkillDamageClassDict[pokemon1Skill3.text!]!
        
        let makeup = calcMakeupByType(pokemonSkillTypeDict[pokemon1Skill3.text!]!, pokemon: getPokemon(pokemonTextField1))
        let sameTypeBuff = calcSameType(pokemonSkillTypeDict[pokemon1Skill3.text!]!, pokemon: getPokemon(pokemonTextField2))
        let damage = calcDamage(atk, defend: def, spa: spa, spd: spd, makeUp: makeup*sameTypeBuff, skillPower: skillPower, damageClass: damageClass)
        return damage
    }
    
    func calcDamage14() -> Double {
        if pokemon1Skill4.text! == "" {
            return 0.0
        }
        let atk = Int(pokemon1ATKFinal.text!)!
        let def = Int(pokemon2DEFFinal.text!)!
        let spa = Int(pokemon1SPAFinal.text!)!
        let spd = Int(pokemon2SPDFinal.text!)!
        let skillPower = Int(pokemonSkillPowerDict[pokemon1Skill4.text!]!)
        let damageClass = pokemonSkillDamageClassDict[pokemon1Skill4.text!]!
        
        let makeup = calcMakeupByType(pokemonSkillTypeDict[pokemon1Skill4.text!]!, pokemon: getPokemon(pokemonTextField1))
        let sameTypeBuff = calcSameType(pokemonSkillTypeDict[pokemon1Skill4.text!]!, pokemon: getPokemon(pokemonTextField2))
        let damage = calcDamage(atk, defend: def, spa: spa, spd: spd, makeUp: makeup*sameTypeBuff, skillPower: skillPower, damageClass: damageClass)
        return damage
    }
    
    func calcDamage21() -> Double {
        if pokemon2Skill1.text! == "" {
            return 0.0
        }
        let atk = Int(pokemon2ATKFinal.text!)!
        let def = Int(pokemon1DEFFinal.text!)!
        let spa = Int(pokemon2SPAFinal.text!)!
        let spd = Int(pokemon1SPDFinal.text!)!
        let skillPower = Int(pokemonSkillPowerDict[pokemon2Skill1.text!]!)
        let damageClass = pokemonSkillDamageClassDict[pokemon2Skill1.text!]!
        
        let makeup = calcMakeupByType(pokemonSkillTypeDict[pokemon2Skill1.text!]!, pokemon: getPokemon(pokemonTextField1))
        let sameTypeBuff = calcSameType(pokemonSkillTypeDict[pokemon2Skill1.text!]!, pokemon: getPokemon(pokemonTextField2))
        let damage = calcDamage(atk, defend: def, spa: spa, spd: spd, makeUp: makeup*sameTypeBuff, skillPower: skillPower, damageClass: damageClass)
        return damage
    }
    
    func calcDamage22() -> Double {
        if pokemon2Skill2.text! == "" {
            return 0.0
        }
        let atk = Int(pokemon2ATKFinal.text!)!
        let def = Int(pokemon1DEFFinal.text!)!
        let spa = Int(pokemon2SPAFinal.text!)!
        let spd = Int(pokemon1SPDFinal.text!)!
        let skillPower = Int(pokemonSkillPowerDict[pokemon2Skill2.text!]!)
        let damageClass = pokemonSkillDamageClassDict[pokemon2Skill2.text!]!
        
        let makeup = calcMakeupByType(pokemonSkillTypeDict[pokemon2Skill2.text!]!, pokemon: getPokemon(pokemonTextField1))
        let sameTypeBuff = calcSameType(pokemonSkillTypeDict[pokemon2Skill2.text!]!, pokemon: getPokemon(pokemonTextField2))
        let damage = calcDamage(atk, defend: def, spa: spa, spd: spd, makeUp: makeup*sameTypeBuff, skillPower: skillPower, damageClass: damageClass)
        return damage
    }
    
    func calcDamage23() -> Double {
        if pokemon2Skill3.text! == "" {
            return 0.0
        }
        let atk = Int(pokemon2ATKFinal.text!)!
        let def = Int(pokemon1DEFFinal.text!)!
        let spa = Int(pokemon2SPAFinal.text!)!
        let spd = Int(pokemon1SPDFinal.text!)!
        let skillPower = Int(pokemonSkillPowerDict[pokemon2Skill3.text!]!)
        let damageClass = pokemonSkillDamageClassDict[pokemon2Skill3.text!]!
        
        let makeup = calcMakeupByType(pokemonSkillTypeDict[pokemon2Skill3.text!]!, pokemon: getPokemon(pokemonTextField2))
        let sameTypeBuff = calcSameType(pokemonSkillTypeDict[pokemon2Skill3.text!]!, pokemon: getPokemon(pokemonTextField1))
        let damage = calcDamage(atk, defend: def, spa: spa, spd: spd, makeUp: makeup*sameTypeBuff, skillPower: skillPower, damageClass: damageClass)
        return damage
    }
    
    func calcDamage24() -> Double {
        if pokemon2Skill4.text! == "" {
            return 0.0
        }
        let atk = Int(pokemon2ATKFinal.text!)!
        let def = Int(pokemon1DEFFinal.text!)!
        let spa = Int(pokemon2SPAFinal.text!)!
        let spd = Int(pokemon1SPDFinal.text!)!
        let skillPower = Int(pokemonSkillPowerDict[pokemon2Skill4.text!]!)
        let damageClass = pokemonSkillDamageClassDict[pokemon2Skill4.text!]!
        
        let makeup = calcMakeupByType(pokemonSkillTypeDict[pokemon2Skill4.text!]!, pokemon: getPokemon(pokemonTextField2))
        let sameTypeBuff = calcSameType(pokemonSkillTypeDict[pokemon2Skill4.text!]!, pokemon: getPokemon(pokemonTextField1))
        let damage = calcDamage(atk, defend: def, spa: spa, spd: spd, makeUp: makeup*sameTypeBuff, skillPower: skillPower, damageClass: damageClass)
        return damage
    }
    
    
    /*
     * Update final pokemon stats for pokemon1 and 2
     */
    func updateFinalLabel1() {
        pokemon1HPFinal.text = String(calcPokemonHP(0, baseHP:(getPokemon(pokemonTextField1)).hp!))
        pokemon1ATKFinal.text = String(calcPokemonStat(0, baseStat: (getPokemon(pokemonTextField1)).attack!))
        pokemon1DEFFinal.text = String(calcPokemonStat(0, baseStat: (getPokemon(pokemonTextField1)).defense!))
        pokemon1SPAFinal.text = String(calcPokemonStat(0, baseStat: (getPokemon(pokemonTextField1)).specialAttack!))
        pokemon1SPDFinal.text = String(calcPokemonStat(0, baseStat: (getPokemon(pokemonTextField1)).specialDefense!))
        pokemon1SPEFinal.text = String(calcPokemonStat(0, baseStat: (getPokemon(pokemonTextField1)).speed!))
    }
    
    func updateFinalLabel2() {
        pokemon2HPFinal.text = String(calcPokemonHP(0, baseHP:(getPokemon(pokemonTextField2)).hp!))
        pokemon2ATKFinal.text = String(calcPokemonStat(0, baseStat: (getPokemon(pokemonTextField2)).attack!))
        pokemon2DEFFinal.text = String(calcPokemonStat(0, baseStat: (getPokemon(pokemonTextField2)).defense!))
        pokemon2SPAFinal.text = String(calcPokemonStat(0, baseStat: (getPokemon(pokemonTextField2)).specialAttack!))
        pokemon2SPDFinal.text = String(calcPokemonStat(0, baseStat: (getPokemon(pokemonTextField2)).specialDefense!))
        pokemon2SPEFinal.text = String(calcPokemonStat(0, baseStat: (getPokemon(pokemonTextField2)).speed!))
    }
    
    /*
     * Update stats by nature for on pokemon1 and 2
     */
    func updateByNature1(){
        if pokemon1Nature.text == "" {
            return
        }
        let nature = pokemon1Nature.text
        // Attack
        if nature == "Adamant" {
            pokemon1ATKFinal.text = String(Int(Double(pokemon1ATKFinal.text!)! * 1.1))
            pokemon1SPAFinal.text = String(Int(Double(pokemon1SPAFinal.text!)! * 0.9))
        }
        if nature == "Brave" {
            pokemon1ATKFinal.text = String(Int(Double(pokemon1ATKFinal.text!)! * 1.1))
            pokemon1SPEFinal.text = String(Int(Double(pokemon1SPEFinal.text!)! * 0.9))
        }
        if nature == "Lonely" {
            pokemon1ATKFinal.text = String(Int(Double(pokemon1ATKFinal.text!)! * 1.1))
            pokemon1DEFFinal.text = String(Int(Double(pokemon1DEFFinal.text!)! * 0.9))
        }
        if nature == "Naughty" {
            pokemon1ATKFinal.text = String(Int(Double(pokemon1ATKFinal.text!)! * 1.1))
            pokemon1SPDFinal.text = String(Int(Double(pokemon1SPDFinal.text!)! * 0.9))
        }
        
        // Spa
        if nature == "Modest" {
            pokemon1SPAFinal.text = String(Int(Double(pokemon1SPAFinal.text!)! * 1.1))
            pokemon1ATKFinal.text = String(Int(Double(pokemon1ATKFinal.text!)! * 0.9))
        }
        if nature == "Mild" {
            pokemon1SPAFinal.text = String(Int(Double(pokemon1SPAFinal.text!)! * 1.1))
            pokemon1DEFFinal.text = String(Int(Double(pokemon1DEFFinal.text!)! * 0.9))
        }
        if nature == "Quiet" {
            pokemon1SPAFinal.text = String(Int(Double(pokemon1SPAFinal.text!)! * 1.1))
            pokemon1SPEFinal.text = String(Int(Double(pokemon1SPEFinal.text!)! * 0.9))
        }
        if nature == "Rash" {
            pokemon1SPAFinal.text = String(Int(Double(pokemon1SPAFinal.text!)! * 1.1))
            pokemon1SPDFinal.text = String(Int(Double(pokemon1SPDFinal.text!)! * 0.9))
        }
        
        // Spd
        if nature == "Calm" {
            pokemon1SPDFinal.text = String(Int(Double(pokemon1SPDFinal.text!)! * 1.1))
            pokemon1ATKFinal.text = String(Int(Double(pokemon1ATKFinal.text!)! * 0.9))
        }
        if nature == "Gentle" {
            pokemon1SPDFinal.text = String(Int(Double(pokemon1SPDFinal.text!)! * 1.1))
            pokemon1DEFFinal.text = String(Int(Double(pokemon1DEFFinal.text!)! * 0.9))
        }
        if nature == "Careful" {
            pokemon1SPDFinal.text = String(Int(Double(pokemon1SPDFinal.text!)! * 1.1))
            pokemon1SPAFinal.text = String(Int(Double(pokemon1SPAFinal.text!)! * 0.9))
        }
        if nature == "Sassy" {
            pokemon1SPDFinal.text = String(Int(Double(pokemon1SPDFinal.text!)! * 1.1))
            pokemon1SPEFinal.text = String(Int(Double(pokemon1SPEFinal.text!)! * 0.9))
        }
        
        // Speed
        if nature == "Jolly" {
            pokemon1SPEFinal.text = String(Int(Double(pokemon1SPEFinal.text!)! * 1.1))
            pokemon1SPAFinal.text = String(Int(Double(pokemon1SPAFinal.text!)! * 0.9))
        }
        if nature == "Timid" {
            pokemon1SPEFinal.text = String(Int(Double(pokemon1SPEFinal.text!)! * 1.1))
            pokemon1ATKFinal.text = String(Int(Double(pokemon1ATKFinal.text!)! * 0.9))
        }
        if nature == "Naive" {
            pokemon1SPEFinal.text = String(Int(Double(pokemon1SPEFinal.text!)! * 1.1))
            pokemon1SPDFinal.text = String(Int(Double(pokemon1SPDFinal.text!)! * 0.9))
        }
        if nature == "Hasty" {
            pokemon1SPEFinal.text = String(Int(Double(pokemon1SPEFinal.text!)! * 1.1))
            pokemon1DEFFinal.text = String(Int(Double(pokemon1DEFFinal.text!)! * 0.9))
        }
        
        // Def
        if nature == "Bold" {
            pokemon1DEFFinal.text = String(Int(Double(pokemon1DEFFinal.text!)! * 1.1))
            pokemon1ATKFinal.text = String(Int(Double(pokemon1ATKFinal.text!)! * 0.9))
        }
        if nature == "Relaxed" {
            pokemon1DEFFinal.text = String(Int(Double(pokemon1DEFFinal.text!)! * 1.1))
            pokemon1SPDFinal.text = String(Int(Double(pokemon1SPDFinal.text!)! * 0.9))
        }
        if nature == "Lax" {
            pokemon1DEFFinal.text = String(Int(Double(pokemon1DEFFinal.text!)! * 1.1))
            pokemon1SPDFinal.text = String(Int(Double(pokemon1SPDFinal.text!)! * 0.9))
        }
        if nature == "Impish" {
            pokemon1DEFFinal.text = String(Int(Double(pokemon1DEFFinal.text!)! * 1.1))
            pokemon1SPAFinal.text = String(Int(Double(pokemon1SPAFinal.text!)! * 0.9))
        }
    }
    
    func updateByNature2(){
        if pokemon2Nature.text == "" {
            return
        }
        let nature = pokemon2Nature.text
        // Attack
        if nature == "Adamant" {
            pokemon2ATKFinal.text = String(Int(Double(pokemon2ATKFinal.text!)! * 1.1))
            pokemon2SPAFinal.text = String(Int(Double(pokemon2SPAFinal.text!)! * 0.9))
        }
        if nature == "Brave" {
            pokemon2ATKFinal.text = String(Int(Double(pokemon2ATKFinal.text!)! * 1.1))
            pokemon2SPEFinal.text = String(Int(Double(pokemon2SPEFinal.text!)! * 0.9))
        }
        if nature == "Lonely" {
            pokemon2ATKFinal.text = String(Int(Double(pokemon2ATKFinal.text!)! * 1.1))
            pokemon2DEFFinal.text = String(Int(Double(pokemon2DEFFinal.text!)! * 0.9))
        }
        if nature == "Naughty" {
            pokemon2ATKFinal.text = String(Int(Double(pokemon2ATKFinal.text!)! * 1.1))
            pokemon2SPDFinal.text = String(Int(Double(pokemon2SPDFinal.text!)! * 0.9))
        }
        
        // Spa
        if nature == "Modest" {
            pokemon2SPAFinal.text = String(Int(Double(pokemon2SPAFinal.text!)! * 1.1))
            pokemon2ATKFinal.text = String(Int(Double(pokemon2ATKFinal.text!)! * 0.9))
        }
        if nature == "Mild" {
            pokemon2SPAFinal.text = String(Int(Double(pokemon2SPAFinal.text!)! * 1.1))
            pokemon2DEFFinal.text = String(Int(Double(pokemon2DEFFinal.text!)! * 0.9))
        }
        if nature == "Quiet" {
            pokemon2SPAFinal.text = String(Int(Double(pokemon2SPAFinal.text!)! * 1.1))
            pokemon2SPEFinal.text = String(Int(Double(pokemon2SPEFinal.text!)! * 0.9))
        }
        if nature == "Rash" {
            pokemon2SPAFinal.text = String(Int(Double(pokemon2SPAFinal.text!)! * 1.1))
            pokemon2SPDFinal.text = String(Int(Double(pokemon2SPDFinal.text!)! * 0.9))
        }
        
        // Spd
        if nature == "Calm" {
            pokemon2SPDFinal.text = String(Int(Double(pokemon2SPDFinal.text!)! * 1.1))
            pokemon2ATKFinal.text = String(Int(Double(pokemon2ATKFinal.text!)! * 0.9))
        }
        if nature == "Gentle" {
            pokemon2SPDFinal.text = String(Int(Double(pokemon2SPDFinal.text!)! * 1.1))
            pokemon2DEFFinal.text = String(Int(Double(pokemon2DEFFinal.text!)! * 0.9))
        }
        if nature == "Careful" {
            pokemon2SPDFinal.text = String(Int(Double(pokemon2SPDFinal.text!)! * 1.1))
            pokemon2SPAFinal.text = String(Int(Double(pokemon2SPAFinal.text!)! * 0.9))
        }
        if nature == "Sassy" {
            pokemon2SPDFinal.text = String(Int(Double(pokemon2SPDFinal.text!)! * 1.1))
            pokemon2SPEFinal.text = String(Int(Double(pokemon2SPEFinal.text!)! * 0.9))
        }
        
        // Speed
        if nature == "Jolly" {
            pokemon2SPEFinal.text = String(Int(Double(pokemon2SPEFinal.text!)! * 1.1))
            pokemon2SPAFinal.text = String(Int(Double(pokemon2SPAFinal.text!)! * 0.9))
        }
        if nature == "Timid" {
            pokemon2SPEFinal.text = String(Int(Double(pokemon2SPEFinal.text!)! * 1.1))
            pokemon2ATKFinal.text = String(Int(Double(pokemon2ATKFinal.text!)! * 0.9))
        }
        if nature == "Naive" {
            pokemon2SPEFinal.text = String(Int(Double(pokemon2SPEFinal.text!)! * 1.1))
            pokemon2SPDFinal.text = String(Int(Double(pokemon2SPDFinal.text!)! * 0.9))
        }
        if nature == "Hasty" {
            pokemon2SPEFinal.text = String(Int(Double(pokemon2SPEFinal.text!)! * 1.1))
            pokemon2DEFFinal.text = String(Int(Double(pokemon2DEFFinal.text!)! * 0.9))
        }
        
        // Def
        if nature == "Bold" {
            pokemon2DEFFinal.text = String(Int(Double(pokemon2DEFFinal.text!)! * 1.1))
            pokemon2ATKFinal.text = String(Int(Double(pokemon2ATKFinal.text!)! * 0.9))
        }
        if nature == "Relaxed" {
            pokemon2DEFFinal.text = String(Int(Double(pokemon2DEFFinal.text!)! * 1.1))
            pokemon2SPDFinal.text = String(Int(Double(pokemon2SPDFinal.text!)! * 0.9))
        }
        if nature == "Lax" {
            pokemon2DEFFinal.text = String(Int(Double(pokemon2DEFFinal.text!)! * 1.1))
            pokemon2SPDFinal.text = String(Int(Double(pokemon2SPDFinal.text!)! * 0.9))
        }
        if nature == "Impish" {
            pokemon2DEFFinal.text = String(Int(Double(pokemon2DEFFinal.text!)! * 1.1))
            pokemon2SPAFinal.text = String(Int(Double(pokemon2SPAFinal.text!)! * 0.9))
        }
    }
    
    /*
     * Reset pokemon stats for pokemon 1 and pokemon 2 after reselect nature
     */
    func resumeStat1() {
        let pokemon1 = getPokemon(pokemonTextField1)
        let pokemonHP = pokemon1.hp
        let result1 = calcPokemonHP(Int(pokemon1HP.text!)!, baseHP: pokemonHP!)
        pokemon1HPFinal.text = String(result1)
        let pokemonATK = pokemon1.attack
        let result2 = calcPokemonStat(Int(pokemon1ATK.text!)!, baseStat: pokemonATK!)
        pokemon1ATKFinal.text = String(result2)
        let pokemonDEF = pokemon1.defense
        let result3 = calcPokemonStat(Int(pokemon1DEF.text!)!, baseStat: pokemonDEF!)
        pokemon1DEFFinal.text = String(result3)
        let pokemonSPA = pokemon1.specialAttack
        let result4 = calcPokemonStat(Int(pokemon1SPA.text!)!, baseStat: pokemonSPA!)
        pokemon1SPAFinal.text = String(result4)
        let pokemonSPD = pokemon1.specialDefense
        let result5 = calcPokemonStat(Int(pokemon1SPD.text!)!, baseStat: pokemonSPD!)
        pokemon1SPDFinal.text = String(result5)
        let pokemonSPE = pokemon1.speed
        let result6 = calcPokemonStat(Int(pokemon1SPE.text!)!, baseStat: pokemonSPE!)
        pokemon1SPEFinal.text = String(result6)
    }
    
    func resumeStat2() {
        let pokemon2 = getPokemon(pokemonTextField2)
        let pokemonHP = pokemon2.hp
        let result1 = calcPokemonHP(Int(pokemon2HP.text!)!, baseHP: pokemonHP!)
        pokemon2HPFinal.text = String(result1)
        let pokemonATK = pokemon2.attack
        let result2 = calcPokemonStat(Int(pokemon2ATK.text!)!, baseStat: pokemonATK!)
        pokemon2ATKFinal.text = String(result2)
        let pokemonDEF = pokemon2.defense
        let result3 = calcPokemonStat(Int(pokemon2DEF.text!)!, baseStat: pokemonDEF!)
        pokemon2DEFFinal.text = String(result3)
        let pokemonSPA = pokemon2.specialAttack
        let result4 = calcPokemonStat(Int(pokemon2SPA.text!)!, baseStat: pokemonSPA!)
        pokemon2SPAFinal.text = String(result4)
        let pokemonSPD = pokemon2.specialDefense
        let result5 = calcPokemonStat(Int(pokemon2SPD.text!)!, baseStat: pokemonSPD!)
        pokemon2SPDFinal.text = String(result5)
        let pokemonSPE = pokemon2.speed
        let result6 = calcPokemonStat(Int(pokemon2SPE.text!)!, baseStat: pokemonSPE!)
        pokemon2SPEFinal.text = String(result6)
    }
}

