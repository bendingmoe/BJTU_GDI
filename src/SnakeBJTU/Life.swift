//
//  Life.swift
//  SnakeBJTU
//
//  Created by Clovis on 01/12/2015.
//  Copyright © 2015 Clovis. All rights reserved.
//

import SpriteKit

class Life: SKSpriteNode {

    var newlyCreated: Bool
    var hasBeenTouched: Bool
    
    init() {
        let texture = SKTexture(imageNamed: "lifeItem")
        
        self.hasBeenTouched = false
        self.newlyCreated = true
        
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: texture.size().width, height: texture.size().height))
        
        self.name = "life"
        self.zPosition = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
