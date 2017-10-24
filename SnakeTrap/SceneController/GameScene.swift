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

protocol CustomNodeEvent {
    func didMoveToScene()
}

protocol InteractiveNode {
    func interact()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var playable = true
    
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
        }
    }
    
    func inGameMessage(text: String){
        let message  = MessageNode(message: text)
        message.position = CGPoint(x: frame.midX, y: frame.midY+(frame.midY/2))
        addChild(message)
    }
    func win() {
        playable = false
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        run(SKAction.playSoundFileNamed("win.mp3", waitForCompletion: false))
        inGameMessage(text: "Good Job!")
    }
    func lose() {
        playable = false
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        run(SKAction.playSoundFileNamed("lose.mp3", waitForCompletion: false))
        inGameMessage(text: "Fail!")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
