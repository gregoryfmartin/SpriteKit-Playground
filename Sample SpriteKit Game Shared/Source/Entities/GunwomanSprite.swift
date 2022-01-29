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
        case attackRight
        case attackLeft
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
        case attackRight = "Gunwoman Attack Right"
        case attackLeft = "Gunwoman Attack Left"
        case none = "None"
    }
    
    enum GunwomanAnimationSpeeds: TimeInterval {
        case idleAnimationSpeed = 0.12
        case walkAnimationSpeed = 0.09
        case shootAnimationSpeed = 0.06
    }
    
    static let DirectionLeft: Int = 0
    static let DirectionRight: Int = 1
    
    private var idleLeftFrames: [SKTexture] = []
    private var idleRightFrames: [SKTexture] = []
    private var walkLeftFrames: [SKTexture] = []
    private var walkRightFrames: [SKTexture] = []
    private var attackLeftFrames: [SKTexture] = []
    private var attackRightFrames: [SKTexture] = []
    var direction: [Bool] = [false, false]
    var state: GunwomanState {
        get {
            return self.state
        }
        set {
            switch newValue {
            case .idleRight:
                self.direction[GunwomanSprite.DirectionRight] = true
                self.direction[GunwomanSprite.DirectionLeft] = false
                self.size.width = 192.0
                self.size.height = 192.0
                if self.action(forKey: GunwomanAnimations.idleRight.rawValue) == nil {
                    self.run(SKAction.repeatForever(SKAction.animate(with: self.idleRightFrames, timePerFrame: GunwomanAnimationSpeeds.idleAnimationSpeed.rawValue, resize: false, restore: true)), withKey: GunwomanAnimations.idleRight.rawValue)
//                    self.run(
//                        SKAction.repeatForever(
//                            SKAction.group([
//                                SKAction.animate(with: self.idleRightFrames, timePerFrame: 0.15, resize: false, restore: true),
//                                SKAction.run {
//                                    self.size.width = self.texture?.size().width ?? 0.0
//                                    self.size.height = self.texture?.size().height ?? 0.0
//                                }
//                            ])
//                        ), withKey: GunwomanAnimations.idleRight.rawValue
//                    )
                }
                break
            case .idleLeft:
                self.direction[GunwomanSprite.DirectionRight] = false
                self.direction[GunwomanSprite.DirectionLeft] = true
                self.size.width = 192.0
                self.size.height = 192.0
                if self.action(forKey: GunwomanAnimations.idleLeft.rawValue) == nil {
                    self.run(SKAction.repeatForever(SKAction.animate(with: self.idleLeftFrames, timePerFrame: GunwomanAnimationSpeeds.idleAnimationSpeed.rawValue, resize: false, restore: true)), withKey: GunwomanAnimations.idleLeft.rawValue)
//                    self.run(
//                        SKAction.repeatForever(
//                            SKAction.group([
//                                SKAction.animate(with: self.idleLeftFrames, timePerFrame: 0.15, resize: false, restore: true),
//                                SKAction.run {
//                                    self.size.width = self.texture?.size().width ?? 0.0
//                                    self.size.height = self.texture?.size().height ?? 0.0
//                                }
//                            ])
//                        ), withKey: GunwomanAnimations.idleLeft.rawValue
//                    )
                }
                break
            case .walkRight:
                self.direction[GunwomanSprite.DirectionRight] = true
                self.direction[GunwomanSprite.DirectionLeft] = false
                self.size.width = 192.0
                self.size.height = 192.0
                if self.action(forKey: GunwomanAnimations.walkRight.rawValue) == nil {
                    self.run(SKAction.repeatForever(SKAction.animate(with: self.walkRightFrames, timePerFrame: GunwomanAnimationSpeeds.walkAnimationSpeed.rawValue, resize: false, restore: true)), withKey: GunwomanAnimations.walkRight.rawValue)
//                    self.run(
//                        SKAction.repeatForever(
//                            SKAction.group([
//                                SKAction.animate(with: self.walkRightFrames, timePerFrame: 0.1, resize: false, restore: true),
//                                SKAction.run {
//                                    self.size.width = self.texture?.size().width ?? 0.0
//                                    self.size.height = self.texture?.size().height ?? 0.0
//                                }
//                            ])
//                        ), withKey: GunwomanAnimations.walkRight.rawValue
//                    )
                }
                break
            case .walkLeft:
                self.direction[GunwomanSprite.DirectionRight] = false
                self.direction[GunwomanSprite.DirectionLeft] = true
                self.size.width = 192.0
                self.size.height = 192.0
                if self.action(forKey: GunwomanAnimations.walkLeft.rawValue) == nil {
                    self.run(SKAction.repeatForever(SKAction.animate(with: self.walkLeftFrames, timePerFrame: GunwomanAnimationSpeeds.walkAnimationSpeed.rawValue, resize: false, restore: true)), withKey: GunwomanAnimations.walkLeft.rawValue)
//                    self.run(
//                        SKAction.repeatForever(
//                            SKAction.group([
//                                SKAction.animate(with: self.walkLeftFrames, timePerFrame: 0.1, resize: false, restore: true),
//                                SKAction.run {
//                                    self.size.width = self.texture?.size().width ?? 0.0
//                                    self.size.height = self.texture?.size().height ?? 0.0
//                                }
//                            ])
//                        ), withKey: GunwomanAnimations.walkLeft.rawValue
//                    )
                }
                break
            case .attackRight:
                self.size.width = 384.0
                self.size.height = 192.0
                if self.action(forKey: GunwomanAnimations.attackRight.rawValue) == nil {
                    self.run(
//                        SKAction.group([
//                            SKAction.sequence([
//                                SKAction.animate(with: self.attackRightFrames, timePerFrame: 0.1, resize: false, restore: true),
//                                SKAction.run {
//                                    self.state = .idleRight
//                                }
//                            ]),
//                            SKAction.run {
//                                self.size.width = self.texture?.size().width ?? 0.0
//                                self.size.height = self.texture?.size().height ?? 0.0
//                            }
//                        ]), withKey: GunwomanAnimations.attackRight.rawValue
                        
                        SKAction.sequence([
                            SKAction.animate(with: self.attackRightFrames, timePerFrame: GunwomanAnimationSpeeds.shootAnimationSpeed.rawValue, resize: false, restore: true),
                            SKAction.run {
                                self.state = .idleRight
                            }
                        ])
                    )
                }
                break
            case .attackLeft:
                self.size.width = 384.0
                self.size.height = 192.0
                if self.action(forKey: GunwomanAnimations.attackLeft.rawValue) == nil {
                    self.run(
//                        SKAction.group([
//                            SKAction.sequence([
//                                SKAction.animate(with: self.attackLeftFrames, timePerFrame: 0.1, resize: false, restore: true),
//                                SKAction.run {
//                                    self.state = .idleLeft
//                                }
//                            ]),
//                            SKAction.run {
//                                self.size.width = self.texture?.size().width ?? 0.0
//                                self.size.height = self.texture?.size().height ?? 0.0
//                            }
//                        ]), withKey: GunwomanAnimations.attackLeft.rawValue
                        
                        SKAction.sequence([
                            SKAction.animate(with: self.attackLeftFrames, timePerFrame: GunwomanAnimationSpeeds.shootAnimationSpeed.rawValue, resize: false, restore: true),
                            SKAction.run {
                                self.state = .idleLeft
                            }
                        ])
                    )
                }
                break
            }
        }
    }
    
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
    
    private func buildFrames() {
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
        
        // Load the shoot left frames
        for i in 1...attackLeftAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Attack Left 00\(i)"
            } else {
                tname = "Gunwoman Attack Left 0\(i)"
            }
            self.attackLeftFrames.append(attackLeftAtlas.textureNamed(tname))
        }
        
        // Load the shoot right frames
        for i in 1...attackRightAtlas.textureNames.count {
            var tname = ""
            if i < 10 {
                tname = "Gunwoman Attack Right 00\(i)"
            } else {
                tname = "Gunwoman Attack Right 0\(i)"
            }
            self.attackRightFrames.append(attackRightAtlas.textureNamed(tname))
        }
    }
}
