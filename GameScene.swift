//
//  GameScene.swift
//  MemShape
//
//  Created by David Liu on 2/3/18.
//  Copyright © 2018 Davidapps. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var countLabel : SKLabelNode?
    private var turnLabel : SKLabelNode?
    private var subtitleLabel : SKLabelNode?
    private var menuLabel : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var squareNode : SKShapeNode?
    private var circleNode : SKShapeNode?
    private var triangleNode: SKShapeNode?
    private var squareButton : SKShapeNode?
    private var circleButton : SKShapeNode?
    private var triangleButton : SKShapeNode?
    var shapeArray = [String]()
    var count = 0
    var userCount = 0
    var gameOver = false
    var timer = Timer()
    
    override func didMove(to view: SKView) {
        startGame()
    }
    
    func startGame(){
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.position = CGPoint(x: 0.0, y: 30.0)
            label.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1),
                                         SKAction.run({
                                            label.text = "READY"
                                         }),
                                         SKAction.fadeIn(withDuration: 1.0),
                                         SKAction.wait(forDuration: 0.5),
                                         SKAction.fadeOut(withDuration: 0.5),
                                         SKAction.run({
                                            label.text = "SET"
                                         }),
                                         SKAction.fadeIn(withDuration: 1.0),
                                         SKAction.wait(forDuration: 0.5),
                                         SKAction.fadeOut(withDuration: 0.5),
                                         SKAction.run({
                                            label.text = "GO!!!"
                                         }),
                                         SKAction.fadeIn(withDuration: 1.0),
                                         SKAction.wait(forDuration: 0.5),
                                         SKAction.fadeOut(withDuration: 0.5)]))
            
        }
        
        self.countLabel = self.childNode(withName: "//countLabel") as? SKLabelNode
        if let countLabel = self.countLabel {
            countLabel.position = CGPoint(x: 0.0, y: 170)
        }
        
        self.turnLabel = self.childNode(withName: "//turnLabel") as? SKLabelNode
        if let turnLabel = self.turnLabel {
            turnLabel.position = CGPoint(x: 350.0, y: 170.0)
        }
        
        self.subtitleLabel = self.childNode(withName: "//subtitleLabel") as? SKLabelNode
        if let subtitleLabel = self.subtitleLabel {
            subtitleLabel.position = CGPoint(x: 0.0, y: -50.0)
        }
        
        self.menuLabel = self.childNode(withName: "//menuLabel") as? SKLabelNode
        if let menuLabel = self.menuLabel {
            menuLabel.alpha = 0.0
            menuLabel.position = CGPoint(x: -320.0, y: 170.0)
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 1.0),
                                              SKAction.removeFromParent()]))
        }
        
        self.triangleNode = SKShapeNode()
        if let triangleNode = self.triangleNode{
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0.0, y: 100.0))
            path.addLine(to: CGPoint(x: 87.0, y: -50.0))
            path.addLine(to: CGPoint(x: -87.0, y: -50.0))
            path.addLine(to: CGPoint(x: 0.0, y: 100.0))
            triangleNode.path = path.cgPath
            triangleNode.lineWidth = 5
            triangleNode.strokeColor = UIColor.red
            triangleNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            triangleNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                                SKAction.fadeOut(withDuration: 1.0),
                                                SKAction.removeFromParent()]))
        }
        
        self.squareNode = SKShapeNode.init(rectOf: CGSize.init(width: 130, height: 130), cornerRadius: 0.0)
        if let squareNode = self.squareNode{
            squareNode.lineWidth = 5
            squareNode.strokeColor = UIColor.green
            squareNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            squareNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 1.0),
                                              SKAction.removeFromParent()]))
        }
        
        self.circleNode = SKShapeNode.init(ellipseIn: CGRect(x: 0.0, y: 0.0, width: 130, height: 130))
        if let circleNode = self.circleNode{
            circleNode.lineWidth = 5
            circleNode.strokeColor = UIColor.blue
            circleNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            circleNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 1.0),
                                              SKAction.removeFromParent()]))
        }
        
        self.triangleButton = SKShapeNode()
        if let triangleButton = self.triangleButton{
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0.0, y: 35.0))
            path.addLine(to: CGPoint(x: 35.0, y: -25.0))
            path.addLine(to: CGPoint(x: -35.0, y: -25.0))
            path.addLine(to: CGPoint(x: 0.0, y: 35.0))
            triangleButton.path = path.cgPath
            triangleButton.lineWidth = 5
            triangleButton.strokeColor = UIColor.red
            triangleButton.position = CGPoint(x: -200.0, y: -150.0)
            self.addChild(triangleButton)
        }
        
        self.squareButton = SKShapeNode.init(rectOf: CGSize.init(width: 50, height: 50), cornerRadius: 0.0)
        if let squareButton = self.squareButton{
            squareButton.lineWidth = 5
            squareButton.strokeColor = UIColor.green
            squareButton.position = CGPoint(x: 0.0, y: -150.0)
            self.addChild(squareButton)
        }
        
        self.circleButton = SKShapeNode.init(ellipseIn: CGRect(x: 0.0, y: 0.0, width: 50, height: 50))
        if let circleButton = self.circleButton{
            circleButton.lineWidth = 5
            circleButton.strokeColor = UIColor.blue
            circleButton.position = CGPoint(x: 150.0, y: -175.0)
            self.addChild(circleButton)
        }
        
        
        let wait = SKAction.wait(forDuration: 5.0)
        self.run(wait, completion: ({
            self.subtitleLabel?.run(SKAction.fadeOut(withDuration: 1.0))
            self.addShape()
            self.scheduledTimerWithTimeInterval()
        }))
    }
    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.purple
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.yellow
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        if (userCount < shapeArray.count && count >= shapeArray.count && gameOver == false) {
            for touch: AnyObject in touches {
                let location = touch.location(in: self)
                if (squareButton?.frame)!.contains(location) {
                    print("Touched square")
                    if (shapeArray[userCount] == "s") {
                        print("correct at \(userCount)")
                        userCount += 1
                    }else{
                        callGameOver()
                    }
                } else if (triangleButton?.frame)!.contains(location) {
                    print("Touched triangle")
                    if (shapeArray[userCount] == "t") {
                        print("correct at \(userCount)")
                        userCount += 1
                    }else{
                        callGameOver()
                    }
                } else if (circleButton?.frame)!.contains(location) {
                    print("Touched circle")
                    if (shapeArray[userCount] == "c") {
                        print("correct at \(userCount)")
                        userCount += 1
                    }else{
                        callGameOver()
                    }
                }
            }
        }
        if (userCount == shapeArray.count) {
            userCount = 0
            count = 0
            addShape()
            print("finished round!")
        }
        if (gameOver == true) {
            for touch: AnyObject in touches {
                let location = touch.location(in: self)
                if (subtitleLabel?.frame)!.contains(location) {
                    print("Start over")
                    subtitleLabel?.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1),
                                                          SKAction.run({
                                                            self.subtitleLabel?.text = "Memorize the pattern!"
                                                          }),
                                                          SKAction.fadeIn(withDuration: 1.0)]))
                    gameOver = false
                    userCount = 0
                    count = 0
                    shapeArray = []
                    startGame()
                    //timer.fire()
                }else if (menuLabel?.frame)!.contains(location) {
                    print("Clicked menu")
                    self.view!.window!.rootViewController!.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    func callGameOver() {
        print("Game over")
        gameOver = true
        turnLabel?.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1),
                                          SKAction.run({
                                            self.turnLabel?.text = "Game Over"
                                          }),
                                          SKAction.fadeIn(withDuration: 0.5)]))
        menuLabel?.run(SKAction.fadeIn(withDuration: 0.5))
        subtitleLabel?.text = "Start Over"
        subtitleLabel?.run(SKAction.fadeIn(withDuration: 1.0))
        timer.invalidate()
        let defaults = UserDefaults.standard
        var highScore = defaults.integer(forKey: "highScore")
        if (shapeArray.count - 1 > highScore) {
            defaults.set(shapeArray.count - 1, forKey: "highScore")
            highScore = shapeArray.count - 1
        }
        self.label?.text = "High score: " + String(highScore)
        self.label?.run(SKAction.fadeIn(withDuration: 0.5))
    }
    
    @objc func updateCounting(){
        if (count < shapeArray.count) {
            if (self.turnLabel?.text != "Wait...") {
                turnLabel?.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1),
                                                  SKAction.run({
                                                    self.turnLabel?.text = "Wait..."
                                                  }),
                                                  SKAction.fadeIn(withDuration: 0.5)]))
            }
            if (shapeArray[count] == "t") {
                if let t = self.triangleNode?.copy() as? SKShapeNode{
                    t.position = CGPoint(x: -200.0, y: 100.0)
                    t.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                             SKAction.fadeOut(withDuration: 1.0),
                                             SKAction.removeFromParent()]))
                    self.addChild(t)
                }
            }else if (shapeArray[count] == "s") {
                if let s = self.squareNode?.copy() as? SKShapeNode{
                    s.position = CGPoint(x: 0.0, y: 0.0)
                    s.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                             SKAction.fadeOut(withDuration: 1.0),
                                             SKAction.removeFromParent()]))
                    self.addChild(s)
                }
            }else{
                if let c = self.circleNode?.copy() as? SKShapeNode{
                    c.position = CGPoint(x: 250.0, y: 50.0)
                    c.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                             SKAction.fadeOut(withDuration: 1.0),
                                             SKAction.removeFromParent()]))
                    self.addChild(c)
                }
            }
            count += 1
        }else{
            if (self.turnLabel?.text != "Your turn...") {
                turnLabel?.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1),
                                                  SKAction.run({
                                                    self.turnLabel?.text = "Your turn..."
                                                  }),
                                                  SKAction.fadeIn(withDuration: 0.5)]))
            }
        }
    }
    
    func addShape(){
        let randomNum = Int(arc4random_uniform(3))
        if (randomNum == 0){
            shapeArray.append("t")
        }else if (randomNum == 1){
            shapeArray.append("s")
        }else if (randomNum == 2){
            shapeArray.append("c")
        }
        print(shapeArray)
        self.countLabel?.text = "Count: " + String(shapeArray.count)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
