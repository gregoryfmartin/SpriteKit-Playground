//
//  SampleTitleScene.swift
//  Sample SpriteKit Game
//
//  Created by Gregory Martin on 12/27/21.
//

import SpriteKit

class SampleTitleScene: SKScene {
    fileprivate var gameTitleQuitLabel: SKLabelNode?
    fileprivate var gameTitleOptionsLabel: SKLabelNode?
    fileprivate var gameTitlePlayLabel: SKLabelNode?
    fileprivate var gameTitleLabel: SKLabelNode?
    fileprivate var gameTitleBgAudio: SKAudioNode?
    fileprivate var gameTitleBgSprite: SKSpriteNode?
    
    class func newSampleTitleScene() -> SampleTitleScene {
        guard let scene = SKScene(fileNamed: "SampleTitleScene") as? SampleTitleScene else {
            print("Failed to use SampleTitleScene.sks file")
            abort()
        }
        
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    func setupScene() {
        self.gameTitleBgAudio = self.childNode(withName: "//gameTitleBgAudio") as? SKAudioNode
    }
    
    override func didMove(to view: SKView) {
        self.setupScene()
    }
}
