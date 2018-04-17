import Foundation

class  Algo {
    init() {
    }
    
    func locator(pointA:Location,pointB:Location) -> Float {
        
        var newLocatin = Location()
        newLocatin.x = pointA.x
        newLocatin.y = pointB.y
        print("\(newLocatin.x) \(newLocatin.y)")
        
        var a = abs(pointA.y - newLocatin.y)
        var b = abs(pointB.x - newLocatin.x)
        
        print("A : \(a) B : \(b)")
        let c = powf(powf(a,2) + powf(b, 2),1/2)
        
        print("C: \(c)");
        
        return asinf(a/c)
    }
}

class Location{
    var x: Float
    var y : Float
    
    init() {
        x = 0
        y = 0
    }
    
    init(x:Float,y:Float) {
        self.x = x
        self.y = y
    }
}
