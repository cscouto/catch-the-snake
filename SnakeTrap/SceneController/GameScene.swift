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

class GameScene: SKScene {
    
    var snakeNode: SnakeNode!
    
    override func didMove(to view: SKView) {
        enumerateChildNodes(withName: "//*", using: {
            node, _ in
            if let customNode = node as? CustomNodeEvent {
                customNode.didMoveToScene()
            }
        })
        
        snakeNode = childNode(withName: "//snake_body") as! SnakeNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
