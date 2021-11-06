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
    
    // Label
    var playerScoreLabel = SKLabelNode()
    var enemyScoreLabel = SKLabelNode()
    
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
        playerScoreLabel = self.childNode(withName: "playerScorelabel") as! SKLabelNode
        enemyScoreLabel = self.childNode(withName: "enemyScorelabel") as! SKLabelNode


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
        playerScoreLabel.text = "\(playerScore)"
        enemyScoreLabel.text = "\(enemyScore)"
    }
    
    func checkIfSomeoneMissedTheBall() {
        
        /// enemy missed ball, player gets pooint
        if ball.position.y > enemyNode.position.y {
            playerScore += 1
            playerScoreLabel.text = "\(playerScore)"
            backToCenter()
            applyNewImpulse(winner: playerNode)
            print("SCORES: player \(playerScore), enemy \(enemyScore)")
            
        }
        /// player missed ball, enemy gets pooint
        else if ball.position.y < playerNode.position.y {
            enemyScore += 1
            enemyScoreLabel.text = "\(enemyScore)"
            backToCenter()
            applyNewImpulse(winner: enemyNode)
            print("SCORES: player \(playerScore), enemy \(enemyScore)")
        }
    }
    
    func backToCenter() {
        ball.position = CGPoint(x: 0, y: 0)
    }
    
    func applyNewImpulse(winner: SKSpriteNode) {
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        switch winner {
        case playerNode:
            let vactors: [CGVector] = [
                CGVector(dx: -10, dy: -10),
                CGVector(dx:  10, dy: -10)
            ]
            
            ball.physicsBody?.applyImpulse(vactors.randomElement()!)

        case enemyNode:
            let vactors: [CGVector] = [
                CGVector(dx: -10, dy: 10),
                CGVector(dx: +10, dy: 10)
            ]
            
            ball.physicsBody?.applyImpulse(vactors.randomElement()!)

        default:break
        }
    }
    
    func configurePhysicsBody() {
        let boarder = SKPhysicsBody(edgeLoopFrom: self.frame)
        boarder.friction = 0
        boarder.restitution = 0
        
        self.physicsBody = boarder
    }
}
