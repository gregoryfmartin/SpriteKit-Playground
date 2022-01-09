//
//  UserControlledCameraScene.swift
//  Sample SpriteKit Game
//
//  Created by Gregory Martin on 1/9/22.
//

import SpriteKit

class UserControlledCameraScene : SKScene {
    /*
     * This class is going to use the TileMapScene file as a basis instead of creating an
     * entirely new one.
     */
    class func newUserControlledCameraScene() -> UserControlledCameraScene {
        guard let scene = SKScene(fileNamed: "SampleTitleScene") as? UserControlledCameraScene else {
            print("Failed to use SampleTitleScene.sks file")
            abort()
        }
        
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    func setupScene() {
        
    }
    
    #if os(watchOS)
    override func sceneDidLoad() {
        self.setupScene()
    }
    #else
    override func didMove(to view: SKView) {
        self.setupScene()
    }
    #endif
}

#if os(OSX)
extension UserControlledCameraScene {
    override func keyDown(with event: NSEvent) {
        if event.modifierFlags.contains(NSEvent.ModifierFlags.numericPad) {
            if let arrow = event.charactersIgnoringModifiers, let kc = arrow.unicodeScalars.first?.value {
                switch Int(kc) {
                case NSUpArrowFunctionKey:
                    if let cam = self.camera {
                        cam.run(SKAction.moveBy(x: 0.0, y: 9.0, duration: 0.5))
                    }
                    break
                case NSDownArrowFunctionKey:
                    if let cam = self.camera {
                        cam.run(SKAction.moveBy(x: 0.0, y: -9.0, duration: 0.5))
                    }
                    break
                case NSLeftArrowFunctionKey:
                    if let cam = self.camera {
                        cam.run(SKAction.moveBy(x: -9.0, y: 0.0, duration: 0.5))
                    }
                    break
                case NSRightArrowFunctionKey:
                    if let cam = self.camera {
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
