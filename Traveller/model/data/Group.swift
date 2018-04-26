import Foundation

class Group {
    //Should be same as TripId
    var groupId: String
    var groupName: String
    var guideIdList: [String]
    var travellerIdList: [String]
    var imageUrl: String
    
    init(groupId: String, groupName: String, guideIdList: [String]? = [String](), travellerIdList: [String]? = [String](), imageUrl: String? = "") {
        self.groupId = groupId
        self.groupName = groupName
        self.guideIdList = guideIdList!
        self.travellerIdList = travellerIdList!
        self.imageUrl = imageUrl!
    }
    
    init(json: [String:Any]){
        self.groupId = json["groupId"] as! String
        self.groupName = json["groupName"] as! String
        
        let guidesTmp = json["guideIdList"] as! String
        guideIdList = FirebaseConverter.decodeToStringArray(str: guidesTmp)
        
        let travellersTmp = json["travellerIdList"] as! String
        travellerIdList = FirebaseConverter.decodeToStringArray(str: travellersTmp)
        
        self.imageUrl = json["imageUrl"] as! String
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["groupId"] = groupId
        json["groupName"] = groupName
        json["guideIdList"] = FirebaseConverter.encodeStringArray(array: guideIdList)
        json["travellerIdList"] = FirebaseConverter.encodeStringArray(array: travellerIdList)
        json["imageUrl"] = imageUrl
        return json
    }
}
