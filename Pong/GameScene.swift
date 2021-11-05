//
//  GameScene.swift
//  Pong
//
//  Created by Alberto Dominguez on 11/5/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: Peoperties
    
    // Nodes
    var playerNode = SKSpriteNode()
    var enemyNode = SKSpriteNode()
    var ball = SKSpriteNode()
    
    
    // MARK: Life Cycle
    override func didMove(to view: SKView) {
        playerNode = self.childNode(withName: "player") as! SKSpriteNode
        enemyNode = self.childNode(withName: "enemy") as! SKSpriteNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode

        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        
        let boarder = SKPhysicsBody(edgeLoopFrom: self.frame)
        boarder.friction = 0
        boarder.restitution = 0
        
        self.physicsBody = boarder
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        let moveEnemy = SKAction.moveTo(x: ball.position.x, duration: 0.25)
        
        enemyNode.run(moveEnemy)
    }
}


// MARK: Touches
extension GameScene {
    /// when user touches screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            let mvoePlayer = SKAction.moveTo(x: touchLocation.x, duration: 0.25)
            playerNode.run(mvoePlayer)
        }
    }
    
    /// when user touches and moves finger (drags)
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            let mvoePlayer = SKAction.moveTo(x: touchLocation.x, duration: 0.25)
            playerNode.run(mvoePlayer)
        }
    }
}
