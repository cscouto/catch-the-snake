//
//  GameScene.swift
//  SnakeTrap
//
//  Created by Couto on 10/19/17.
//  Copyright © 2017 coutocode. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol CustomNodeEvent {
    func didMoveToScene()
}

protocol InteractiveNode {
    func interact()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var snakeNode: SnakeNode!
    
    override func didMove(to view: SKView) {
        let playableRect = CGRect(x: -size.width/2, y: -size.height/3, width: size.width, height: size.height)
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
        physicsWorld.contactDelegate = self
        enumerateChildNodes(withName: "//*", using: {
            node, _ in
            if let customNode = node as? CustomNodeEvent {
                customNode.didMoveToScene()
            }
        })
        
        snakeNode = childNode(withName: "//snake-body") as! SnakeNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
