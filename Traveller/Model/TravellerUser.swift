import Foundation

class TravellerUser{
    var userName:String
    var email:String
    var password:String
    var firstName:String
    var lastName:String
    var phoneNumber:String
    var imgURL:String?
    
    init(userName:String,email:String,password:String,firstName:String,lastName:String,phoneNumber:String,imgURL:String?){
        self.userName = userName
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.imgURL = imgURL
    }
    
    init(fromJson : [String:Any]){
        self.userName = fromJson["userName"] as! String
        self.email = fromJson["email"] as! String
        self.password = fromJson["password"] as! String
        self.firstName = fromJson["firstName"] as! String
        self.lastName = fromJson["lastName"] as! String
        self.phoneNumber = fromJson["phoneNumber"] as! String
        self.imgURL = fromJson["imgURL"] as! String
    }
    
    func tojson()-> [String:Any]{
        var json = [String:Any]()
        
        json["userName"] = userName
        json["email"] = email
        json["password"] = password
        json["firstName"] = firstName
        json["lastName"] = lastName
        json["phoneNumber"] = phoneNumber
        
        if imgURL != nil{
            json["imgURL"] = imgURL!
        }else{imgURL = ""}
        
        return json
    }
}
