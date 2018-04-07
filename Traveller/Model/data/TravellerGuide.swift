import Foundation

class TravellerGuide: TravellerUser{
    var authentication: String
    
    override init() {
        self.authentication = ""
        super.init()
    }
    
  init(userName: String, email: String, password: String, firstName: String, lastName: String, phoneNumber: String, imgURL: String?,authentication: String) {
    self.authentication = authentication

        super.init(userName: userName, email: email, password: password, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, imgURL: imgURL)
    
    }
    
    func TravellerToGuide (user: TravellerUser){
        self.userName = user.userName
        self.email = user.email
        self.password = user.password
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.phoneNumber = user.phoneNumber
        self.imgURL = user.imgURL
    }
    
    override init(fromJson: [String : Any]) {
        self.authentication = fromJson["authentication"] as! String
        super.init(fromJson: fromJson)
        self.userType = "Guide"
    }
    
    override func tojson() -> [String : Any] {
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
        
        json["authentication"] = authentication
        
        return json
    }
}
