//
//  CageNode.swift
//  SnakeTrap
//
//  Created by Couto on 10/24/17.
//  Copyright © 2017 coutocode. All rights reserved.
//

import SpriteKit

class CageNode: SKSpriteNode, CustomNodeEvent {
    func didMoveToScene() {
        print("Cage added to the scene...")
        let cageBodySize = CGSize(width: 40, height: 30)
        physicsBody = SKPhysicsBody(rectangleOf: cageBodySize, center: CGPoint(x: 0, y: -100))
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = PhysicsCategory.Cage
        physicsBody?.collisionBitMask = PhysicsCategory.None
    }
}
