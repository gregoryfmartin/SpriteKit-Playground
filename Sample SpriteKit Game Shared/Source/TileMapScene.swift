//
//  TileMapScene.swift
//  Sample SpriteKit Game
//
//  Created by Gregory Martin on 1/1/22.
//

import SpriteKit

class TileMapScene: SKScene {
    fileprivate var localCamera: SKCameraNode?
    fileprivate var rainfallEmitter: SKEmitterNode?
    fileprivate var sampleSprite: PlayerSprite = PlayerSprite()
    
    class func newTileMapScene() -> TileMapScene {
        guard let scene = SKScene(fileNamed: "TileMapScene") as? TileMapScene else {
            print("Failed to use TileMapScene.sks file")
            abort()
        }
        
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    func setupScene() {
        self.localCamera = self.childNode(withName: "localCamera") as? SKCameraNode
        if let cam = self.localCamera {
            self.camera = cam
        }
        
        self.sampleSprite.position.x = 100.0
        self.sampleSprite.position.y = 100.0
        self.addChild(self.sampleSprite)
        
        self.rainfallEmitter = SKEmitterNode(fileNamed: "SampleRainParticles")
        if let cam = self.camera {
            self.rainfallEmitter?.position = CGPoint(x: cam.position.x, y: cam.position.y + (cam.scene?.size.height)! / 2)
        }
//        self.rainfallEmitter?.position = CGPoint(x: (self.localCamera?.position.x)!, y: (self.localCamera?.position.y)! - (self.localCamera?.frame.height)!)
        self.rainfallEmitter?.targetNode = self
        self.addChild(rainfallEmitter!)
    }
    
    func updateEmitterLocation() {
        if let re = self.rainfallEmitter, let cam = self.camera, let camscene = cam.scene {
            re.position = CGPoint(x: cam.position.x, y: cam.position.y + camscene.size.height / 2)
        }
    }
    
    override func didMove(to view: SKView) {
//        print("didMove encountered")
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.sampleSprite.update(currentTime)
        
        print("Player Sprite location is \(self.sampleSprite.position.x)x\(self.sampleSprite.position.y)")
        print("Player Sprite has actions: \(self.sampleSprite.hasActions() ? "true" : "false")")
        print("Player Sprite Current State: \(self.sampleSprite.fsm.currentState?.className)")
        
//        if let cam = self.localCamera {
//            if let camscene = cam.scene {
//                print("Scene size is \(camscene.size.width), \(camscene.size.height)")
//            }
//            print("Current camera position is \(cam.position.x), \(cam.position.y)")
//            print("Current camera size is \(cam.xScale), \(cam.yScale)")
//            print("Current camera rotation is \(cam.zRotation)")
//        }
//        print("Gunwoman Sprite size is \(self.sampleSprite.size.width)x\(self.sampleSprite.size.height)")
//        print("Gunwoman Sprite frame is \(self.sampleSprite.frame.width)x\(self.sampleSprite.frame.height)")
//        print("Gunwoman Sprite texture size is \(self.sampleSprite.texture?.size().width ?? -99.99)x\(self.sampleSprite.texture?.size().height ?? -99.99)")
//        print("Gunwoman Sprite Origin is \(self.sampleSprite.anchorPoint.x)x\(self.sampleSprite.anchorPoint.y)")
//        print("Gunwoman Sprite Current Texture is \(self.sampleSprite.texture.hashValue)")
    }
}

#if os(OSX)
extension TileMapScene {
    override func keyUp(with event: NSEvent) {
        if event.modifierFlags.contains(NSEvent.ModifierFlags.numericPad) {
            if let arrow = event.charactersIgnoringModifiers, let kc = arrow.unicodeScalars.first?.value {
                switch Int(kc) {
                case NSLeftArrowFunctionKey:
                    self.sampleSprite.fsm.enter(PlayerSprite.PlayerStateIdling.self)
                    
                    
//                    self.sampleSprite.removeAllActions()
//                    self.sampleSprite.direction[GunwomanSprite.DirectionLeft] = true
//                    self.sampleSprite.state = .idleLeft
                    break
                case NSRightArrowFunctionKey:
                    self.sampleSprite.fsm.enter(PlayerSprite.PlayerStateIdling.self)
                    
                    
//                    self.sampleSprite.removeAllActions()
//                    self.sampleSprite.direction[GunwomanSprite.DirectionRight] = true
//                    self.sampleSprite.state = .idleRight
                    break
                default:
                    break
                }
            }
        }
    }
    
    override func keyDown(with event: NSEvent) {
        if event.modifierFlags.contains(NSEvent.ModifierFlags.numericPad) {
            if let arrow = event.charactersIgnoringModifiers, let kc = arrow.unicodeScalars.first?.value {
                switch Int(kc) {
                case NSUpArrowFunctionKey:
                    if let cam = self.localCamera {
//                        cam.run(SKAction.moveBy(x: 0.0, y: 25.0, duration: 0.5))
                        cam.run(
                            SKAction.group([
                                SKAction.moveBy(x: 0.0, y: 25.0, duration: 0.5),
                                SKAction.run {
                                    self.updateEmitterLocation()
                                }
                            ])
                        )
                    }
                    break
                case NSDownArrowFunctionKey:
                    if let cam = self.localCamera {
//                        cam.run(SKAction.moveBy(x: 0.0, y: -25.0, duration: 0.5))
                        cam.run(
                            SKAction.group([
                                SKAction.moveBy(x: 0.0, y: -25.0, duration: 0.5),
                                SKAction.run {
                                    self.updateEmitterLocation()
                                }
                            ])
                        )
                    }
                    break
                case NSLeftArrowFunctionKey:
                    self.sampleSprite.direction = 270
                    self.sampleSprite.fsm.enter(PlayerSprite.PlayerStateWalking.self)
                    
                    
//                    self.sampleSprite.state = .walkLeft
                    
//                    if let cam = self.localCamera {
////                        cam.run(SKAction.moveBy(x: -25.0, y: 0.0, duration: 0.5))
//                        cam.run(
//                            SKAction.group([
//                                SKAction.moveBy(x: -25.0, y: 0.0, duration: 0.5),
//                                SKAction.run {
//                                    self.updateEmitterLocation()
//                                }
//                            ])
//                        )
//                    }
                    break
                case NSRightArrowFunctionKey:
                    self.sampleSprite.direction = 90
                    self.sampleSprite.fsm.enter(PlayerSprite.PlayerStateWalking.self)
                    
                    
//                    self.sampleSprite.state = .walkRight
                    
//                    if let cam = self.localCamera {
////                        cam.run(SKAction.moveBy(x: 25.0, y: 0.0, duration: 0.5))
//                        cam.run(
//                            SKAction.group([
//                                SKAction.moveBy(x: 25.0, y: 0.0, duration: 0.5),
//                                SKAction.run {
//                                    self.updateEmitterLocation()
//                                }
//                            ])
//                        )
//                    }
                    break
                default:
                    break
                }
            }
        }
        
        if let k = event.charactersIgnoringModifiers {
            switch k {
            case "a", "A":
                if let cam = self.localCamera {
                    cam.run(SKAction.scale(to: 0.5, duration: 0.2))
                }
                break
            case "s", "S":
                if let cam = self.localCamera {
                    cam.run(SKAction.scale(to: 1.0, duration: 0.2))
                }
                break
            case "z", "Z":
                if let cam = self.localCamera {
//                    cam.run(SKAction.rotate(toAngle: 90.0 * .pi / 180, duration: 0.25))
                    cam.run(SKAction.rotate(byAngle: 90.0 * .pi / 180, duration: 0.25))
                }
                break
            case "x", "X":
                if let cam = self.localCamera {
                    cam.run(SKAction.rotate(byAngle: -(90.0 * .pi / 180), duration: 0.25))
                }
                break
            case "c", "C":
                if let cam = self.localCamera {
                    cam.run(SKAction.rotate(byAngle: 360.0 * .pi / 180, duration: 0.25))
                }
                break
            case "v", "V":
                if let cam = self.localCamera {
                    cam.run(SKAction.rotate(byAngle: -(360.0 * .pi / 180), duration: 0.25))
                }
                break
            case "q", "Q":
                self.sampleSprite.fsm.enter(PlayerSprite.PlayerStateAttacking.self)
//                if self.sampleSprite.direction[GunwomanSprite.DirectionLeft] == true {
//                    self.sampleSprite.state = .attackLeft
//                } else if self.sampleSprite.direction[GunwomanSprite.DirectionRight] == true {
//                    self.sampleSprite.state = .attackRight
//                }
                break
            default:
                break
            }
        }
    }
}
#endif

#if os(tvOS) || os(iOS)
// TODO: Implement touch controls to do the same things as above
#endif
