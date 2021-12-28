//
//  GBLAScene.swift
//  Sample SpriteKit Game macOS
//
//  Created by Gregory Martin on 12/25/21.
//

import SpriteKit

class GBLAScene: SKScene {
    fileprivate var nintendoLabel: SKLabelNode = SKLabelNode(text: "Nimtendu")
    
    override init() {
        super.init(size: CGSize(width: 1366, height: 1024))
        super.scaleMode = .aspectFill
        super.backgroundColor = .black
        
        setUpScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpScene() {
        nintendoLabel.fontSize = 200.0
        nintendoLabel.fontName = "Menlo"
        nintendoLabel.color = .white
        nintendoLabel.position = CGPoint(x: self.frame.width / 2.0, y: self.frame.height + nintendoLabel.frame.height)
        
        self.addChild(nintendoLabel)
    }
    
    override func didMove(to view: SKView) {
        nintendoLabel.run(
            SKAction.sequence(
                [SKAction.moveTo(y: self.frame.height / 2.0 - (nintendoLabel.frame.height / 2.0), duration: 4.0),
                 SKAction.playSoundFileNamed("Bios Boot.wav", waitForCompletion: true),
                 SKAction.wait(forDuration: 2.0),
                 SKAction.run({
                     let reveal = SKTransition.fade(withDuration: 3.0)
                     let ocScene = OilyCow2Scene.newOilyCow2Scene()
                     ocScene.setUpScene()
                     self.view?.presentScene(ocScene, transition: reveal)
                 })
                ]
            )
        )
    }
}

#if os(iOS) || os(tvOS)
// Event handling for iOS and tvOS platforms
#endif

#if os(OSX)
// Event handling for OSX platform
#endif

// Event handling for all platforms
