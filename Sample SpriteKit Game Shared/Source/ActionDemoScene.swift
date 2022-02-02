//
//  ActionDemoScene.swift
//  Sample SpriteKit Game
//
//  Created by Gregory Martin on 1/30/22.
//

import SpriteKit

class ActionDemoScene: SKScene {
    override init() {
        super.init(size: CGSize(width: 1366, height: 1024))
        super.scaleMode = .aspectFill
        super.backgroundColor = .black
        
        setupScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScene() {
        print("setupScene function encountered")
    }
    
    override func update(_ currentTime: TimeInterval) {
        print("update function encountered")
    }
}
