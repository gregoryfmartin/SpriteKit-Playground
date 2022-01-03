//
//  TileMapScene.swift
//  Sample SpriteKit Game
//
//  Created by Gregory Martin on 1/1/22.
//

import SpriteKit

class TileMapScene: SKScene {
    class func newTileMapScene() -> TileMapScene {
        guard let scene = SKScene(fileNamed: "TileMapScene") as? TileMapScene else {
            print("Failed to use TileMapScene.sks file")
            abort()
        }
        
        scene.scaleMode = .aspectFill
        
        return scene
    }
}
