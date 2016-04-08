//
//  Type.swift
//  PokemonCalculator
//
//  Created by Yuchen Qian on 4/5/16.
//  Copyright © 2016 Yuchen Qian. All rights reserved.
//

import Foundation

class Type {
    
//     NULL, NORMAL, FIGHTING, FLYING, POISON, GROUND, ROCK, BUG, GHOST,
//    STEEL, FIRE, WATER, GRASS, ELECTRIC, PSYCHIC, ICE, DRAGON, DARK, FAIRY
    
    var pokemonType: String!
    
    var super_effective_against = [String]()
    var not_effective_against = [String]()
    var immune_to = [String]()
    
    func calcSuperEffectiveAgainst(pokemonType:String) -> Array<String> {
        if pokemonType == "NORMAL" {
            super_effective_against = []
        }
        else if pokemonType == "FIGHTING" {
            super_effective_against = ["NORMAL", "ROCK", "STEEL", "ICE", "DARK"]
        }
        else if pokemonType == "FLYING" {
            super_effective_against = ["FIGHTING", "BUG", "GRASS"]
        }
        else if pokemonType == "POISON" {
            super_effective_against = ["FAIRY", "GRASS"]
        }
        else if pokemonType == "GROUND" {
            super_effective_against = ["STEEL", "ELECTRIC", "ROCK", "POISON", "FIRE"]
        }
        else if pokemonType == "ROCK" {
            super_effective_against = ["FLYING", "ICE", "FLYING", "FIRE"]
        }
        else if pokemonType == "BUG" {
            super_effective_against = ["GRASS", "DARK", "PSYCHIC"]
        }
        else if pokemonType == "GHOST" {
            super_effective_against = ["PSYCHIC", "GHOST"]
        }
        else if pokemonType == "STEEL" {
            super_effective_against = ["FAIRY", "ROCK", "ICE"]
        }
        else if pokemonType == "FIRE" {
            super_effective_against = ["ICE", "GRASS", "BUG", "STEEL"]
        }
        else if pokemonType == "WATER" {
            super_effective_against = ["FIRE", "GROUND", "ROCK"]
        }
        else if pokemonType == "GRASS" {
            super_effective_against = ["WATER", "GROUND", "ROCK"]
        }
        else if pokemonType == "ELECTRIC" {
            super_effective_against = ["WATER", "FLYING"]
        }
        else if pokemonType == "PSYCHIC" {
            super_effective_against = ["FIGHTING", "POISON"]
        }
        else if pokemonType == "ICE" {
            super_effective_against = ["DRAGON", "GRASS", "FLYING", "GROUND"]
        }
        else if pokemonType == "DRAGON" {
            super_effective_against = ["DRAGON"]
        }
        else if pokemonType == "DARK" {
            super_effective_against = ["GHOST", "PSYCHIC"]
        }
        else if pokemonType == "FAIRY" {
            super_effective_against = ["DRAGON", "FIGHTING", "DARK"]
        }
        
        return super_effective_against
    }
    
    func calcNotEffectiveAgainst(pokemonType:String) -> Array<String> {
        if pokemonType == "NORMAL" {
            not_effective_against = ["ROCK", "STEEL"]
        }
        else if pokemonType == "FIGHTING" {
            not_effective_against = ["FLYING", "PSYCHIC", "FAIRY", "BUG", "POISON"]
        }
        else if pokemonType == "POISON" {
            not_effective_against = ["ROCK", "GROUND", "GHOST", "POISON"]
        }
        else if pokemonType == "GROUND" {
            not_effective_against = ["GRASS", "BUG"]
        }
        else if pokemonType == "ROCK" {
            not_effective_against = ["GROUND", "STEEL", "FIGHTING"]
        }
        else if pokemonType == "BUG" {
            not_effective_against = ["FIRE", "STEEL", "FLYING", "GHOST", "POISON", "FAIRY", "FIGHTING"]
        }
        else if pokemonType == "GHOST" {
            not_effective_against = ["DARK"]
        }
        else if pokemonType == "STEEL" {
            not_effective_against = ["FIRE", "STEEL", "ELECTRIC", "WATER"]
        }
        else if pokemonType == "FIRE" {
            not_effective_against = ["ROCK", "DRAGON", "FIRE", "WATER"]
        }
        else if pokemonType == "WATER" {
            not_effective_against = ["GRASS", "WATER", "DRAGON"]
        }
        else if pokemonType == "GRASS" {
            not_effective_against = ["DRAGON", "STEEL", "BUG", "POISON", "FLYING", "FIRE", "GRASS"]
        }
        else if pokemonType == "ELECTRIC" {
            not_effective_against = ["ELECTRIC", "GRASS", "DRAGON"]
        }
        else if pokemonType == "PSYCHIC" {
            not_effective_against = ["STEEL", "PSYCHIC"]
        }
        else if pokemonType == "ICE" {
            not_effective_against = ["ICE", "WATER", "FIRE", "STEEL"]
        }
        else if pokemonType == "DRAGON" {
            not_effective_against = ["STEEL"]
        }
        else if pokemonType == "DARK" {
            not_effective_against = ["DARK", "FIGHTING", "FAIRY"]
        }
        else if pokemonType == "FAIRY" {
            not_effective_against = ["POISON", "STEEL", "FIRE"]
        }
        
        return not_effective_against
    }
    
    func calcImmuneTo(pokemonType: String) -> Array<String> {
        if pokemonType == "NROMAL" {
            immune_to = ["GHOST"]
        }
        else if pokemonType == "FLYING" {
            immune_to = ["GROUND"]
        }
        else if pokemonType == "GROUND" {
            immune_to = ["ELECTRIC"]
        }
        else if pokemonType == "GHOST" {
            immune_to = ["NORMAL", "FIGHTING"]
        }
        else if pokemonType == "STEEL" {
            immune_to = ["POISON"]
        }
        else if pokemonType == "DARK" {
            immune_to = ["PSYCHIC"]
        }
        else if pokemonType == "FAIRY" {
            immune_to = ["DRAGON"]
        }
        else {
            immune_to = []
        }
        
        return immune_to
    }
    
    func isSuperEffectiveAgainst(pokemonType: String) -> Bool {
        return calcSuperEffectiveAgainst(self.pokemonType).contains(pokemonType)
    }
    
    func isNotEffectiveAgainst(pokemonType: String) -> Bool {
        return calcNotEffectiveAgainst(self.pokemonType).contains(pokemonType)
    }
    
    func isImmuneTo(pokemonType: String) -> Bool {
        return calcImmuneTo(self.pokemonType).contains(pokemonType)
    }
    
    func calcMultiplier(pokemonType: String) -> Double {
        if self.isImmuneTo(pokemonType) {
            return 0.0
        }
        else if self.isSuperEffectiveAgainst(pokemonType) {
            return 2.0
        }
        else if self.isNotEffectiveAgainst(pokemonType) {
            return 0.5
        }
        else {
            return 1.0
        }
    }
    
    init(str:String){
        pokemonType = str
    }
    
    

    
}


