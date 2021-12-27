//
//  OilyCowScene.swift
//  Sample SpriteKit Game
//
//  Created by Gregory Martin on 12/26/21.
//

import SpriteKit

class OilyCowScene: SKScene {
    fileprivate var oilyCowLabel: SKLabelNode = SKLabelNode(text: "Oily Cow")
    
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
        oilyCowLabel.fontSize = 200.0
        oilyCowLabel.fontName = "Menlo"
        oilyCowLabel.color = .white
        oilyCowLabel.position = CGPoint(x: self.frame.width / 2.0, y: self.frame.height + oilyCowLabel.frame.height)
        
        self.addChild(oilyCowLabel)
    }
    
    override func didMove(to view: SKView) {
        oilyCowLabel.run(
            SKAction.sequence(
                [SKAction.moveTo(y: self.frame.height / 2.0 - (oilyCowLabel.frame.height / 2.0), duration: 4.0),
                 SKAction.playSoundFileNamed("Bios Boot.wav", waitForCompletion: true),
                 SKAction.wait(forDuration: 2.0)
                ]
            )
        )
    }
}
