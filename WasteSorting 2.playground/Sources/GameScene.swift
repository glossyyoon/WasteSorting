import SpriteKit
import UIKit
import PlaygroundSupport
import AVKit

public class GameScene: SKScene{
    var gameOver = false
    var movingPlayer = false
    public var qNum :Int = 0
    var offset : CGPoint!
    public let s = Sorting()
    public var wasteNum = Int()
    public var answerNode = SKSpriteNode()
    public var elseNode = [SKSpriteNode()]
    public var answerList = [SKSpriteNode()]
    public var player = SKSpriteNode()
    
    public var tree1 = SKSpriteNode(imageNamed: "treee3.PNG")
    public var tree2 = SKSpriteNode(imageNamed: "treee3.PNG")
    public var tree3 = SKSpriteNode(imageNamed: "treee3.PNG")
    public var tree4 = SKSpriteNode(imageNamed: "treee3.PNG")
    public var tree5 = SKSpriteNode(imageNamed: "treee3.PNG")
    public var tree6 = SKSpriteNode(imageNamed: "treee3.PNG")
    public var tree7 = SKSpriteNode(imageNamed: "treee3.PNG")
    
    public var mainLabel = SKSpriteNode(imageNamed: "mainLogo.PNG")
    public var label = SKLabelNode()
    public let level = SKLabelNode()
    
    public let paper = SKSpriteNode(imageNamed: "ppaper.PNG")
    public var plastic = SKSpriteNode(imageNamed: "pplastic.PNG")
    public var garbage = SKSpriteNode(imageNamed: "oorganic.PNG")
    public var trash = SKSpriteNode(imageNamed: "ttash.PNG")
    
    public let successSound = SKAction.playSoundFileNamed("successSound.wav", waitForCompletion: false)
    public let correct = SKAction.playSoundFileNamed("correctSound.wav", waitForCompletion: false)
    public let incorrect = SKAction.playSoundFileNamed("incorrect.wav", waitForCompletion: false)
    public let bgm = SKAudioNode(fileNamed: "themesong.wav")
    
    public let man = SKSpriteNode(imageNamed: "man.PNG")
    public let redbin = SKSpriteNode(imageNamed: "redbin.PNG")
    public let forest = SKSpriteNode(imageNamed: "forestbg.png")
    
    
    public let endForest = SKSpriteNode(imageNamed: "endEarth.PNG")
    public let replay = SKSpriteNode(imageNamed: "replay.PNG")
    
    public let thx = SKLabelNode(text: "🕊You saved the Earth!")
    
    
    
    func sortPlayer(){
        self.answerList = [plastic, garbage, paper, trash]
        self.wasteNum = s.wastes[qNum].sort
        self.answerNode = answerList[wasteNum]
        for i in answerList{
            if i != answerNode{
                self.elseNode.append(i)
            }
        }
        switch wasteNum {
        case 0:
            answerNode = plastic
        case 1:
            answerNode = garbage
        case 2:
            answerNode = paper
        case 3:
            answerNode = trash
        default:
            answerNode = trash
        }
        self.player = SKSpriteNode(imageNamed: s.viewNode(questionNumber: qNum))
        player.size =  CGSize(width: 250.0, height: 280.0)
        player.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        addChild(player)
        
    }
    
    func sortingItems(){
        
        self.elseNode = []
        self.answerList = [plastic, garbage, paper, trash]
        self.wasteNum = s.wastes[qNum].sort
        self.answerNode = answerList[wasteNum]
        for i in answerList{
            if i != answerNode{
                self.elseNode.append(i)
            }
        }
        self.player = SKSpriteNode(imageNamed: s.viewNode(questionNumber: qNum))
        player.size =  CGSize(width: 250.0, height: 280.0)
        player.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        addChild(player)
        
        player.addChild(bgm)
        player.run(SKAction.play())
        
        
        plastic.size = CGSize(width: 150.0, height: 170.0)
        plastic.position = CGPoint(x: frame.midX - 250, y: frame.midY + 230)
        plastic.zPosition = -5
        
        garbage.size = CGSize(width: 150.0, height: 170.0)
        garbage.position = CGPoint(x: frame.midX - 85, y: frame.midY + 230)
        garbage.zPosition = -5
        
        paper.size = CGSize(width: 150.0, height: 170.0)
        paper.position = CGPoint(x: frame.midX + 85, y: frame.midY + 230)
        paper.zPosition = -5
        
        trash.size = CGSize(width: 150.0, height: 170.0)
        trash.position = CGPoint(x: frame.midX + 250, y: frame.midY + 230)
        trash.zPosition = -5
        
        level.position = CGPoint(x: frame.midX - 200, y: frame.midY + 330)
        level.fontSize = 30
        level.fontColor = UIColor.darkText
        level.fontName = "semibold"
        
        addChild(level)
        
        addChild(plastic)
        addChild(garbage)
        addChild(paper)
        addChild(trash)
        
        let bg = SKSpriteNode(imageNamed: "light.png")
        bg.setScale(1.0)
        bg.zPosition = -10
        bg.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(bg)

        
    }
    //MARK: - Touch
    public override func didMove(to view: SKView) {
        mainScene()
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard  !gameOver else {return}
        guard let touch = touches.first else {return}
        let touchLocation = touch.location(in: self)
        let touchedNodes = nodes(at: touchLocation)
        for node in touchedNodes{
            if node == player{
                movingPlayer = true
                offset = CGPoint(x: touchLocation.x - player.position.x, y: touchLocation.y - player.position.y)
            }
            else if node == replay{
                resetButton()
            }

            
        }
        
    }
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !gameOver && movingPlayer else {return}
        guard let touch = touches.first else {return}
        let touchLocation = touch.location(in: self)
        let newPlayer = CGPoint(x: touchLocation.x - offset.x, y: touchLocation.y - offset.y)
        player.run(SKAction.move(to: newPlayer, duration: 0.01))
        
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let fail = SKLabelNode(text: "Wrong! Try again!")
        fail.fontSize = 60
        fail.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        fail.fontName  = "semibold"
        
        let ex = s.wastes[qNum].explanation
        movingPlayer = false
        label.position = CGPoint(x: frame.midX, y: frame.midY + 110)
        label.fontSize = 30
        label.text = ex
        label.fontColor = UIColor.black
        label.fontName = "bold"
        
        let background = SKSpriteNode(color: UIColor.white, size: CGSize(width: CGFloat(label.frame.size.width), height:CGFloat(label.frame.size.height)))
        background.position = CGPoint(x: frame.midX, y: frame.midY + 120)
        background.zPosition = -1
        
        if answerNode.frame.contains(player.position){
            addChild(background)
            addChild(label)
            background.run(
                SKAction.sequence([
                    SKAction.wait(forDuration: 1.5),
                    SKAction.removeFromParent()]))
            label.run(correct)
            label.run(
                    SKAction.sequence([
                        SKAction.wait(forDuration: 1.5),
                        SKAction.removeFromParent()]))
            player.removeFromParent()
            nextLevel()
            addLevel()
        }
        
            
        else{
            for i in answerList{
                if i.frame.contains(player.position){
                    addChild(fail)
                    fail.run(incorrect)
                    fail.run(
                            SKAction.sequence([
                                SKAction.wait(forDuration: 1.0),
                                SKAction.removeFromParent()]))
                }

            }
            
        }
            
    }
    //MARK: - Level
    public func nextLevel(){
        qNum += 1
        if qNum==s.wasteNum(){
            endOfLevel()
        }
        else{
            sortPlayer()
        }
        tree1.position = CGPoint(x: 120, y: 100)
        tree1.size = CGSize(width: 120, height: 125)
        tree1.zPosition = -8
        
        tree2.position = CGPoint(x: 220, y: 100)
        tree2.size = CGSize(width: 120, height: 125)
        tree2.zPosition = -8
        
        tree3.position = CGPoint(x: 320, y: 100)
        tree3.size = CGSize(width: 120, height: 125)
        tree3.zPosition = -8
        
        tree4.position = CGPoint(x: 420, y: 100)
        tree4.size = CGSize(width: 120, height: 125)
        tree4.zPosition = -8
        
        tree5.position = CGPoint(x: 520, y: 100)
        tree5.size = CGSize(width: 120, height: 125)
        tree5.zPosition = -8
        
        tree6.position = CGPoint(x: 620, y: 100)
        tree6.size = CGSize(width: 120, height: 125)
        tree6.zPosition = -8
        
        tree7.position = CGPoint(x: 720, y: 100)
        tree7.size = CGSize(width: 120, height: 125)
        tree7.zPosition = -8
        
        switch qNum {
        case 1:
            addChild(tree1)
        case 2:
            addChild(tree2)
        case 3:
            addChild(tree3)
        case 4:
            addChild(tree4)
        case 5:
            addChild(tree5)
        case 6:
            addChild(tree6)
        case 7:
            addChild(tree7)
        default:
            let _ = 1
        }
    }
    public func addLevel(){
        level.text = "Saved movey: \(qNum)$"
        level.fontColor = UIColor.systemPink
    }
    //MARK: - End
    public func endOfLevel(){
        endForest.size = CGSize(width: 800, height: 800)
        endForest.zPosition = 10
        endForest.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(endForest)
        
        thx.fontSize = 70
        thx.position = CGPoint(x: frame.midX, y: frame.midY + 200)
        thx.fontColor = UIColor.black
        thx.fontName = "bold"
        thx.zPosition = 13
        addChild(thx)
        
        replay.position = CGPoint(x: frame.midX, y: frame.midY - 340)
        replay.size = CGSize(width: 200.0, height: 150.0)
        replay.zPosition = 20
        addChild(replay)

        
        plastic.removeFromParent()
        garbage.removeFromParent()
        paper.removeFromParent()
        trash.removeFromParent()
        
        
        }
    public func resetButton(){
        qNum = 0
        
        self.removeAllActions()
        bgm.run(SKAction.stop())
        let replayScene = GameScene(size: self.size)
        replayScene.scaleMode = self.scaleMode
        let animation = SKTransition.fade(withDuration: 1.0)
        replayScene.backgroundColor = UIColor.white
        self.view?.presentScene(replayScene, transition: animation)
        
    }
    //MARK: - Main
    public func mainScene(){
        mainLabel.position = CGPoint(x: frame.midX, y: frame.midY + 170)
        mainLabel.size = CGSize(width: 400, height: 270.0)
        
        man.position = CGPoint(x: frame.midX + 200, y: frame.midY  - 30 )
        man.size = CGSize(width: 150, height: 200.0)
        man.zPosition = +5
        
        redbin.position = CGPoint(x: frame.midX - 180, y: frame.midY - 30 )
        redbin.size = CGSize(width: 150.0, height: 200.0)
        
        forest.position = CGPoint(x: frame.midX, y: frame.midY)
        redbin.size = CGSize(width: 600, height: 600)
        
        
        
        addChild(man)
        addChild(redbin)
        addChild(mainLabel)
        addChild(forest)
        
        man.run(
            SKAction.sequence([
                SKAction.move(to: redbin.position, duration: 2.0),
                SKAction.wait(forDuration: 1.0),
                SKAction.removeFromParent()])
        , completion: sortingItems)

        redbin.run(SKAction.sequence([
                                        SKAction.wait(forDuration: 3.0),
                                        SKAction.removeFromParent()]), completion: addLevel)
        mainLabel.run(SKAction.sequence([
                                        SKAction.wait(forDuration: 3.0),
                                        SKAction.removeFromParent()]))
        forest.run(SKAction.sequence([
                                        SKAction.wait(forDuration: 3.0),
                                        SKAction.removeFromParent()]))
        bgm.run(SKAction.play())

    }
}
    
