//
//  Player.swift
//  LonerEatBreakfast
//
//  Created by Eileen on 2017/5/31.
//  Copyright © 2017年 Eileen. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    private var minX = CGFloat(-200), maxX = CGFloat(200)
    
    func initializePlayer() {
        
        name = "Player"
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = ColliderType.PLAYER
        physicsBody?.contactTestBitMask = ColliderType.BREAKFAST_AND_TRASH
    }
    
    func move(left: Bool) {
        
        if left {
            
            position.x -= 15
            
            if position.x < minX {
                position.x = minX
            }
            
        } else {
            
            position.x += 15
            
            if position.x > maxX {
                position.x = maxX
            }
        }
    }
    
}

