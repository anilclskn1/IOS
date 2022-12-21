//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by AnilyTugce on 27.09.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
   
    //var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode()
    var box0 = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    
    
    var gameStarted = false
    
    var originalPosition : CGPoint?
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    
    enum ColliderType : UInt32 {
        case Bird = 1
        case Box = 2
        // if you want to define more, it shouldn't be the sum of others!!
        //case Ground = 4
        //case Tree = 8
    }

    
    override func didMove(to view: SKView) {
       /*
        let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: -self.frame.width / 5, y: self.frame.height / 8)
        bird2.size = CGSize(width: self.frame.width / 16, height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2)
        */
        
        
        // this code adds borders to frame do that there will be a limit of bird moving
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        
        
        self.physicsWorld.contactDelegate = self
        
        //BIRDS
        
        // we gave name in design part as "bird"
        bird = childNode(withName: "bird") as! SKSpriteNode
        
        // we defined the texture agaın so that we can use to defıne body
        let birdTexture = SKTexture(imageNamed: "bird")
        
        // here you create the borders of birf
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().width / 12)
        // affected by gravity is false ın the begınnıng but when touch began it will be true
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        
        originalPosition = bird.position
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        
        //BOXES
        
        let boxTexture = SKTexture(imageNamed: "brick")
        let boxSize = CGSize(width: boxTexture.size().width / 5, height: boxTexture.size().height / 5)
        
        box0 = childNode(withName: "box0") as! SKSpriteNode
        box0.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box0.physicsBody?.affectedByGravity = true
        box0.physicsBody?.isDynamic = true
        box0.physicsBody?.mass = 0.4
        box0.physicsBody?.allowsRotation = true
        
        box0.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.mass = 0.4
        box1.physicsBody?.allowsRotation = true
        
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue

        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.mass = 0.4
        box2.physicsBody?.allowsRotation = true
        
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue

        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box3.physicsBody?.affectedByGravity = false
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.mass = 0.4
        box3.physicsBody?.allowsRotation = true
        
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue

        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.mass = 0.4
        box4.physicsBody?.allowsRotation = true
        
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        //LABEL
        
        scoreLabel.fontName = "helvetica"
        scoreLabel.text = "0"
        scoreLabel.zPosition = 2
        scoreLabel.fontSize = 60
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        self.addChild(scoreLabel)

        

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
 
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    
    }
    
    func touchUp(atPoint pos : CGPoint) {
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
        bird.physicsBody?.affectedByGravity = true*/
        
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            //INCREASE SCORE
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // we defined gameStarted as false at the top
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            
                            if sprite == bird {
                                
                                let dx = originalPosition!.x - touchLocation.x
                                let dy = originalPosition!.y - touchLocation.y
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                                
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let birdPhysicsBody = bird.physicsBody {
            
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = originalPosition!
                
                gameStarted = false
            }
            
        }
    }
    
}
