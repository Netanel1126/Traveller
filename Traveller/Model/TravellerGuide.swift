import Foundation

class TravellerGuide: TravellerUser{
    var authentication: String
    
  init(userName: String, email: String, password: String, firstName: String, lastName: String, phoneNumber: String, imgURL: String?,authentication: String) {
    self.authentication = authentication

        super.init(userName: userName, email: email, password: password, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, imgURL: imgURL)
    
    }
    
    override init(fromJson: [String : Any]) {
        self.authentication = fromJson["authentication"] as! String
        super.init(fromJson: fromJson)
    }
    
    override func tojson() -> [String : Any] {
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
        
        json["authentication"] = authentication
        
        return json
    }
}
