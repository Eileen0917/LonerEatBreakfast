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
    
    func spawnItems() -> SKSpriteNode {
        let item: SKSpriteNode?
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 10)) >= 6 {
            
            item = SKSpriteNode(imageNamed: "trash")
            item!.name = "trash"
            item!.setScale(0.6)
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2)
        } else {
            
            item = SKSpriteNode(imageNamed: "breakfast")
            item!.name = "breakfast"
            item!.setScale(0.7)
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2)
        }

        return item!
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
