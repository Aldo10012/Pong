//
//  GameScene.swift
//  Pong
//
//  Created by Alberto Dominguez on 11/5/21.
//

import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: Peoperties
    
    // Nodes
    var playerNode = SKSpriteNode()
    var enemyNode = SKSpriteNode()
    var ball = SKSpriteNode()
    
    // Bools
    var playerWins: Bool?
    
    // Scores   [playerScore, enemyScore]
    var playerScore: Int = 0
    var enemyScore: Int = 0
    
    
    // MARK: Life Cycle
    override func didMove(to view: SKView) {
        playerNode = self.childNode(withName: "player") as! SKSpriteNode
        enemyNode = self.childNode(withName: "enemy") as! SKSpriteNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode

        configurePhysicsBody()
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        
        startGame()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        let moveEnemy = SKAction.moveTo(x: ball.position.x, duration: 0.25)
        
        enemyNode.run(moveEnemy)
        checkIfSomeoneMissedTheBall()
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

// MARK: Game Mechanics
extension GameScene {
    
    func startGame() {
        playerScore = 0
        enemyScore = 0
    }
    
    func checkIfSomeoneMissedTheBall() {
        
        /// enemy missed ball, player gets pooint
        if ball.position.y > enemyNode.position.y {
            playerScore += 1
            backToCenter()
            applyNewImpulse()
            print("SCORES: player \(playerScore), enemy \(enemyScore)")
            
        }
        /// player missed ball, enemy gets pooint
        else if ball.position.y < playerNode.position.y {
            enemyScore += 1
            backToCenter()
            applyNewImpulse()
            print("SCORES: player \(playerScore), enemy \(enemyScore)")
        }
    }
    
    func backToCenter() {
        ball.position = CGPoint(x: 0, y: 0)
    }
    
    func applyNewImpulse() {
        // a^2 + b^2 = c^2
        // dx-1, dy=b, hyp=c
        
        let hyp = 200.squareRoot()
        let dx = Double.random(in: -hyp...hyp)
        let dy = (200 - pow(dx, 2)).squareRoot()
        
        let c = pow(dx,2) + pow(dy,2)
        print(c)
        
        
        ball.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
        
    }
    
    
    func configurePhysicsBody() {
        let boarder = SKPhysicsBody(edgeLoopFrom: self.frame)
        boarder.friction = 0
        boarder.restitution = 0
        
        self.physicsBody = boarder
    }
}


// MARK: Math
/*
 
 applyNewImpulse()
 Math to create vectors with random angle but with same speed.
 
          *       c^2 = a^2  + b^2
         **       c^2 = 10^2 + 10^2
   c   *  *       c^2 = 100  + 100
     *    * b     c^2 = 200
   *      *         c = √200
 **********         c ≈ 14.142 or 200.squareRoot()
      a
 
 a=10, b=10
 a=dx, b=dy
 
 Vectors require dx and dy (same as a & b)
 thy hyposonuse MUST ALWAYS be √200
 
 let hyp = √200
 
 -hyp ≤ a ≤ hyp
 
 c^2 = a^2 + b^2
 200 = a^2 + b^2
 200 - a^2 = b^2
 200 - (dx)^2 = (dy)^2
 dy = (200 - (dx)^2).squareRoot()
 
 
 */

