//
//  SnakeNode.swift
//  SnakeTrap
//
//  Created by Couto on 10/23/17.
//  Copyright © 2017 coutocode. All rights reserved.
//

import SpriteKit

class SnakeNode: SKSpriteNode {
    func didMoveToScene(){
        let snakeBodyTexture = SKTexture(imageNamed: "snake-outline")
        parent?.physicsBody = SKPhysicsBody(texture: snakeBodyTexture, size: snakeBodyTexture.size())
    }
}
