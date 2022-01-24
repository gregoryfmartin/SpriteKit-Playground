//
//  GunwomanSprite.swift
//  Sample SpriteKit Game
//
//  Created by Gregory Martin on 1/23/22.
//

import SpriteKit

class GunwomanSprite: SKSpriteNode {
    enum GunwomanActions: String, CaseIterable {
       case idle = "Idle"
    }
    
    enum GunwomanDirections: String, CaseIterable {
        case left = "Left"
        case right = "Right"
    }
    
    private var idleLeftFrames: [SKTexture]
    private var idleRightFrames: [SKTexture]
    private var currentAnimation: String
    var action: GunwomanActions
    var direction: GunwomanDirections {
        set {
            switch newValue {
            case .left:
                switch self.action {
                case .idle:
                    self.run(SKAction.repeatForever(SKAction.animate(with: self.idleLeftFrames, timePerFrame: 0.18, resize: false, restore: true)))
                    break
                }
                break
            case .right:
                switch self.action {
                case .idle:
                    self.run(SKAction.repeatForever(SKAction.animate(with: self.idleRightFrames, timePerFrame: 0.18, resize: false, restore: true)))
                    break
                }
                break
            }
        }
        get {
            self.direction
        }
    }
    
    init() {
        self.idleLeftFrames = []
        self.idleRightFrames = []
        self.currentAnimation = ""
        self.action = .idle
        //self.direction = .right
        
        super.init(texture: nil, color: .white, size: .zero)
        
        buildFrames()
        self.run(SKAction.repeatForever(SKAction.animate(with: self.idleRightFrames, timePerFrame: 0.5, resize: false, restore: true)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.idleLeftFrames = []
        self.idleRightFrames = []
        self.currentAnimation = ""
        self.action = .idle
        //self.direction = .right
        
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
        
        buildFrames()
        self.run(SKAction.repeatForever(SKAction.animate(with: self.idleRightFrames, timePerFrame: 0.18, resize: false, restore: true)))
    }
    
    private func buildFrames() {
        let idleLeftAtlas = SKTextureAtlas(named: "Gunwoman Idle Left")
        let idleRightAtlas = SKTextureAtlas(named: "Gunwoman Idle Right")
        
        // Load the idle left frames
        for i in 1...idleLeftAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Idle Left 00\(i)"
            } else {
                tname = "Gunwoman Idle Left 0\(i)"
            }
            idleLeftFrames.append(idleLeftAtlas.textureNamed(tname))
        }
        
        // Load the idle right frames
        for i in 1...idleRightAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Idle Right 00\(i)"
            } else {
                tname = "Gunwoman Idle Right 0\(i)"
            }
            idleRightFrames.append(idleRightAtlas.textureNamed(tname))
        }
    }
    
    func updateAction(actionName: GunwomanActions) {
        self.action = actionName
        
        // TODO: Add code to adjust the animation sequence here
    }
}
