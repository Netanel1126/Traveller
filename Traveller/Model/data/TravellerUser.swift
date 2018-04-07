import Foundation

class TravellerUser{
    var userName:String
    var email:String
    var password:String
    var firstName:String
    var lastName:String
    var phoneNumber:String
    var imgURL:String?
    var userType:String

   
    init() {
        self.userType = "Traveller"
        
        self.userName = ""
        self.email = ""
        self.password = ""
        self.firstName = ""
        self.lastName = ""
        self.phoneNumber = ""
        self.imgURL = ""
    }
    init(userName:String,email:String,password:String,firstName:String,lastName:String,phoneNumber:String,imgURL:String?){
        self.userType = "Traveller"
        
        self.userName = userName
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.imgURL = imgURL
    }
    
    init(fromJson : [String:Any]){
        self.userType = fromJson["userType"] as! String
        self.userName = fromJson["userName"] as! String
        self.email = (fromJson["email"] as! String).replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
        self.password = fromJson["password"] as! String
        self.firstName = fromJson["firstName"] as! String
        self.lastName = fromJson["lastName"] as! String
        self.phoneNumber = fromJson["phoneNumber"] as! String
        self.imgURL = fromJson["imgURL"] as! String?
    }
    
    func tojson()-> [String:Any]{
        var json = [String:Any]()
        
        json["userType"] = userType
        json["userName"] = userName
        
        /*encode email adress so you cold save it to FB*/
        let newEmail = email.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        json["email"] = newEmail
        
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
