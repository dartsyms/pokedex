//
//  PokeMove.swift
//  Pokedex
//
//  Created by sanchez on 23.12.15.
//  Copyright © 2015 KOT LLC. All rights reserved.
//

import Foundation
import Alamofire

class PokeMove {
    private var _name: String!
    private var _moveId: String!
    private var _accuracy: String!
    private var _description: String!
    private var _power: String!
    private var _learnType: String!
    private var _category: String!
    private var _moveUrl: String!
    
    init(name: String, moveId: String, learnType: String) {
        self._name = name
        self._moveId = moveId
        self._learnType = learnType
        self._moveUrl = "\(URL_BASE)\(URL_MOVE)\(self.moveId)/"
    }
    
    var name: String {
        return _name
    }
    
    var moveId: String {
        return _moveId
    }
    
    var description: String {
        if _description == nil {
            _description = "None"
        }
        return _description
    }
    
    var accuracy: String {
        if _accuracy == nil {
            _accuracy = "-"
        }
        return _accuracy
    }
    
    var power: String {
        if _power == nil {
            _power = "-"
        }
        return _power
    }
    
    var learnType: String {
        if _learnType == nil {
            _learnType = "-"
        }
        return _learnType
    }
    
    var category: String {
        if _category == nil {
            _category = "None"
        }
        return _category
    }
    
    func downloadPokeMoveDetails(completed: DownloadComplete) {
        let url = NSURL(string: _moveUrl)!
        Alamofire.request(Method.GET, url).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let accuracy = dict["accuracy"] as? Int {
                    self._accuracy = "\(accuracy)"
                }
                
                if let description = dict["description"] as? String {
                    self._description = description
                }
                
                if let power = dict["power"] as? Int {
                    self._power = "\(power)"
                }
                
                if let category = dict["category"] as? String {
                    self._category = category
                }
            }
            completed()
        }
    }
    
}