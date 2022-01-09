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
                        cam.run(SKAction.moveBy(x: 0.0, y: 9.0, duration: 0.5))
                    }
                    break
                case NSDownArrowFunctionKey:
                    if let cam = self.localCamera {
                        cam.run(SKAction.moveBy(x: 0.0, y: -9.0, duration: 0.5))
                    }
                    break
                case NSLeftArrowFunctionKey:
                    if let cam = self.localCamera {
                        cam.run(SKAction.moveBy(x: -9.0, y: 0.0, duration: 0.5))
                    }
                    break
                case NSRightArrowFunctionKey:
                    if let cam = self.localCamera {
                        cam.run(SKAction.moveBy(x: 9.0, y: 0.0, duration: 0.5))
                    }
                    break
                default:
                    break
                }
            }
        }
    }
}
#endif
