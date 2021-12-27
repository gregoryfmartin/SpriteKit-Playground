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
//        if let ocl = self.oilyCow2Label {
//            ocl.run(SKAction.sequence([SKAction.init(named: "SlideToCenter", duration: 4.0)!, SKAction.init(named: "PlayBing")!]))
//        }
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
}
