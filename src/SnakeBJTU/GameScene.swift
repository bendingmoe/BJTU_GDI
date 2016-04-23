//
//  GameScene.swift
//  SnakeBJTU
//
//  Created by Clovis on 30/11/2015.
//  Copyright (c) 2015 Clovis. All rights reserved.
//

import SpriteKit
import UIKit


class GameScene: SKScene {
    //MARK: Property
    
    var snakeList = [Snake]()
    var lifeList = [Life]()
    var createList = [toCreate]()
    var scoreLabel = SKLabelNode(fontNamed: "Upheaval TT (BRK)")
    var score = 0
    var end = false
    var pause = false
    var firstSwipedGesture = true
    var obstacle = false
    
    struct toCreate {
        var direction:Snake.currentDirection
        var position:CGPoint
    }
    
    //MARK: Gesture Recognizer
    
    override func touchesBegan(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if let touch = touches!.first {
            let location = touch.locationInNode(self)
            let touchPause = nodesAtPoint(location)
            
            for item in touchPause {
                if (item.name == "pause" || item.name == "playImage" ) {
                    if (pause == false) {
                        let imageViewBack = SKSpriteNode(imageNamed: "backgroundPause")
                        imageViewBack.size = CGSize(width: size.width, height: size.height)
                        imageViewBack.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
                        imageViewBack.name = "backgroundPause"
                        imageViewBack.zPosition = 3
                        addChild(imageViewBack)
                        
                        let playImage = SKLabelNode(fontNamed: "Upheaval TT (BRK)")
                        playImage.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
                        playImage.name = "playImage"
                        playImage.text = "RESUME GAME"
                        playImage.fontColor = UIColor.blackColor()
                        playImage.fontSize = 35
                        playImage.zPosition = 4
                        addChild(playImage)
                        
                        let exitImage = SKLabelNode(fontNamed: "Upheaval TT (BRK)")
                        exitImage.position = CGPoint(x: size.width * 0.5, y: size.height * 0.3)
                        exitImage.name = "exitImage"
                        exitImage.text = "EXIT GAME"
                        exitImage.fontColor = UIColor.blackColor()
                        exitImage.fontSize = 25
                        exitImage.zPosition = 4
                        addChild(exitImage)

                        
                        /*let replayImage = SKSpriteNode(imageNamed: "replayImage")
                        replayImage.position = CGPoint(x: size.width * 0.9, y: size.height * 0.6)
                        replayImage.name = "replay"
                        replayImage.zPosition = 3
                        addChild(replayImage)
                        */
                        pause = true
                        for elem in snakeList{
                            elem.paused = true
                        }
                        
                    } else {
                        self.childNodeWithName("exitImage")?.removeFromParent()
                        self.childNodeWithName("backgroundPause")?.removeFromParent()
                        self.childNodeWithName("playImage")?.removeFromParent()
                        pause = false
                        for elem in snakeList{
                            elem.paused = false
                        }
                    }
                }
                
            }
        }
        super.touchesBegan(touches!, withEvent:event)
    }
    
    func beginActionMove(snake:Snake, moveTo: Snake.currentDirection) {
        
        if (snake.snakeHead == true) {
            for item in snakeList {
                if (item.snakeHead == false) {
                    item.moveList.append(Snake.move(until: snake.position, to: moveTo))
                    
                    if (firstSwipedGesture == true) {
                        let distance = distanceBetweenPoints(item.position, b:CGPoint(x: size.width, y: item.position.y))
                        let time = timeToTravelDistance(distance, speed: item.snakeSpeed!)
                    
                        let actionMove = SKAction.moveTo(CGPoint(x: size.width, y: item.position.y), duration: time)
                        item.runAction(actionMove)
                    }
                }
            }
            firstSwipedGesture = false
            
        }
        
        switch moveTo {
        case .right:
            let distance = distanceBetweenPoints(snake.position, b:CGPoint(x: size.width, y: snake.position.y))
            let time = timeToTravelDistance(distance, speed: snake.snakeSpeed!)

            if (snake.snakeHead == true) {
                snakeList[0].texture = SKTexture(imageNamed: "snakeHeadRight")
            }
            snake.removeAllActions()
            let actionMove = SKAction.moveTo(CGPoint(x: size.width, y: snake.position.y), duration: time)
            snake.runAction(actionMove)

        case .left:
            let distance = distanceBetweenPoints(snake.position, b:CGPoint(x: 0, y: snake.position.y))
            let time = timeToTravelDistance(distance, speed: snake.snakeSpeed!)
            
            if (snake.snakeHead == true) {
                snakeList[0].texture = SKTexture(imageNamed: "snakeHeadLeft")
            }
            snake.removeAllActions()
            let actionMove = SKAction.moveTo(CGPoint(x: 0, y: snake.position.y), duration: time)
            snake.runAction(actionMove)
        case .up:

            let distance = distanceBetweenPoints(snake.position, b:CGPoint(x: snake.position.x, y: size.height))
            let time = timeToTravelDistance(distance, speed: snake.snakeSpeed!)
            
            if (snake.snakeHead == true) {
                snakeList[0].texture = SKTexture(imageNamed: "snakeHeadUp")
            }
            snake.removeAllActions()
            let actionMove = SKAction.moveTo(CGPoint(x: snake.position.x, y: size.height), duration: time)
            snake.runAction(actionMove)
        case .down:
            let distance = distanceBetweenPoints(snake.position, b:CGPoint(x: snake.position.x, y: 0))
            let time = timeToTravelDistance(distance, speed: snake.snakeSpeed!)
            
            if (snake.snakeHead == true) {
                snakeList[0].texture = SKTexture(imageNamed: "snakeHeadDown")
            }
            snake.removeAllActions()
            let actionMove = SKAction.moveTo(CGPoint(x: snake.position.x, y: 0), duration: time)
            snake.runAction(actionMove)
        default:print("error 1")
        }
    }
    
    func swipedRight(sender:UISwipeGestureRecognizer) {
        if (snakeList[0].snakeDirection != .left) {
            snakeList[0].snakeDirection = .right
            beginActionMove(snakeList[0], moveTo: .right)
        }
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer) {
        if (snakeList[0].snakeDirection != .right && snakeList[0].snakeDirection != .notdefined) {
            snakeList[0].snakeDirection = .left
            beginActionMove(snakeList[0], moveTo: .left)
        }
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer) {
        if (snakeList[0].snakeDirection != .down) {
            snakeList[0].snakeDirection = .up
            beginActionMove(snakeList[0], moveTo: .up)
        }
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer) {
        if (snakeList[0].snakeDirection != .up) {
            snakeList[0].snakeDirection = .down
            beginActionMove(snakeList[0], moveTo: .down)
        }
    }
    
    func updateSnakeTail() {
        for elem in snakeList {
            elem.snakeTail = false
        }
        snakeList[snakeList.count - 1].snakeTail = true
    }
    
    func closePoints(x:CGPoint, y:CGPoint) -> Bool{
        let a = abs(x.x - y.x)
        let b = abs(x.y - y.y)
        
        if (a + b < 5) {
            return true
        }
        return false
    }
    
    
    func positionToOtherEdge(snake: Snake) {
        
        if ((snake.position.x == 0 && snake.snakeDirection == .left) || (snake.position.y == 0 && snake.snakeDirection == .down ) || (snake.position.x >= size.width - 1 && snake.snakeDirection == .right) || (snake.position.y == size.height && snake.snakeDirection == .up)) {
                switch snake.snakeDirection {
                case .right:
                    snake.position.x = 0
                    beginActionMove(snake, moveTo: .right)
                case .left:
                    snake.position.x = size.width
                    beginActionMove(snake, moveTo: .left)
                case .up:
                    snake.position.y = 0
                    beginActionMove(snake, moveTo: .up)
                case .down:
                    snake.position.y = size.height
                    beginActionMove(snake, moveTo: .down)
                default: print("error 2")
                }
        }

    }
    
    func gameOver() {
        if (end == false) {
            let imageViewBack = SKSpriteNode(imageNamed: "backgroundDeath")
            imageViewBack.size = CGSize(width: size.width, height: size.height)
            imageViewBack.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
            imageViewBack.name = "backgroundDeath"
            imageViewBack.zPosition = 3
            addChild(imageViewBack)
            end = true
            childNodeWithName("pause")?.hidden = true
            
            let scoreFinal = SKLabelNode(fontNamed: "Upheaval TT (BRK)")
            scoreFinal.position = CGPoint(x: size.width * 0.5, y: size.height * 0.7)
            scoreFinal.name = "scoreFinal"
            scoreFinal.text = String(score)
            scoreFinal.fontColor = UIColor.whiteColor()
            scoreFinal.fontSize = 80
            scoreFinal.zPosition = 4
            addChild(scoreFinal)
            
            let exitImage = SKLabelNode(fontNamed: "Upheaval TT (BRK)")
            exitImage.position = CGPoint(x: size.width * 0.5, y: size.height * 0.3)
            exitImage.name = "exitImage"
            exitImage.text = "EXIT GAME"
            exitImage.fontColor = UIColor.whiteColor()
            exitImage.fontSize = 25
            exitImage.zPosition = 4
            addChild(exitImage)
            
            let replayImage = SKLabelNode(fontNamed: "Upheaval TT (BRK)")
            replayImage.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
            replayImage.name = "replay"
            replayImage.text = "RESTART GAME"
            replayImage.fontColor = UIColor.whiteColor()
            replayImage.fontSize = 30
            replayImage.zPosition = 4
            addChild(replayImage)

            self.childNodeWithName("ambianceMusic")!.removeFromParent()
            
            let backgroundMusic = SKAudioNode(fileNamed: "06-conflicted.mp3")
            backgroundMusic.autoplayLooped = true
            addChild(backgroundMusic)

            
            var player = [Player]()
            if let load = NSKeyedUnarchiver.unarchiveObjectWithFile(Player.ArchiveURL.path!) as? [Player] {
            let tmp = Player(name: "Player " + String(load.count + 1), score: score)
            
            for item in load {
                player.append(item)
            }
            
            player.append(tmp!)
            } else {
                player.append(Player(name: "Player 1", score: score)!)
            }
            NSKeyedArchiver.archiveRootObject(player, toFile: Player.ArchiveURL.path!)
            for elem in snakeList{
                elem.paused = true
            }
        }

    }
    
    
    override func update(currentTime: NSTimeInterval) {
        
        for item in snakeList {
            positionToOtherEdge(item)
            if (item.snakeHead == false) {
                if (item.moveList.count > 0 && closePoints(item.moveList[0].until, y: item.position) == true) {
                    //let to = item.moveList[0].to
                    item.snakeDirection = item.moveList[0].to
                    switch item.snakeDirection {
                    case .right:
                        item.position = CGPoint(x:snakeList[item.order - 1].position.x - 25, y:item.moveList[0].until.y)
                    case .left:
                        item.position = CGPoint(x:snakeList[item.order - 1].position.x + 25, y:item.moveList[0].until.y)
                    case .up:
                        item.position = CGPoint(x:item.moveList[0].until.x, y:snakeList[item.order - 1].position.y - 25)
                    case .down:
                        item.position = CGPoint(x:item.moveList[0].until.x, y:snakeList[item.order - 1].position.y + 25)
                    default:
                        print("error 3")
                    }
                    item.moveList.removeFirst()
                    beginActionMove(item, moveTo: item.snakeDirection)
                }
            }
        }
     
        
        let distWidth = snakeList[0].calculateAccumulatedFrame().width / 3
        let distHeight = snakeList[0].calculateAccumulatedFrame().height / 3
        
        switch snakeList[0].snakeDirection {
        case .right:
            if (nodesAtPoint(CGPoint(x: snakeList[0].position.x + distWidth, y: snakeList[0].position.y)).count > 1) {
                for elem in nodesAtPoint(CGPoint(x: snakeList[0].position.x, y: snakeList[0].position.y)) {
                    if (elem.name == "life" && lifeList.count == 1 && elem == lifeList[0]) {
                        elem.removeFromParent()
                        lifeList.removeAll()
                        score += 10
                        updateLabel()
                        addNewLife()
                        addQueue(snakeList[0])
                    
                    }
                    else if (elem != snakeList[1] && elem != snakeList[0] && elem.name == "body") {
                        gameOver()
                        print(elem.name)
                        print("touch right")
                    }
                }
                
                
            }
        case .left:
            if (nodesAtPoint(CGPoint(x: snakeList[0].position.x - distWidth, y: snakeList[0].position.y)).count > 1) {
                for elem in nodesAtPoint(CGPoint(x: snakeList[0].position.x, y: snakeList[0].position.y)) {
                    if (elem.name == "life" && lifeList.count == 1 && elem == lifeList[0]) {
                        elem.removeFromParent()
                        lifeList.removeAll()
                        score += 10
                        updateLabel()
                        addNewLife()
                        addQueue(snakeList[0])
                    }
                    else if (elem != snakeList[1] && elem != snakeList[0] && elem.name == "body") {
                        gameOver()
                        print(elem.name)
                        print("touch left")
                    }
                }
            }
        case .up:
            if (nodesAtPoint(CGPoint(x: snakeList[0].position.x, y: snakeList[0].position.y + distHeight)).count > 1) {
                for elem in nodesAtPoint(CGPoint(x: snakeList[0].position.x, y: snakeList[0].position.y)) {
                    if (elem.name == "life" && lifeList.count == 1 && elem == lifeList[0]) {
                        elem.removeFromParent()
                        lifeList.removeAll()
                        score += 10
                        updateLabel()
                        addNewLife()
                        addQueue(snakeList[0])
                    }
                    else if (elem != snakeList[1] && elem != snakeList[0] && elem.name == "body") {
                        gameOver()
                        print(elem.name)
                        print("touch up")
                    }
                }
            }
        case .down:
            if (nodesAtPoint(CGPoint(x: snakeList[0].position.x, y: snakeList[0].position.y - distHeight)).count > 1) {
                for elem in nodesAtPoint(CGPoint(x: snakeList[0].position.x, y: snakeList[0].position.y)) {
                    if (elem.name == "life" && lifeList.count == 1 && elem == lifeList[0]) {
                        elem.removeFromParent()
                        lifeList.removeAll()
                        score += 10
                        updateLabel()
                        addNewLife()
                        addQueue(snakeList[0])
                    }
                    else if (elem != snakeList[1] && elem != snakeList[0] && elem.name == "body") {
                        gameOver()
                        print(elem.name)
                        print("touch down")
                    }
                }
            }
        default:
            return
        }
        
        
        if (createList.count > 0) {
            
            var tailedSnake:Snake = snakeList[snakeList.count - 1]
            
            //updateSnakeTail()
            for elem in snakeList {
                if (elem.snakeTail == true) {
                    tailedSnake = elem
                }
            }
            
            switch createList[0].direction {
            case .right:
                if (closePoints(CGPoint(x: tailedSnake.position.x, y: tailedSnake.position.y), y:CGPoint(x: createList[0].position.x , y: createList[0].position.y)) == true) {
                    let newSnake = Snake(isHead: false, order: tailedSnake.order + 1)
                    snakeList.append(newSnake)
                    newSnake.position = createList[0].position
                    newSnake.snakeDirection = createList[0].direction
                    newSnake.moveList = tailedSnake.moveList
                    updateSnakeTail()
                    createList.removeFirst()
                    addChild(newSnake)
                    beginActionMove(newSnake, moveTo: newSnake.snakeDirection)
                    
                }
                
            case .left:
                if (closePoints(CGPoint(x: tailedSnake.position.x, y: tailedSnake.position.y), y:CGPoint(x: createList[0].position.x, y: createList[0].position.y)) == true) {
                    let newSnake = Snake(isHead: false, order: tailedSnake.order + 1)
                    snakeList.append(newSnake)
                    newSnake.position = createList[0].position
                    newSnake.snakeDirection = createList[0].direction
                    newSnake.moveList = tailedSnake.moveList
                    updateSnakeTail()
                    createList.removeFirst()
                    addChild(newSnake)
                    beginActionMove(newSnake, moveTo: newSnake.snakeDirection)
                }

            case .up:
                if (closePoints(CGPoint(x: tailedSnake.position.x, y: tailedSnake.position.y), y:CGPoint(x: createList[0].position.x, y: createList[0].position.y)) == true) {
                    let newSnake = Snake(isHead: false, order: tailedSnake.order + 1)
                    snakeList.append(newSnake)
                    newSnake.position = createList[0].position
                    newSnake.snakeDirection = createList[0].direction
                    newSnake.moveList = tailedSnake.moveList
                    updateSnakeTail()
                    createList.removeFirst()
                    addChild(newSnake)
                    beginActionMove(newSnake, moveTo: newSnake.snakeDirection)
                }
            case .down:
                if (closePoints(CGPoint(x: tailedSnake.position.x, y: tailedSnake.position.y), y:CGPoint(x: createList[0].position.x, y: createList[0].position.y)) == true) {
                    let newSnake = Snake(isHead: false, order: tailedSnake.order + 1)
                    snakeList.append(newSnake)
                    newSnake.position = createList[0].position
                    newSnake.snakeDirection = createList[0].direction
                    newSnake.moveList = tailedSnake.moveList
                    updateSnakeTail()
                    createList.removeFirst()
                    addChild(newSnake)
                    beginActionMove(newSnake, moveTo: newSnake.snakeDirection)
                }
            default:
                print("error 6")
            }
            
        }
        
    }
    
    
    //MARK: Tool Functions
    
    func distanceBetweenPoints(a: CGPoint, b: CGPoint) -> CGFloat {
        return sqrt((b.x - a.x)*(b.x - a.x) + (b.y - a.y)*(b.y - a.y))
    }
    func timeToTravelDistance(distance: CGFloat, speed: CGFloat) -> NSTimeInterval {
        let time = distance / speed
        return NSTimeInterval(time)
    }
    func updateLabel() {
        scoreLabel.text = "Score : " + String(score)
    }
    func addNewLife() {
        
        let x = CGFloat(arc4random_uniform(86)) + 10
        let y = CGFloat(arc4random_uniform(86)) + 10
        
        let life = Life()
        life.position = CGPoint(x: size.width * (x / 100), y: size.height * (y / 100))
    
        if (nodesAtPoint(life.position).count > 1) {
            addNewLife()
        }
        else {
            lifeList.append(life)
            self.addChild(life)
        }
    
    }
    
    func addQueue(snake:Snake) {
        createList.append(toCreate(direction:snake.snakeDirection, position:snake.position))
    }
    
    
    //MARK: SK Function
    
    override func didMoveToView(view: SKView) {
        
        snakeList.append(Snake(isHead: true, order: 0))
        snakeList[0].position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        for var number = 1; number < 4; number++ {
            snakeList.append(Snake(isHead: false, order: number))
            snakeList[number].position = CGPoint(x: snakeList[number - 1].position.x - (52.75 / 2), y: snakeList[number - 1].position.y)
            snakeList[number].snakeDirection = .right
        }
        updateSnakeTail()

        let imageViewBack = SKSpriteNode(imageNamed: "backgroundGame")
        imageViewBack.size = CGSize(width: size.width, height: size.height)
        imageViewBack.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        imageViewBack.name = "background"
        imageViewBack.zPosition = -1
        addChild(imageViewBack)
        
        let pauseButton = SKSpriteNode(imageNamed: "pauseImage")
        pauseButton.position = CGPoint(x: size.width * 0.05, y: size.height * 0.93)
        pauseButton.name = "pause"
        pauseButton.zPosition = 3
        addChild(pauseButton)
        
        
        scoreLabel.text = "Score : 0"
        scoreLabel.fontSize = 15
        scoreLabel.zPosition = 3
        scoreLabel.position = CGPoint(x: size.width * 0.87, y: size.height * 0.9)
        self.addChild(scoreLabel)
        
        
        let backgroundMusic = SKAudioNode(fileNamed: "05-sacrificial.mp3")
        backgroundMusic.autoplayLooped = true
        backgroundMusic.name = "ambianceMusic"
        addChild(backgroundMusic)

        
        for item in snakeList {
            addChild(item)
        }
        
        addNewLife()
        
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
        
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedUp:"))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedDown:"))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)

        
    }
    
}
