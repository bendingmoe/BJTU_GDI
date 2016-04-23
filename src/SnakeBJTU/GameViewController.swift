//
//  GameViewController.swift
//  SnakeBJTU
//
//  Created by Clovis on 30/11/2015.
//  Copyright (c) 2015 Clovis. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var skView = SKView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = MenuScene(size: view.bounds.size)
        skView = view as! SKView
        //skView.showsFPS = true
        //skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>?, withEvent event: UIEvent?) {
  
        if let touch = touches!.first {
            let location = touch.locationInNode(skView.scene!)
            let touchElem = skView.scene!.nodesAtPoint(location)
            for elem in touchElem {
                print(elem.name)
                switch elem.name! {
                    case "replay":
                        print("hein?")
                        let scene = GameScene(size: view.bounds.size)
                        scene.scaleMode = .ResizeFill
                        skView.presentScene(scene)
                    case "menuPlay":
                        let scene = GameScene(size: view.bounds.size)
                        scene.scaleMode = .ResizeFill
                        skView.presentScene(scene)
                    case "menuScore":
                        let scene = ScoreScene(size: view.bounds.size)
                        scene.scaleMode = .ResizeFill
                        skView.presentScene(scene)
                    case "scoreBack":
                        let scene = MenuScene(size: view.bounds.size)
                        scene.scaleMode = .ResizeFill
                        skView.presentScene(scene)
                    case "exitImage":
                        let scene = MenuScene(size: view.bounds.size)
                        scene.scaleMode = .ResizeFill
                        skView.presentScene(scene)
                    default:
                        return
                }
            }
        }
        super.touchesBegan(touches!, withEvent:event)
    }
}
