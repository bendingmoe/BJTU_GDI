//
//  Snake.swift
//  SnakeBJTU
//
//  Created by Clovis on 30/11/2015.
//  Copyright © 2015 Clovis. All rights reserved.
//

import SpriteKit

class Snake: SKSpriteNode {

    //MARK: Properties
    let snakeSpeed:CGFloat?
    let order:Int
    var previousPoint: CGPoint?
    var snakeHead: Bool
    var snakeTail: Bool
    var moveList = [move]()
    
    struct move {
        var until : CGPoint
        var to : currentDirection
        
        init(until:CGPoint, to:currentDirection) {
            self.until = until
            self.to = to
        }
    }
    
    enum currentDirection: Int {
        case right
        case left
        case up
        case down
        case notdefined
    }
    
    var snakeDirection: currentDirection
    
    init(isHead:Bool, order:Int) {
        var texture = SKTexture(imageNamed: "snakeBody")
        if (isHead == true){
            texture = SKTexture(imageNamed: "snakeHeadRight")
        }
        
        self.snakeDirection = currentDirection.notdefined
        self.snakeSpeed = 200.0
        self.snakeHead = isHead
        self.order = order
        self.snakeTail = false
    
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: texture.size().width, height: texture.size().height))
        
        self.zPosition = 1
        if (self.snakeHead == true) {
            self.zPosition = 2
            self.name = "head"
        }
        else {
            self.name = "body"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

