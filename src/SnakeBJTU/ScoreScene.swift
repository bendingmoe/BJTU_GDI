//
//  ScoreScene.swift
//  SnakeBJTU
//
//  Created by Kevin Fandi on 03/12/2015.
//  Copyright © 2015 Clovis. All rights reserved.
//

import SpriteKit
import UIKit

class ScoreScene: SKScene {
    
    //MARK: Properties
    
    var scores = [Player]()
    
    override func didMoveToView(view: SKView) {
        
        let imageViewBack = SKSpriteNode(imageNamed: "backgroundMenu")
        imageViewBack.size = CGSize(width: size.width, height: size.height)
        imageViewBack.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        imageViewBack.name = "background"
        imageViewBack.zPosition = -1
        addChild(imageViewBack)
        
        let backLabel = SKLabelNode(fontNamed: "Upheaval TT (BRK)")
        backLabel.text = "BACK"
        backLabel.fontColor = UIColor.blackColor()
        backLabel.name = "scoreBack"
        backLabel.position = CGPoint(x: size.width * 0.12, y: size.height * 0.88)
        addChild(backLabel)
        
        let backgroundMusic = SKAudioNode(fileNamed: "01-those-responsible.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        let player = NSKeyedUnarchiver.unarchiveObjectWithFile(Player.ArchiveURL.path!) as? [Player]
        if var scores = player {
        
        scores.sortInPlace { (element1, element2) -> Bool in
            return element1.score > element2.score
        }
        
        var count = 0
        var i = CGFloat(0.9)
        
        while (count < 7 && count < scores.count) {
                let scoreLabel = SKLabelNode(fontNamed: "Upheaval TT (BRK)")
                scoreLabel.fontColor = UIColor.blackColor()
                scoreLabel.text = scores[count].name + " \t\t " + String(scores[count].score)
                scoreLabel.fontSize = 15
                scoreLabel.position = CGPoint(x: size.width * 0.5, y: size.height * i)
                self.addChild(scoreLabel)
                i -= 0.1;
                count++
        }
        }

    }
    
    func deleteView() {
        self.removeAllActions()
        self.removeAllChildren()
    }
    
}
