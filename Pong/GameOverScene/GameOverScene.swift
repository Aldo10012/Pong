//
//  GameOverScene.swift
//  Pong
//
//  Created by Alberto Dominguez on 11/8/21.
//

import Foundation
import SpriteKit
import GameplayKit

class GameOverScene: SKScene {
    
    // MARK: Peoperties
    

    
    
    // MARK: Life Cycle
    override func didMove(to view: SKView) {
        print("game over")
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}


// MARK: Touches
extension GameOverScene {
    /// when user touches screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                
        
    }
    
    /// when user touches and moves finger (drags)
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
