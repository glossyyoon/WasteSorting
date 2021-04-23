import SpriteKit
import UIKit
import PlaygroundSupport


let skView = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 600, height: 600)))

let gameScene = GameScene(size: CGSize(width: 800, height: 800))
gameScene.scaleMode = .aspectFill
gameScene.backgroundColor = UIColor.white

skView.presentScene(gameScene)


PlaygroundPage.current.liveView = skView
