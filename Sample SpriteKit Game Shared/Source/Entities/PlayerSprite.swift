//
//  PlayerSprite.swift
//  Sample SpriteKit Game
//
//  Created by Gregory Martin on 2/1/22.
//

import SpriteKit
import GameplayKit

class PlayerStates: GKState {
    fileprivate var _playerSprite: PlayerSprite
    
    init(_ ps : PlayerSprite) {
        self._playerSprite = ps
    }
}

class PlayerSprite : SKSpriteNode {
    fileprivate var _direction: Int = 90
    fileprivate var _idleLeftFrames: [SKTexture] = []
    fileprivate var _idleRightFrames: [SKTexture] = []
    fileprivate var _walkLeftFrames: [SKTexture] = []
    fileprivate var _walkRightFrames: [SKTexture] = []
    fileprivate var _attackLeftFrames: [SKTexture] = []
    fileprivate var _attackRightFrames: [SKTexture] = []
    fileprivate var _animationActions: [PlayerSpriteAnimationNames : SKAction] = [:]
    fileprivate var _fsm: GKStateMachine = GKStateMachine(states: [])
    
    public var direction: Int {
        get {
            return self._direction
        }
        set {
            self._direction = newValue
        }
    }
    
    public var fsm: GKStateMachine {
        get {
            return self._fsm
        }
    }
    
    enum PlayerSpriteAnimationNames: String, CaseIterable {
        case idleLeft = "Gunwoman Idle Left"
        case idleRight = "Gunwoman Idle Right"
        case walkLeft = "Gunwoman Walk Left"
        case walkRight = "Gunwoman Walk Right"
        case attackRight = "Gunwoman Attack Right"
        case attackLeft = "Gunwoman Attack Left"
        case none = "None"
    }
    
    enum PlayerSpriteAnimationSpeeds: TimeInterval {
        case idleAnimationSpeed = 0.12
        case walkAnimationSpeed = 0.09
        case attackAnimationSpeed = 0.06
        case attackAnimationSpeedLimit = 0.48
    }
    
    class PlayerStateIdling : PlayerStates {
        override func isValidNextState(_ stateClass: AnyClass) -> Bool {
            return stateClass == PlayerStateWalking.self ||
            stateClass == PlayerStateAttacking.self
        }
        
        override func didEnter(from previousState: GKState?) {
            if self._playerSprite._direction == 90 {
                self._playerSprite.size.width = 192.0
                self._playerSprite.size.height = 192.0
                self._playerSprite.run(self._playerSprite._animationActions[PlayerSpriteAnimationNames.idleRight] ?? SKAction.setTexture(self._playerSprite._attackRightFrames[8]), withKey: PlayerSpriteAnimationNames.idleRight.rawValue)
            } else if self._playerSprite._direction == 270 {
                self._playerSprite.size.width = 192.0
                self._playerSprite.size.height = 192.0
                self._playerSprite.run(self._playerSprite._animationActions[PlayerSpriteAnimationNames.idleLeft]!, withKey: PlayerSpriteAnimationNames.idleLeft.rawValue)
            }
        }
        
        override func willExit(to nextState: GKState) {
            self._playerSprite.removeAllActions()
        }
    }
    
    class PlayerStateWalking : PlayerStates {
        override func isValidNextState(_ stateClass: AnyClass) -> Bool {
            return stateClass == PlayerStateIdling.self ||
            stateClass == PlayerStateAttacking.self
        }
        
        override func didEnter(from previousState: GKState?) {
            if self._playerSprite._direction == 90 {
                self._playerSprite.size.width = 192.0
                self._playerSprite.size.height = 192.0
                self._playerSprite.run(self._playerSprite._animationActions[PlayerSpriteAnimationNames.walkRight]!, withKey: PlayerSpriteAnimationNames.walkRight.rawValue)
            } else if self._playerSprite._direction == 270 {
                self._playerSprite.size.width = 192.0
                self._playerSprite.size.height = 192.0
                self._playerSprite.run(self._playerSprite._animationActions[PlayerSpriteAnimationNames.walkLeft]!, withKey: PlayerSpriteAnimationNames.walkLeft.rawValue)
            }
        }
        
        override func willExit(to nextState: GKState) {
            self._playerSprite.removeAllActions()
        }
    }
    
    class PlayerStateAttacking : PlayerStates {
        override func isValidNextState(_ stateClass: AnyClass) -> Bool {
            return stateClass == PlayerStateIdling.self ||
            stateClass == PlayerStateWalking.self
        }
        
        override func didEnter(from previousState: GKState?) {
            if self._playerSprite._direction == 90 {
                self._playerSprite.size.width = 384.0
                self._playerSprite.size.height = 192.0
                self._playerSprite.run(self._playerSprite._animationActions[PlayerSpriteAnimationNames.attackRight]!, withKey: PlayerSpriteAnimationNames.attackRight.rawValue)
            } else if self._playerSprite._direction == 270 {
                self._playerSprite.size.width = 384.0
                self._playerSprite.size.height = 192.0
                self._playerSprite.run(self._playerSprite._animationActions[PlayerSpriteAnimationNames.attackLeft]!, withKey: PlayerSpriteAnimationNames.attackLeft.rawValue)
            }
        }
        
        override func willExit(to nextState: GKState) {
            self._playerSprite.removeAllActions()
        }
    }
    
    init () {
        super.init (texture: nil, color: .white, size: .zero)
        
        buildFrames ()
        buildAnimations ()
        configureFsm ()
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init (coder: aDecoder)
        
        buildFrames ()
        buildAnimations ()
        configureFsm ()
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
        self._animationActions[PlayerSpriteAnimationNames.idleRight] = SKAction.repeatForever(SKAction.animate(with: self._idleRightFrames, timePerFrame: PlayerSpriteAnimationSpeeds.idleAnimationSpeed.rawValue, resize: false, restore: true))
        self._animationActions[PlayerSpriteAnimationNames.idleLeft] = SKAction.repeatForever(SKAction.animate(with: self._idleLeftFrames, timePerFrame: PlayerSpriteAnimationSpeeds.idleAnimationSpeed.rawValue, resize: false, restore: true))
        self._animationActions[PlayerSpriteAnimationNames.walkRight] = SKAction.repeatForever(SKAction.animate(with: self._walkRightFrames, timePerFrame: PlayerSpriteAnimationSpeeds.walkAnimationSpeed.rawValue, resize: false, restore: true))
        self._animationActions[PlayerSpriteAnimationNames.walkLeft] = SKAction.repeatForever(SKAction.animate(with: self._walkLeftFrames, timePerFrame: PlayerSpriteAnimationSpeeds.walkAnimationSpeed.rawValue, resize: false, restore: true))
        self._animationActions[PlayerSpriteAnimationNames.attackLeft] = SKAction.sequence([SKAction.animate(with: self._attackLeftFrames, timePerFrame: PlayerSpriteAnimationSpeeds.attackAnimationSpeed.rawValue, resize: false, restore: true), SKAction.run { self._fsm.enter(PlayerStateIdling.self) }])
        self._animationActions[PlayerSpriteAnimationNames.attackRight] = SKAction.sequence([SKAction.animate(with: self._attackRightFrames, timePerFrame: PlayerSpriteAnimationSpeeds.attackAnimationSpeed.rawValue, resize: false, restore: true), SKAction.run { self._fsm.enter(PlayerStateIdling.self) }])
    }
    
    private func configureFsm () {
        self._fsm = GKStateMachine(states: [
            PlayerStateIdling(self),
            PlayerStateWalking(self),
            PlayerStateAttacking(self)
        ])
        self._fsm.enter(PlayerStateIdling.self)
    }
    
    func update(_ currentTime: TimeInterval) {
        self._fsm.update(deltaTime: currentTime)
    }
}
