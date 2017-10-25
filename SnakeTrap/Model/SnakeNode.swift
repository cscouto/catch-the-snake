//
//  SnakeNode.swift
//  SnakeTrap
//
//  Created by Couto on 10/23/17.
//  Copyright © 2017 coutocode. All rights reserved.
//

import SpriteKit

class SnakeNode: SKSpriteNode, CustomNodeEvent {
    func didMoveToScene(){
        let snakeBodyTexture = SKTexture(imageNamed: "snake-outline")
        parent?.physicsBody = SKPhysicsBody(texture: snakeBodyTexture, size: snakeBodyTexture.size())
        
        parent?.physicsBody?.categoryBitMask = PhysicsCategory.Snake
        parent?.physicsBody?.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Edge
        
        parent?.physicsBody?.contactTestBitMask = PhysicsCategory.Cage | PhysicsCategory.Edge
    }
    
    func wakeUp(){
        for child in children {
            child.removeFromParent()
        }
        texture = nil
        color = SKColor.clear
        
        let snakeAwake = SKSpriteNode(fileNamed: "SnakeWakeup")?.childNode(withName: "snake-awake")!
        snakeAwake?.move(toParent: self)
        snakeAwake?.position = CGPoint(x: 0, y: 50)
    }
}
