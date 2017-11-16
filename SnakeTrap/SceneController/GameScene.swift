//
//  GameScene.swift
//  SnakeTrap
//
//  Created by Couto on 10/19/17.
//  Copyright © 2017 coutocode. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Snake: UInt32 = 0b1
    static let Block: UInt32 = 0b10
    static let Cage: UInt32 = 0b100
    static let Edge: UInt32 = 0b1000
    static let Label: UInt32 = 0b10000
}

var snakeNode: SnakeNode!
var cageNode: CageNode!
var lastLevel = 2
var allowTouches = true

protocol CustomNodeEvent {
    func didMoveToScene()
}

protocol InteractiveNode {
    func interact()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var playable = true
    var currentLevel = 1
    
    class func level(levelNum: Int) -> GameScene? {
        let scene = GameScene(fileNamed: "Level\(levelNum)")!
        scene.currentLevel = levelNum
        scene.scaleMode = .fill
        return scene
    }
    
    override func didMove(to view: SKView) {
        let playableRect = CGRect(x: -size.width/2, y: -size.height/3, width: size.width, height: size.height)
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
        physicsWorld.contactDelegate = self
        physicsBody?.categoryBitMask = PhysicsCategory.Edge
        
        enumerateChildNodes(withName: "//*", using: {
            node, _ in
            if let customNode = node as? CustomNodeEvent {
                customNode.didMoveToScene()
            }
        })
        cageNode = childNode(withName: "cage") as! CageNode
        snakeNode = childNode(withName: "//snake-body") as! SnakeNode
        
        let levelNode = LevelNode(message: "Level: \(currentLevel)")
        levelNode.position = CGPoint(x: -(size.width/2)+100, y: 0)
        self.addChild(levelNode)
        
        let restartButton = SKSpriteNode(imageNamed: "reset-icon")
        restartButton.position = CGPoint(x: (size.width/2)-100, y: -size.height/3)
        restartButton.name = "restart"
        restartButton.setScale(0.6)
        self.addChild(restartButton)
        let rotate = SKAction.rotate(byAngle: 6.28, duration: 1)
        let rotateAction = SKAction.repeat(rotate, count: 1)
        restartButton.run(rotateAction)
        
        SKTAudio.sharedInstance().playBackgroundMusic(filename: "jungle.wav")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if !playable {
            return
        }
        
        if collision == PhysicsCategory.Snake | PhysicsCategory.Cage {
            //print("Success!")
            win()
        }else if collision == PhysicsCategory.Snake | PhysicsCategory.Edge{
            //print("Failed!")
            lose()
            snakeNode.wakeUp()
        }
    }
    
    func inGameMessage(text: String){
        let message  = MessageNode(message: text)
        message.position = CGPoint(x: frame.midX, y: frame.midY+(frame.midY/2))
        addChild(message)
    }
    @objc func newGame(){
        allowTouches = true
        view?.presentScene(GameScene.level(levelNum: currentLevel))
    }
    func win() {
        allowTouches = false
        
        if currentLevel < lastLevel {
            currentLevel += 1
        }else{
            currentLevel = 1
        }
        playable = false
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        run(SKAction.playSoundFileNamed("win.mp3", waitForCompletion: false))
        inGameMessage(text: "Good Job!")
        perform(#selector(GameScene.newGame), with: nil, afterDelay: 4)
    }
    func lose() {
        allowTouches = false
        playable = false
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        run(SKAction.playSoundFileNamed("lose.mp3", waitForCompletion: false))
        inGameMessage(text: "Fail!")
        perform(#selector(GameScene.newGame), with: nil, afterDelay: 4)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch  = touches
        let location = touch.first!.location(in: self)
        let node = self.nodes(at: location).first
        if node?.name == "restart" && allowTouches {
            newGame()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
