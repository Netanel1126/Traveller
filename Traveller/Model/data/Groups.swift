import Foundation

class Group {
    var groupid : String
    var groupName: String
    var guideList : [String]
    var travllerList : [String]
    var imageURL: String?
    
    /*
    init(Gruopid:String,GroupName:String,GuideList:[String],NumTravellers: [String],ImageURL: String?){
        self.groupid = Gruopid
        self.groupName = GroupName
        self.guideList = GuideList
        self.travllerList = NumTravellers
        self.imageURL = ImageURL
        //travllerList.count
    }
    
    */
    init(GroupName:String, ImageURL: String?){
        self.groupid = UUID().uuidString
        self.groupName = GroupName
        self.guideList = [String]()
        self.travllerList = [String]()
        self.imageURL = ImageURL
    }
 
    
    convenience init(GroupName:String) {
        self.init(GroupName: GroupName, ImageURL: nil)
    }
    
    init(fromJson : [String:Any]){
        self.groupid = fromJson["GroupID"] as! String
        self.groupName = fromJson["GroupName"] as! String
        self.guideList = fromJson["GuideList"] as! [String]
        self.travllerList = fromJson["TravllerList"] as! [String]
        self.imageURL = fromJson["ImageURL"] as? String
    }
    
    func getName() -> String {
        return groupName
    }
    
    func toJson()-> [String:Any]{
        var json = [String:Any]()
        
        json["GroupID"] = groupid
        json["groupName"] = groupName
        json["guideList"] = guideList
        json["travllerList"] = travllerList
        
        if imageURL != nil{
            json["imageURL"] = imageURL!
        } else{
            imageURL = ""
        }
        
        return json
    }
    
}
