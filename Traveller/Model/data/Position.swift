import Foundation
class Position {
    
    var id:Int
    var latitude:Double?
    var longitude:Double?
    
    init(id: Int, latitude: Double, longitude: Double) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(fromJson:[String:Any]){
        self.id = fromJson["id"] as! Int
        self.latitude = fromJson["latitude"] as! Double
        self.longitude = fromJson["longitude"] as! Double
    }
    
    func toJson() -> [String:Any]{
        var json = [String:Any]()
        
        json["id"] = self.id
        json["latitude"] = self.latitude
        json["longitude"] = self.longitude
        
        return json
    }
    
}

extension Position: CustomStringConvertible{
    
    var description:String{
        return "id: \(self.id), latitude: \(self.latitude!), longitude:\(self.longitude!)"
    }
}
