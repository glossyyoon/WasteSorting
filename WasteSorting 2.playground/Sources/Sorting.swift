
import PlaygroundSupport
import UIKit
import SpriteKit

public class Sorting {
    var initi: Int = 0

    struct Waste{
        let name: String
        let sort: Int
        let explanation: String
        let image: String
        
        public init(n: String, s: Int, e: String, i: String) {
            name = n
            sort = s
            explanation = e
            image = i
        }

    }
    struct Tree{
        let image: String
        let position: CGPoint
        public init(image: String, position: CGPoint){
            self.image = image
            self.position = position
        }
    }
    let wastes = [
        Waste(n: "disposable plastic", s: 0, e: "Plastic is recyclable.", i: "starbucks.PNG"),
        Waste(n: "Animal bones", s: 3, e: "Animal bones cannot be reused as  animal feed.", i: "chickenbone.PNG"),
        Waste(n: "box", s: 2, e: "Boxes are should be gathered together.", i: "box.PNG"),
        Waste(n: "tooth brush", s: 3, e: "The toothbrush is made of various materials.", i: "toothbrush.PNG"),
        Waste(n: "coffee grounds", s: 3, e: "Coffee grounds cannot be reused as animal feed.", i: "coffee.PNG"),
        Waste(n: "banana peel", s: 1, e: "Banana peels can be recycled.", i: "banana.PNG"),
        Waste(n: "straw", s: 3, e: "Plastic straws are cannot be recycled.", i: "straw.PNG")
        
        
    ]
    public func viewNode(questionNumber num: Int) -> String {
        let node = wastes[num].image
        return node
    }
    func getName(_ questionNumber:Int) -> String{
        return wastes[questionNumber].name
    }
    func getAnswer(_ questionNumber: Int) -> Int {
        return wastes[questionNumber].sort
    }
    func getExplain(_ questionNumber: Int) -> String{
        return wastes[questionNumber].explanation
    }
    public func wasteNum() -> Int{
        return wastes.count
    }

}


