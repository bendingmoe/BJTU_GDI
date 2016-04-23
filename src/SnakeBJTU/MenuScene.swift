//
//  MenuScene.swift
//  SnakeBJTU
//
//  Created by Clovis on 03/12/2015.
//  Copyright © 2015 Clovis. All rights reserved.
//

import SpriteKit
import UIKit

class MenuScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        var i = 0
        let title = ["THE BINDING", "OF", "SNAKE"]
        var gap = CGFloat(0.85)
        while (i < 3) {
            let titleLabel = SKLabelNode(fontNamed: "Upheaval TT (BRK)")
            titleLabel.position = CGPoint(x: size.width * 0.51, y: size.height * gap)
            titleLabel.text = title[i]
            titleLabel.fontSize = 35
            titleLabel.fontColor = UIColor.blackColor()
            titleLabel.name = "menuTitle"
            titleLabel.zPosition = 0
            self.addChild(titleLabel)
            gap -= 0.1
            i += 1
        }
        
        let playLabel = SKLabelNode(fontNamed: "Upheaval TT (BRK)")
        playLabel.position = CGPoint(x: size.width * 0.51, y: size.height * 0.45)
        playLabel.text = "PLAY"
        playLabel.fontSize = 40
        playLabel.fontColor = UIColor.grayColor()
        playLabel.name = "menuPlay"
        playLabel.zPosition = 0
        self.addChild(playLabel)
        
        let imageViewBack = SKSpriteNode(imageNamed: "backgroundMenu")
        imageViewBack.size = CGSize(width: size.width, height: size.height)
        imageViewBack.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        imageViewBack.name = "background"
        imageViewBack.zPosition = -1
        addChild(imageViewBack)
        
        let scoreImage = SKLabelNode(fontNamed: "Upheaval TT (BRK)")
        scoreImage.position = CGPoint(x: size.width * 0.51, y: size.height * 0.30)
        scoreImage.fontSize = 40
        scoreImage.text = "SCORE"
        scoreImage.fontColor = UIColor.grayColor()
        scoreImage.name = "menuScore"
        scoreImage.zPosition = 3
        self.addChild(scoreImage)
        
        let backgroundMusic = SKAudioNode(fileNamed: "7689.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
    }
}