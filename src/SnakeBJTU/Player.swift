//
//  Player.swift
//  SnakeBJTU
//
//  Created by Kevin Fandi on 02/12/2015.
//  Copyright © 2015 Clovis. All rights reserved.
//

import UIKit

class Player: NSObject, NSCoding {
    
    var name: String
    var score: Int
    
    init?(name: String, score: Int) {
        self.name = name
        self.score = score
        
        super.init()
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("scores")
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let scoreKey = "score"
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeInteger(score, forKey: PropertyKey.scoreKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let score = aDecoder.decodeIntegerForKey(PropertyKey.scoreKey)
        
        // Must call designated initilizer.
        self.init(name: name, score: score)
    }

}