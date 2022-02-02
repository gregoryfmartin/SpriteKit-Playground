//
//  GameViewController.swift
//  Sample SpriteKit Game macOS
//
//  Created by Gregory Martin on 12/25/21.
//

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let scene = GameScene.newGameScene()
//        let scene = SKScene(fileNamed: "GBLAScene")
//        print("Creating a GBLA Scene")
//        let scene = GBLAScene()
//        let scene = SampleTitleScene.newSampleTitleScene()
        let scene = TileMapScene.newTileMapScene()
        scene.setupScene()
//        let scene = UserControlledCameraScene.newUserControlledCameraScene()
//        let scene = ActionDemoScene()
        
        // Present the scene
//        print("Presenting the GBLA Scene")
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

}

