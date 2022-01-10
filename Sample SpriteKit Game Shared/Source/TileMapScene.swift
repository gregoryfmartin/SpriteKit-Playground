//
//  TileMapScene.swift
//  Sample SpriteKit Game
//
//  Created by Gregory Martin on 1/1/22.
//

import SpriteKit

class TileMapScene: SKScene {
    fileprivate var localCamera: SKCameraNode?
    
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
    }
    
    override func didMove(to view: SKView) {
        print("didMove encountered")
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let cam = self.localCamera {
            print("Current camera position is \(cam.position.x), \(cam.position.y)")
            print("Current camera size is \(cam.xScale), \(cam.yScale)")
            print("Current camera rotation is \(cam.zRotation)")
        }
    }
}

#if os(OSX)
extension TileMapScene {
    override func keyDown(with event: NSEvent) {
        if event.modifierFlags.contains(NSEvent.ModifierFlags.numericPad) {
            if let arrow = event.charactersIgnoringModifiers, let kc = arrow.unicodeScalars.first?.value {
                switch Int(kc) {
                case NSUpArrowFunctionKey:
                    if let cam = self.localCamera {
                        cam.run(SKAction.moveBy(x: 0.0, y: 25.0, duration: 0.5))
                    }
                    break
                case NSDownArrowFunctionKey:
                    if let cam = self.localCamera {
                        cam.run(SKAction.moveBy(x: 0.0, y: -25.0, duration: 0.5))
                    }
                    break
                case NSLeftArrowFunctionKey:
                    if let cam = self.localCamera {
                        cam.run(SKAction.moveBy(x: -25.0, y: 0.0, duration: 0.5))
                    }
                    break
                case NSRightArrowFunctionKey:
                    if let cam = self.localCamera {
                        cam.run(SKAction.moveBy(x: 25.0, y: 0.0, duration: 0.5))
                    }
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
