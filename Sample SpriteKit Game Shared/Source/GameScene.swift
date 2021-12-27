//
//  GameScene.swift
//  Sample SpriteKit Game Shared
//
//  Created by Gregory Martin on 12/25/21.
//

import SpriteKit

class GameScene: SKScene {
    
    
    fileprivate var label : SKLabelNode?
    fileprivate var spinnyNode : SKShapeNode?
    fileprivate var boyAvatar: SKSpriteNode?
    fileprivate var otherBoyAvatar: SKSpriteNode?

    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    func setUpScene() {
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.boyAvatar = self.childNode(withName: "//boyAvatar") as? SKSpriteNode
        if let ba = self.boyAvatar {
            ba.alpha = 0.0
            ba.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.otherBoyAvatar = self.childNode(withName: "//otherBoyAvatar") as? SKSpriteNode
        if let oba = self.otherBoyAvatar {
            oba.alpha = 0.0;
            oba.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 4.0
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
            
            #if os(watchOS)
                // For watch we just periodically create one of these and let it spin
                // For other platforms we let user touch/mouse events create these
                spinnyNode.position = CGPoint(x: 0.0, y: 0.0)
                spinnyNode.strokeColor = SKColor.red
                self.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 2.0),
                                                                   SKAction.run({
                                                                       let n = spinnyNode.copy() as! SKShapeNode
                                                                       self.addChild(n)
                                                                   })])))
            #endif
        }
    }
    
    #if os(watchOS)
    override func sceneDidLoad() {
        self.setUpScene()
    }
    #else
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    #endif

    func makeSpinny(at pos: CGPoint, color: SKColor) {
        if let spinny = self.spinnyNode?.copy() as! SKShapeNode? {
            spinny.position = pos
            spinny.strokeColor = color
            self.addChild(spinny)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches {
            self.makeSpinny(at: t.location(in: self), color: SKColor.green)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.makeSpinny(at: t.location(in: self), color: SKColor.blue)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.makeSpinny(at: t.location(in: self), color: SKColor.red)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.makeSpinny(at: t.location(in: self), color: SKColor.red)
        }
    }
    
   
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        self.makeSpinny(at: event.location(in: self), color: SKColor.green)
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.blue)
    }
    
    override func mouseUp(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.red)
    }
    
    override func keyDown(with event: NSEvent) {
        /*
         * The problem that I'm running into with this code is that when an intersection occurs,
         * it's likely that the boyAvatar is overlapping with the otherBoyAvatar when the animation
         * stops and it's not possible to dislodge the boyAvatar. I'm wondering if it makes sense to
         * use collision direction flags to see if the boyAvatar can be disallowed from moving futher
         * in the direction that the collision occurred in (i.e. if a collision occurred on the right
         * side, disallow movement in that particular direction). This would, however, change the
         * methods used for checking collisions.
         */
        
        if event.modifierFlags.contains(NSEvent.ModifierFlags.numericPad) {
            if let arrow = event.charactersIgnoringModifiers, let kc = arrow.unicodeScalars.first?.value {
                switch Int(kc) {
                case NSUpArrowFunctionKey:
                    if let ba = self.boyAvatar {
//                        ba.run(SKAction.moveBy(x: 0.0, y: 3.0, duration: 1.0))
                        if !checkCollisionWithPlayer(other: self.otherBoyAvatar) {
                            ba.run(SKAction.moveBy(x: 0.0, y: 9.0, duration: 0.5))
                        }
                    }
                case NSDownArrowFunctionKey:
                    if let ba = self.boyAvatar {
                        if !checkCollisionWithPlayer(other: self.otherBoyAvatar) {
                            ba.run(SKAction.moveBy(x: 0.0, y: -9.0, duration: 0.5))
                        }
                    }
                case NSLeftArrowFunctionKey:
                    if let ba = self.boyAvatar {
                        if !checkCollisionWithPlayer(other: self.otherBoyAvatar) {
                            ba.run(SKAction.moveBy(x: -9.0, y: 0.0, duration: 0.5))
                        }
                    }
                case NSRightArrowFunctionKey:
                    if let ba = self.boyAvatar {
                        if !checkCollisionWithPlayer(other: self.otherBoyAvatar) {
                            ba.run(SKAction.moveBy(x: 9.0, y: 0.0, duration: 0.5))
                        }
                    }
                default:
                    break
                }
            }
        }
    }

}
#endif

extension GameScene {
    func checkCollisionWithPlayer(other o: SKSpriteNode?) -> Bool {
        if let a = o {
            if let ba = self.boyAvatar {
                if ba.intersects(a) {
                    return true
                } else {
                    return false
                }
            }
        }
        
        return false
    }
}

