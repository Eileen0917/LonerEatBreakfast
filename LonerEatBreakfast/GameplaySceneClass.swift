//
//  GameplaySceneClass.swift
//  LonerEatBreakfast
//
//  Created by Eileen on 2017/5/31.
//  Copyright © 2017年 Eileen. All rights reserved.
//

import SpriteKit

class GameplaySceneClass: SKScene {
    
    private var player: Player?
    
    private var center = CGFloat()
    
    private var canMove = false, moveLeft = false

 
    override func didMove(to view: SKView) {
        initializeGame()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
    }
    
    private func initializeGame() {
        
        player = childNode(withName: "Player") as? Player!        
        
        center = self.frame.size.width / self.frame.size.height
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.x > center {
                moveLeft = false
            } else {
                moveLeft = true
            }
        }
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
    }
    
    private func managePlayer() {
        if canMove {
            player?.move(left: moveLeft)
        }
    }

}
