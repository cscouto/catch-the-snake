//
//  BlockNode.swift
//  SnakeTrap
//
//  Created by Couto on 10/24/17.
//  Copyright © 2017 coutocode. All rights reserved.
//

import SpriteKit

class BlockNode: SKSpriteNode, CustomNodeEvent, InteractiveNode {
    
    func didMoveToScene() {
        isUserInteractionEnabled = true
    }
    
    func interact(){
        isUserInteractionEnabled = false
        run(SKAction.sequence([SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false), SKAction.scale(by: 0.8, duration: 0.1), SKAction.removeFromParent()]))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
}
