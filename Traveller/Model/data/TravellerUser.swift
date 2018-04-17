import Foundation

class TravellerUser {
    
    var id: String
    var email: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var imgUrl: String // "" instead null

    init(id: String, email: String, firstName: String, lastName: String, phoneNumber: String, imgUrl: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.imgUrl = imgUrl
    }
    
    init(json: [String:Any]) {
        id = json["id"] as! String
        email = json["email"] as! String
        firstName = json["firstName"] as! String
        lastName = json["lastName"] as! String
        phoneNumber = json["phoneNumber"] as! String
        imgUrl = json["imgUrl"] as! String
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["email"] = email
        json["firstName"] = firstName
        json["lastName"] = lastName
        json["phoneNumber"] = phoneNumber
        json["imgUrl"] = imgUrl
        return json
    }

    // used before signUp
    public struct SignUpStruct {
        
        init(email: String, password: String, firstName: String, lastName: String, phone: String, imgUrl: String) {
            self.email = email
            self.password = password
            self.firstName = firstName
            self.lastName = lastName
            self.phoneNumber = phone
            self.imgUrl = imgUrl
        }
        
        var email: String
        var password: String
        var firstName: String
        var lastName: String
        var phoneNumber: String
        var imgUrl: String
    }
}
