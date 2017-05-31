//
//  ItemController.swift
//  LonerEatBreakfast
//
//  Created by Eileen on 2017/5/31.
//  Copyright © 2017年 Eileen. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let PLAYER: UInt32 = 0
    static let BREAKFAST_AND_TRASH: UInt32 = 1
}


class ItemController {
    
    private var minX = CGFloat(-200), maxX = CGFloat(200)
    
    func spawnItems() -> SKSpriteNode {
        let item: SKSpriteNode?
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 10)) >= 6 {
            
            item = SKSpriteNode(imageNamed: "trash")
            item!.name = "trash"
            item!.setScale(0.1)
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2)
        } else {
            
            item = SKSpriteNode(imageNamed: "breakfast")
            item!.name = "breakfast"
            item!.setScale(0.2)
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2)
        }
        
        item!.physicsBody?.categoryBitMask = ColliderType.BREAKFAST_AND_TRASH
        
        item!.zPosition = 3
        item!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        item!.position.x = randomBetweenNumbers(firstNum: minX, secondNum: maxX)
        item!.position.y = 500

        return item!
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
