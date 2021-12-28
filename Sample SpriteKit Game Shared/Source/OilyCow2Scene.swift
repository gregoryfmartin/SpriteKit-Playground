//
//  OilyCow2Scene.swift
//  Sample SpriteKit Game
//
//  Created by Gregory Martin on 12/26/21.
//

import SpriteKit

class OilyCow2Scene: SKScene {
    fileprivate var oilyCow2Label: SKLabelNode?
    
    class func newOilyCow2Scene() -> OilyCow2Scene {
        guard let scene = SKScene(fileNamed: "OilyCow2Scene") as? OilyCow2Scene else {
            print("Failed to use OilyCow2Scene.sks file")
            abort()
        }
        
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    func setUpScene() {
        self.oilyCow2Label = self.childNode(withName: "//oilyCow2Label") as? SKLabelNode
        if let ocl = self.oilyCow2Label {
            ocl.run(
                SKAction.sequence(
                    [SKAction.moveTo(y: 0.0, duration: 4.0),
                     SKAction.playSoundFileNamed("Bios Boot", waitForCompletion: true),
                     SKAction.wait(forDuration: 2.0),
                     SKAction.run {
                         let reveal = SKTransition.fade(withDuration: 3.0)
                         let sts = SampleTitleScene.newSampleTitleScene()
                         self.view?.presentScene(sts, transition: reveal)
                     }
                    ]
                )
            )
        }
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
}
