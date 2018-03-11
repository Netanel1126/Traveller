import Foundation

class Groups{
    var groupid : String
    var groupName: String
    var guideList = [String]()
    var travllerList = [String]()
    var imageURL: String?
    
    init(Gruopid:String,GroupName:String,GuideList:[String],NumTravellers: [String],ImageURL: String?){
        self.groupid = Gruopid
        self.groupName = GroupName
        self.guideList = GuideList
        self.travllerList = NumTravellers
        self.imageURL = ImageURL
        //travllerList.count
    }
    
    init(GroupName:String,GuideList:[String],NumTravellers: [String],ImageURL: String?){
        self.groupid = UUID().uuidString
        self.groupName = GroupName
        self.guideList = GuideList
        self.travllerList = NumTravellers
        self.imageURL = ImageURL
    }
    
    init(fromJson : [String:Any]){
        self.groupid = fromJson["GroupID"] as! String
        self.groupName = fromJson["GroupName"] as! String
        self.guideList = fromJson["GuideList"] as! String
        self.travllerList = fromJson["TravllerList"] as! String
        self.imageURL = fromJson["ImageURL"] as! String
    }
    
    func tojson()-> [String:Any]{
        var json = [String:Any]()
        
        json["GroupID"] = groupName
        json["groupName"] = groupName
        json["guideList"] = guideList
        json["travllerList"] = travllerList
        
        if imgURL != nil{
            json["imgURL"] = imgURL!
        }else{imgURL = ""}
        
        return json
    }
    
}
