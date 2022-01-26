//
//  GunwomanSprite.swift
//  Sample SpriteKit Game
//
//  Created by Gregory Martin on 1/23/22.
//

import SpriteKit

class GunwomanSprite: SKSpriteNode {
    enum GunwomanState: CaseIterable {
        case idleRight
        case idleLeft
        case walkRight
        case walkLeft
        case shootRight
        case shootLeft
    }
    
//    enum GunwomanActions: String, CaseIterable {
//        case idle = "Idle"
//        case walk = "Walk"
//        case none = "None"
//    }
//
//    enum GunwomanDirections: String, CaseIterable {
//        case left = "Left"
//        case right = "Right"
//        case none = "None"
//    }
//
    enum GunwomanAnimations: String, CaseIterable {
        case idleLeft = "Gunwoman Idle Left"
        case idleRight = "Gunwoman Idle Right"
        case walkLeft = "Gunwoman Walk Left"
        case walkRight = "Gunwoman Walk Right"
        case none = "None"
    }
    
    static let DirectionLeft: Int = 0
    static let DirectionRight: Int = 1
    
    private var idleLeftFrames: [SKTexture] = []
    private var idleRightFrames: [SKTexture] = []
    private var walkLeftFrames: [SKTexture] = []
    private var walkRightFrames: [SKTexture] = []
    var direction: [Bool] = [false, false]
    var state: GunwomanState = .idleRight
    
    init() {
        super.init(texture: nil, color: .white, size: .zero)
        
        buildFrames()
        self.state = .idleRight
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        buildFrames()
        self.state = .idleRight
    }
    
    func update(_ currentTime: TimeInterval) {
        switch self.state {
        case .idleRight:
            if self.action(forKey: GunwomanAnimations.idleRight.rawValue) == nil {
                self.run(SKAction.repeatForever(SKAction.animate(with: self.idleRightFrames, timePerFrame: 0.15, resize: false, restore: true)), withKey: GunwomanAnimations.idleRight.rawValue)
            }
            break
        case .idleLeft:
            if self.action(forKey: GunwomanAnimations.idleLeft.rawValue) == nil {
                self.run(SKAction.repeatForever(SKAction.animate(with: self.idleLeftFrames, timePerFrame: 0.15, resize: false, restore: true)), withKey: GunwomanAnimations.idleLeft.rawValue)
            }
            break
        case .walkRight:
            if self.action(forKey: GunwomanAnimations.walkRight.rawValue) == nil {
                self.run(SKAction.repeatForever(SKAction.animate(with: self.walkRightFrames, timePerFrame: 0.1, resize: false, restore: true)), withKey: GunwomanAnimations.walkRight.rawValue)
            }
            break
        case .walkLeft:
            if self.action(forKey: GunwomanAnimations.walkLeft.rawValue) == nil {
                self.run(SKAction.repeatForever(SKAction.animate(with: self.walkLeftFrames, timePerFrame: 0.1, resize: false, restore: true)), withKey: GunwomanAnimations.walkLeft.rawValue)
            }
            break
        case .shootRight:
            // I don't actually have the shooting right frames loaded into the assets catalog, so I'll make the idle right animation work here
            self.run(SKAction.repeatForever(SKAction.animate(with: self.idleRightFrames, timePerFrame: 0.18, resize: false, restore: true)), withKey: GunwomanAnimations.idleRight.rawValue)
            break
        case .shootLeft:
            // I don't actually have the shooting left frames loaded into the assets catalog, so I'll make the idle left animation work here
            self.run(SKAction.repeatForever(SKAction.animate(with: self.idleLeftFrames, timePerFrame: 0.18, resize: false, restore: true)), withKey: GunwomanAnimations.idleLeft.rawValue)
            break
        }
        
        
//        // Determine what the current animation should be based on direction and action
//        switch self.currentAction {
//        case .idle:
//            switch self.currentDirection {
//            case .left:
//                self.currentAnimation.animation = .idleLeft
//                break
//            case .right:
//                self.currentAnimation.animation = .idleRight
//                break
//            case .none:
//                // TODO: I need to figure out what to do here
//                break
//            }
//            break
//        case .walk:
//            switch self.currentDirection {
//            case .left:
//                self.currentAnimation.animation = .walkLeft
//                break
//            case .right:
//                self.currentAnimation.animation = .walkRight
//                break
//            case .none:
//                // TODO:  I need to figure out what to do here
//                break
//            }
//            break
//        case .none:
//            // TODO: I need to figure out what to do here
//            break
//        }
//
//        // Determine if the animation can be played or not
//        if !self.currentAnimation.isPlaying {
//            self.currentAnimation.isPlaying = true
//            switch self.currentAnimation.animation {
//            case .idleLeft:
//                self.run(SKAction.repeatForever(SKAction.animate(with: self.idleLeftFrames, timePerFrame: 0.18, resize: false, restore: true)))
//                break
//            case .idleRight:
//                self.run(SKAction.repeatForever(SKAction.animate(with: self.idleRightFrames, timePerFrame: 0.18, resize: false, restore: true)))
//                break
//            case .walkLeft:
//                self.run(SKAction.repeatForever(SKAction.animate(with: self.walkLeftFrames, timePerFrame: 0.18, resize: false, restore: true)))
//                break
//            case .walkRight:
//                self.run(SKAction.repeatForever(SKAction.animate(with: self.walkRightFrames, timePerFrame: 0.18, resize: false, restore: true)))
//                break
//            case .none:
//                self.currentAnimation.isPlaying = false
//                break
//            }
//        }
    }
    
    private func buildFrames() {
        let idleLeftAtlas = SKTextureAtlas(named: "Gunwoman Idle Left")
        let idleRightAtlas = SKTextureAtlas(named: "Gunwoman Idle Right")
        let walkLeftAtlas = SKTextureAtlas(named: "Gunwoman Walk Left")
        let walkRightAtlas = SKTextureAtlas(named: "Gunwoman Walk Right")
        
        // Load the idle left frames
        for i in 1...idleLeftAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Idle Left 00\(i)"
            } else {
                tname = "Gunwoman Idle Left 0\(i)"
            }
            self.idleLeftFrames.append(idleLeftAtlas.textureNamed(tname))
        }
        
        // Load the idle right frames
        for i in 1...idleRightAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Idle Right 00\(i)"
            } else {
                tname = "Gunwoman Idle Right 0\(i)"
            }
            self.idleRightFrames.append(idleRightAtlas.textureNamed(tname))
        }
        
        // Load the walk left frames
        for i in 1...walkLeftAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Walk Left 00\(i)"
            } else {
                tname = "Gunwoman Walk Left 0\(i)"
            }
            self.walkLeftFrames.append(walkLeftAtlas.textureNamed(tname))
        }
        
        // Load the walk right frames
        for i in 1...walkRightAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Walk Right 00\(i)"
            } else {
                tname = "Gunwoman Walk Right 0\(i)"
            }
            self.walkRightFrames.append(walkRightAtlas.textureNamed(tname))
        }
    }
}
