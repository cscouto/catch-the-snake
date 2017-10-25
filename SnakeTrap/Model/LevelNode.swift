//
//  MessageNode.swift
//  SnakeTrap
//
//  Created by Couto on 10/24/17.
//  Copyright © 2017 coutocode. All rights reserved.
//

import SpriteKit

class LevelNode: SKLabelNode {
    private var bounceCount = 0
    
    convenience init(message: String) {
        self.init(fontNamed: "AvenirNext-Regular")
        
        text = message
        fontSize = 56
        fontColor = SKColor.gray
        zPosition = 100
        
        let front  = SKLabelNode(fontNamed: "AvenirNext-Regular")
        front.text = message
        front.fontSize = 56
        front.fontColor = SKColor.white
        front.position = CGPoint(x: -2, y: -2)
        addChild(front)
        
        physicsBody = SKPhysicsBody(circleOfRadius: 10)
        physicsBody?.collisionBitMask = PhysicsCategory.Edge
        physicsBody?.categoryBitMask = PhysicsCategory.Label
        physicsBody?.restitution = 0.7
        physicsBody?.contactTestBitMask = PhysicsCategory.Edge
    }
    
    func didBounce(){
        bounceCount += 1
        if (bounceCount >= 4){
            removeFromParent()
        }
    }
}
