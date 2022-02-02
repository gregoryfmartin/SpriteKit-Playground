//
//  GunwomanSprite.swift
//  Sample SpriteKit Game
//
//  Created by Gregory Martin on 1/23/22.
//

import SpriteKit

enum GunwomanState: CaseIterable {
    case idleRight
    case idleLeft
    case walkRight
    case walkLeft
    case attackRight
    case attackLeft
}

enum GunwomanAnimationNames: String, CaseIterable {
    case idleLeft = "Gunwoman Idle Left"
    case idleRight = "Gunwoman Idle Right"
    case walkLeft = "Gunwoman Walk Left"
    case walkRight = "Gunwoman Walk Right"
    case attackRight = "Gunwoman Attack Right"
    case attackLeft = "Gunwoman Attack Left"
    case none = "None"
}

enum GunwomanAnimationSpeeds: TimeInterval {
    case idleAnimationSpeed = 0.12
    case walkAnimationSpeed = 0.09
    case attackAnimationSpeed = 0.06
    case attackAnimationSpeedLimit = 0.48
}

class GunwomanSprite: SKSpriteNode {
    private var _direction: Int = 90
    private var _state: GunwomanState = .idleRight
    private var _idleLeftFrames: [SKTexture] = []
    private var _idleRightFrames: [SKTexture] = []
    private var _walkLeftFrames: [SKTexture] = []
    private var _walkRightFrames: [SKTexture] = []
    private var _attackLeftFrames: [SKTexture] = []
    private var _attackRightFrames: [SKTexture] = []
    private var _animationActions: [GunwomanAnimationNames : SKAction] = [:]
    private var _canIdleRight: Bool = false
    private var _canIdleLeft: Bool = false
    private var _canWalkRight: Bool = false
    private var _canWalkLeft: Bool = false
    private var _canAttackRight: Bool = false
    private var _canAttackLeft: Bool = false
    private var _canAnimate: Bool = false
    
    static let DirectionLeft: Int = 0
    static let DirectionRight: Int = 1
    
    private var attackAnimExecutionTime: TimeInterval = 0.0
    var direction: [Bool] = [false, false]
    var state: GunwomanState {
        get {
            return self._state
        }
        set {
            switch newValue {
            case .idleRight:
                break
            case .idleLeft:
                self._canIdleLeft = true
                break
            case .walkRight:
                self.direction[GunwomanSprite.DirectionRight] = true
                self.direction[GunwomanSprite.DirectionLeft] = false
                self.size.width = 192.0
                self.size.height = 192.0
                if self.action(forKey: GunwomanAnimationNames.walkRight.rawValue) == nil {
                    self.removeAllActions()
                }
                self.run(self._animationActions[GunwomanAnimationNames.walkRight]!, withKey: GunwomanAnimationNames.walkRight.rawValue)
                break
            case .walkLeft:
                self.direction[GunwomanSprite.DirectionRight] = false
                self.direction[GunwomanSprite.DirectionLeft] = true
                self.size.width = 192.0
                self.size.height = 192.0
                self.removeAllActions()
                self.run(self._animationActions[GunwomanAnimationNames.walkLeft]!, withKey: GunwomanAnimationNames.walkLeft.rawValue)
                break
            case .attackRight:
                self.size.width = 384.0
                self.size.height = 192.0
                self.removeAllActions()
                self.run(self._animationActions[GunwomanAnimationNames.attackRight]!, withKey: GunwomanAnimationNames.attackRight.rawValue)
                break
            case .attackLeft:
                self.size.width = 384.0
                self.size.height = 192.0
                self.removeAllActions()
                self.run(self._animationActions[GunwomanAnimationNames.attackLeft]!, withKey: GunwomanAnimationNames.attackLeft.rawValue)
                break
            }
            self._state = newValue
        }
    }
    
    init () {
        super.init (texture: nil, color: .white, size: .zero)
        
        buildFrames ()
        buildAnimations ()
        self.state = .idleRight
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init (coder: aDecoder)
        
        buildFrames ()
        buildAnimations ()
        self.state = .idleRight
    }
    
    public func update (_ currentTime: TimeInterval) {
        /*
         * Check to see if the current state is shooting. We want to play the shoot sound on the eighth frame of animation.
         * This could get a little dicey and may not work, but we're going to try and measure the animatino performance
         * to see if we can ascertain the exact frame and then fire an Action to play the sound.
         */
//        if self.state == .attackLeft || self.state == .attackRight {
//            self.attackAnimExecutionTime += GunwomanAnimationSpeeds.attackAnimationSpeed.rawValue
//            if self.attackAnimExecutionTime >= GunwomanAnimationSpeeds.attackAnimationSpeedLimit.rawValue &&
//                self.action(forKey: "Gunwoman Shoot SFX") == nil {
//                self.run(SKAction.playSoundFileNamed("Gunwoman Shoot SFX", waitForCompletion: false), withKey: "Gunwoman Shoot SFX")
//                self.attackAnimExecutionTime = 0.0
//            }
//        }
    }
    
    private func buildFrames () {
        let idleLeftAtlas = SKTextureAtlas(named: "Gunwoman Idle Left")
        let idleRightAtlas = SKTextureAtlas(named: "Gunwoman Idle Right")
        let walkLeftAtlas = SKTextureAtlas(named: "Gunwoman Walk Left")
        let walkRightAtlas = SKTextureAtlas(named: "Gunwoman Walk Right")
        let attackLeftAtlas = SKTextureAtlas(named: "Gunwoman Attack Left")
        let attackRightAtlas = SKTextureAtlas(named: "Gunwoman Attack Right")
        
        // Load the idle left frames
        for i in 1...idleLeftAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Idle Left 00\(i)"
            } else {
                tname = "Gunwoman Idle Left 0\(i)"
            }
            self._idleLeftFrames.append(idleLeftAtlas.textureNamed(tname))
        }
        
        // Load the idle right frames
        for i in 1...idleRightAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Idle Right 00\(i)"
            } else {
                tname = "Gunwoman Idle Right 0\(i)"
            }
            self._idleRightFrames.append(idleRightAtlas.textureNamed(tname))
        }
        
        // Load the walk left frames
        for i in 1...walkLeftAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Walk Left 00\(i)"
            } else {
                tname = "Gunwoman Walk Left 0\(i)"
            }
            self._walkLeftFrames.append(walkLeftAtlas.textureNamed(tname))
        }
        
        // Load the walk right frames
        for i in 1...walkRightAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Walk Right 00\(i)"
            } else {
                tname = "Gunwoman Walk Right 0\(i)"
            }
            self._walkRightFrames.append(walkRightAtlas.textureNamed(tname))
        }
        
        // Load the shoot left frames
        for i in 1...attackLeftAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Attack Left 00\(i)"
            } else {
                tname = "Gunwoman Attack Left 0\(i)"
            }
            self._attackLeftFrames.append(attackLeftAtlas.textureNamed(tname))
        }
        
        // Load the shoot right frames
        for i in 1...attackRightAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Attack Right 00\(i)"
            } else {
                tname = "Gunwoman Attack Right 0\(i)"
            }
            self._attackRightFrames.append(attackRightAtlas.textureNamed(tname))
        }
    }
    
    private func buildAnimations () {
        self._animationActions[GunwomanAnimationNames.idleRight] = SKAction.repeatForever(SKAction.animate(with: self._idleRightFrames, timePerFrame: GunwomanAnimationSpeeds.idleAnimationSpeed.rawValue, resize: false, restore: false))
        self._animationActions[GunwomanAnimationNames.idleLeft] = SKAction.repeatForever(SKAction.animate(with: self._idleLeftFrames, timePerFrame: GunwomanAnimationSpeeds.idleAnimationSpeed.rawValue, resize: false, restore: false))
        self._animationActions[GunwomanAnimationNames.walkRight] = SKAction.repeatForever(SKAction.animate(with: self._walkRightFrames, timePerFrame: GunwomanAnimationSpeeds.walkAnimationSpeed.rawValue, resize: false, restore: false))
        self._animationActions[GunwomanAnimationNames.walkLeft] = SKAction.repeatForever(SKAction.animate(with: self._walkLeftFrames, timePerFrame: GunwomanAnimationSpeeds.walkAnimationSpeed.rawValue, resize: false, restore: false))
        self._animationActions[GunwomanAnimationNames.attackLeft] = SKAction.sequence([SKAction.animate(with: self._attackLeftFrames, timePerFrame: GunwomanAnimationSpeeds.attackAnimationSpeed.rawValue, resize: false, restore: true), SKAction.run { self.state = .idleLeft }])
        self._animationActions[GunwomanAnimationNames.attackRight] = SKAction.sequence([SKAction.animate(with: self._attackRightFrames, timePerFrame: GunwomanAnimationSpeeds.attackAnimationSpeed.rawValue, resize: false, restore: true), SKAction.run { self.state = .idleRight }])
    }
    
    func updateActions () {
        if self._canIdleRight {
            if self._canAnimate && self.action(forKey: GunwomanAnimationNames.idleRight.rawValue) == nil {
                self.run(self._animationActions[GunwomanAnimationNames.idleRight]!, withKey: GunwomanAnimationNames.idleRight.rawValue)
            }
        } else if self._canIdleLeft {
            if self._canAnimate && self.action(forKey: GunwomanAnimationNames.idleLeft.rawValue) == nil {
                self.run(self._animationActions[GunwomanAnimationNames.idleLeft]!, withKey: GunwomanAnimationNames.idleLeft.rawValue)
            }
        } else if self._canWalkRight {
            if self._canAnimate && self.action(forKey: GunwomanAnimationNames.walkRight.rawValue) == nil {
                self.run(self._animationActions[GunwomanAnimationNames.walkRight]!, withKey: GunwomanAnimationNames.walkRight.rawValue)
            }
        } else if self._canWalkLeft {
            if self._canAnimate && self.action(forKey: GunwomanAnimationNames.walkLeft.rawValue) == nil {
                self.run(self._animationActions[GunwomanAnimationNames.walkLeft]!, withKey: GunwomanAnimationNames.walkLeft.rawValue)
            }
        } else if self._canAttackRight {
            if self._canAnimate && self.action(forKey: GunwomanAnimationNames.attackRight.rawValue) == nil {
                self.run(self._animationActions[GunwomanAnimationNames.attackRight]!, withKey: GunwomanAnimationNames.attackRight.rawValue)
            }
        } else if self._canAttackLeft {
            if self._canAnimate && self.action(forKey: GunwomanAnimationNames.attackLeft.rawValue) == nil {
                self.run(self._animationActions[GunwomanAnimationNames.attackLeft]!, withKey: GunwomanAnimationNames.attackLeft.rawValue)
            }
        }
    }
    
    func updateInternals () {
        if self._canIdleRight {
            self._direction = 90
            self.size.width = 192.0
            self.size.height = 192.0
        } else if self._canIdleLeft {
            self._direction = 270
            self.size.width = 192.0
            self.size.height = 192.0
        } else if self._canWalkRight {
            self._direction = 90
            self.size.width = 192.0
            self.size.height = 192.0
        } else if self._canWalkLeft {
            self._direction = 270
            self.size.width = 192.0
            self.size.height = 192.0
        } else if self._canAttackRight {
            self._direction = 90
            self.size.width = 384.0
            self.size.height = 192.0
        } else if self._canAttackLeft {
            self._direction = 270
            self.size.width = 384.0
            self.size.height = 192.0
        }
    }
}
