//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by sanchez on 21.12.15.
//  Copyright © 2015 KOT LLC. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    @IBOutlet weak var chooseSegment: UISegmentedControl!
    // for fields' titles
    @IBOutlet weak var moveName: UILabel!
    @IBOutlet weak var moveCategory: UILabel!
    @IBOutlet weak var moveLevelType: UILabel!
    @IBOutlet weak var movePower: UILabel!
    @IBOutlet weak var moveID: UILabel!
    @IBOutlet weak var moveAccuracy: UILabel!
    
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name.capitalizedString
        mainImage.image = UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
    }
    
    func updateUI() {
        moveName.text = "Poke Type: "
        movePower.text = "Defense: "
        moveCategory.text = "Height: "
        moveID.text = "Pokedex ID: "
        moveLevelType.text = "Weight: "
        moveAccuracy.text = "Base Attack: "

        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type.capitalizedString
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        baseAttackLabel.text = pokemon.attack
        pokedexLabel.text = "\(pokemon.pokedexId)"
        if pokemon.nextEvolutionId == "" {
            evoLabel.text = "No Evolution"
            nextEvoImage.hidden = true
        } else {
            nextEvoImage.hidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionText)"
            if pokemon.nextEvolutionLevel != "" {
                str += " - LVL \(pokemon.nextEvolutionLevel)"
            }
            evoLabel.text = str
        }
        
    }
    
    func showArbitraryMove() {
        let idx = Int(arc4random_uniform(UInt32(pokemon.moves.count)))
        let move = pokemon.moves[idx]
        descriptionLabel.text = move.description
        
        moveName.text = "Move Name: "
        typeLabel.text = move.name
        
        movePower.text = "Power: "
        defenseLabel.text = move.power + " pp"
        
        moveCategory.text = "Category: "
        if move.category != "" {
            heightLabel.text = move.category
        } else {
            heightLabel.text = "-"
        }
        
        
        moveID.text = "Move ID: "
        pokedexLabel.text = move.moveId
        
        moveLevelType.text = "Learn Type: "
        weightLabel.text = move.learnType.capitalizedString
        
        moveAccuracy.text = "Accuracy: "
        baseAttackLabel.text = move.accuracy + "%"
    }

    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func selectedSegmentAction(sender: UISegmentedControl) {
        if sender == chooseSegment {
            switch sender.selectedSegmentIndex {
            case 0:
                updateUI()
            case 1:
                showArbitraryMove()
            default:
                break
            }
        }
    }

}
