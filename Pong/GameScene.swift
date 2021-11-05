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
    var playerNode: SKNode?
    var enemyNode: SKNode?
    var ball: SKNode?
    
    
    // MARK: Life Cycle
    override func didMove(to view: SKView) {
        self.playerNode = childNode(withName: "player")!
        self.enemyNode = childNode(withName: "enemy")!
        self.ball = childNode(withName: "ball")!

        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


// MARK: Touches
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("hi")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("hi")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("hi")
    }
}
