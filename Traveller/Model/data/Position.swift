import Foundation
class Position {
    
    var id:Int
    var x:Double
    var y:Double
    
    init(id: Int, x: Double, y: Double) {
        self.id = id
        self.x = x
        self.y = y
    }
    
    init(firebaseString: String) {
        let params: [String] = firebaseString.components(separatedBy: ",")
        id = Int(params[0])!
        x = Double(params[1])!
        y = Double(params[2])!
    }
}
