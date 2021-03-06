//
//  MenuScene.swift
//  MemShape
//
//  Created by David Liu on 2/3/18.
//  Copyright © 2018 Davidapps. All rights reserved.
//

import SpriteKit
import GameplayKit
import SendGrid

class MenuScene: SKScene {
    
    private var label : SKLabelNode?
    private var startGameLabel : SKLabelNode?
    private var descriptionLabel : SKLabelNode?
    private var settingsLabel : SKLabelNode?
    private var challengeLabel : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var SG_API_KEY = "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"
    
    override func didMove(to view: SKView) {
        
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.position = CGPoint(x: 0.0, y: 30.0)
        }
        
        self.startGameLabel = self.childNode(withName: "//startGameLabel") as? SKLabelNode
        if let startGameLabel = self.startGameLabel {
            startGameLabel.position = CGPoint(x: 0.0, y: -80.0)
        }
        
        self.settingsLabel = self.childNode(withName: "//settingsLabel") as? SKLabelNode
        if let settingsLabel = self.settingsLabel {
            settingsLabel.position = CGPoint(x: -280.0, y: -180.0)
        }
        
        self.challengeLabel = self.childNode(withName: "//challengeLabel") as? SKLabelNode
        if let challengeLabel = self.challengeLabel {
            challengeLabel.position = CGPoint(x: 270.0, y: -180.0)
        }
        
        self.descriptionLabel = self.childNode(withName: "//descriptionLabel") as? SKLabelNode
        if let descriptionLabel = self.descriptionLabel {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.position = CGPoint(x: 0.0, y: 130.0)
            descriptionLabel.preferredMaxLayoutWidth = self.frame.width
        }
        
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 1.0),
                                              SKAction.fadeOut(withDuration: 1.0),
                                              SKAction.removeFromParent()]))
        }
        
        //sendEmail()
        
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        let randomX = Int(arc4random_uniform(UInt32(self.frame.height-200))) - Int(self.frame.height/2)
        let randomY = Int(arc4random_uniform(UInt32(self.frame.width-200))) - Int(self.frame.width/2)
        let randomNode = SKShapeNode.init(rectOf: CGSize.init(width: 100, height: 100), cornerRadius: 100 * 0.3)
        randomNode.position = CGPoint(x: randomX, y: randomY)
        randomNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
        randomNode.strokeColor = .random()
        randomNode.alpha = 0.0
        randomNode.lineWidth = 2.5
        self.addChild(randomNode)
        randomNode.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.5),
                                          SKAction.wait(forDuration: 1.0),
                                          SKAction.fadeOut(withDuration: 2.0),
                                          SKAction.removeFromParent()]))
    }
    
    func sendEmail() {
        
        let session = Session()
        session.authentication = Authentication.apiKey(SG_API_KEY)
        // Send a basic example
        let personalization = Personalization(recipients: "sdavidliu@gmail.com")
        let htmlText = Content(contentType: ContentType.htmlText, value: "<h2><span style=\"color: #4b67a1;\">You have a challenge from David!</span></h2> <p>&nbsp;</p> <p>David challenged you to the game of MemShape! Memorize the pattern of the shapes and try to get the high score!</p> <h1 style=\"text-align: center;\">David's High Score: 10</h1> <p>Open up the app and beat their high score. Or you can download it on the Apple App Store through this link: <a href=\"https://itunes.apple.com/us/app/anteatermaps/id1274238050?mt=8\">https://itunes.apple.com/us/app/anteatermaps/id1274238050?mt=8</a>.</p> <p>Don't forget to challenge other friends and give us a five star rating on the App Store!</p> <p>&nbsp;</p> <p>From,</p> <p>MemShape</p>")
        let email = Email(
            personalizations: [personalization],
            from: Address(email: "liftingmovement@gmail.com"),
            content: [htmlText],
            subject: "MemShape Challenge"
        )
        do {
            try session.send(request: email)
        } catch {
            print(error)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.purple
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        if let descriptionLabel = self.descriptionLabel {
            descriptionLabel.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        if let startGameLabel = self.startGameLabel {
            startGameLabel.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if (startGameLabel?.frame)!.contains(location) {
                print("pressed start game")
                self.view!.window!.rootViewController!.performSegue(withIdentifier: "gameSegue", sender: self)
            }else if (settingsLabel?.frame)!.contains(location) {
                print("pressed settings")
                self.view!.window!.rootViewController!.performSegue(withIdentifier: "settingsSegue", sender: self)
            }else if (challengeLabel?.frame)!.contains(location) {
                print("pressed challenge")
                self.view!.window!.rootViewController!.performSegue(withIdentifier: "challengeSegue", sender: self)
            }
        }
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

