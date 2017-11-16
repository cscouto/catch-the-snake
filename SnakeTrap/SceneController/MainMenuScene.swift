//
//  MainMenuScene.swift
//  SnakeTrap
//
//  Created by Couto on 10/25/17.
//  Copyright © 2017 coutocode. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "welcomescreen")
        background.size = CGSize(width: self.size.width, height: self.size.height)
        background.position = CGPoint(x: self.size.width/2, y: self.size.width/2)
        self.addChild(background)
    }
    func sceneTapped(){
        let myScene = GameScene.level(levelNum: 1)
        myScene?.scaleMode = .fill
        let reveal = SKTransition.doorway(withDuration: 0.8)
        self.view?.presentScene(myScene!, transition: reveal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneTapped()
    }
}
