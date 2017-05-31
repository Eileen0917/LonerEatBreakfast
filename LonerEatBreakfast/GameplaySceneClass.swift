//
//  GameplaySceneClass.swift
//  LonerEatBreakfast
//
//  Created by Eileen on 2017/5/31.
//  Copyright © 2017年 Eileen. All rights reserved.
//

import SpriteKit

class GameplaySceneClass: SKScene, SKPhysicsContactDelegate {
    
    private var player: Player?
    private var center = CGFloat()
    private var canMove = false, moveLeft = false
    private var itemController = ItemController()
    private var scoreLabel: SKLabelNode?
    private var score = 0
    
    var bgMusic: SKAudioNode!
    var actionMusic: SKAudioNode!
 
    override func didMove(to view: SKView) {
        initializeGame()
        
        if let musicURL = Bundle.main.url(forResource: "If_I_Had_a_Chicken", withExtension: "mp3"){
            bgMusic = SKAudioNode(url: musicURL)
            addChild(bgMusic)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "breakfast" {
            score += 1;
            scoreLabel?.text = String(score)
            secondBody.node?.removeFromParent()
            
            let playAction = SKAction.playSoundFileNamed("crrect_answer1.mp3", waitForCompletion: false)
            run(playAction)
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "trash" {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
            
            let alert = UIAlertView(title: "", message: "You Lose!!!", delegate: self, cancelButtonTitle: "AGAIN!!!")
            alert.show()
            
            let playAction = SKAction.playSoundFileNamed("jump09.mp3", waitForCompletion: false)
            run(playAction)
            
//            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplaySceneClass.restartGame), userInfo: nil, repeats: false)
        }
        
        if (score > 9){
            let alert = UIAlertView(title: "", message: "You Win!!!", delegate: self, cancelButtonTitle: "AGAIN!!!")
            alert.show()
            
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
    }
    
    
    
    
    private func initializeGame() {
        
        physicsWorld.contactDelegate = self
        
        player = childNode(withName: "Player") as? Player!
        player?.initializePlayer()
        
        scoreLabel = childNode(withName: "ScoreLabel") as? SKLabelNode!
        scoreLabel?.text = "0"
        
        center = self.frame.size.width / self.frame.size.height
        
        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 1, secondNum: 2)), target: self, selector: #selector(GameplaySceneClass.spawnItems), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(7), target: self, selector: #selector(GameplaySceneClass.removeItems), userInfo: nil, repeats: true)
        
    }

    
    private func managePlayer() {
        if canMove {
            player?.move(left: moveLeft)
        }
    }
    
    func spawnItems() {
        self.scene?.addChild(itemController.spawnItems())
    }
    
    func restartGame() {
        if let scene = GameplaySceneClass(fileNamed: "GameplayScene") {
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(2)))
        }
    }
    
    func removeItems() {
        for child in children {
            if child.name == "breakfast" || child.name == "trash" {
                if child.position.y < -self.scene!.frame.height - 100 {
                    child.removeFromParent();
                }
            }
        }
    }
    
    func alertView(_ alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        
        restartGame()
    }




}
