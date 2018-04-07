import Foundation
import UIKit

class ModelNotificationBase<T>{
    var name:String?
    
    init(name:String){
        self.name = name
    }
    
    func observe(callback:@escaping (T?)->Void)->Any{
        return NotificationCenter.default.addObserver(forName: NSNotification.Name(name!), object: nil, queue: nil) { (data) in
            if let data = data.userInfo?["data"] as? T {
                callback(data)
            }
        }
    }
    
    func post(data:T?){
        NotificationCenter.default.post(name: NSNotification.Name(name!), object: self, userInfo: ["data":data])
    }
}

class ModelNotification{
    static let ConnectedUser = ModelNotificationBase<TravellerUser>(name: "ConnectedUserNotificatio")
    static let NewUserNotification = ModelNotificationBase<String>(name : "NewUserNotification")
    static let LogInNotification = ModelNotificationBase<String>(name : "LogInNotification")
    static let LogOutNotification = ModelNotificationBase<Bool>(name : "LogOutNotification")
    static let AuthenticationNotification = ModelNotificationBase<String>(name: "AuthenticationNotification")
    
    static func removeObserver(observer:Any){
        NotificationCenter.default.removeObserver(observer)
    }
}

class Model{
    static let instance = Model()
    let fire = FirebaseModel()
    
    func getConnectedUserAndObserve(){
        FirebaseModel.getConnectedUserAndObserve { (user) in
            ModelNotification.ConnectedUser.post(data: user)
        }
    }
    
    func saveGroupToFirebaseDatabase(group: Group) {
        FirebaseModel.saveGroupToDatabase(group: group)
    }
    
    func saveTripToFirebaseDatabase(trip: Trip) {
        FirebaseModel.saveTripToDatabase(trip: trip)
    }
    
    func addNewUserToDatabase(user:TravellerUser, image: UIImage? ,name: String?){
        
        if(image != nil && name != nil){
            FirebaseModel.saveImageToDatabase(image: image!, name: name!, callback: { (imgUrl) in
                user.imgURL = imgUrl
                
                FirebaseModel.createNewUser(userT: user) { (error) in
                    ModelNotification.NewUserNotification.post(data: error)
                }
            })
        }
                
        else{
                FirebaseModel.createNewUser(userT: user) { (error) in
                ModelNotification.NewUserNotification.post(data: error)
            }
        }
    }
    
    func checkAuthentication(user:TravellerUser){
        FirebaseModel.chackAuthentication(user: user) { (error) in
            if error == ""{
                user.userType = "Guide"
                FirebaseModel.addUserToFirebase(user: user)
            }
                ModelNotification.AuthenticationNotification.post(data: error)
        }
    }
    
    /*Adds new user to Database returns a string by callback if error*/
    func logInAndObserve(withEmail: String, password: String){
        FirebaseModel.logIn(withEmail:  withEmail, password: password) { (error) in
            ModelNotification.LogInNotification.post(data: error)
        }
    }
    
    func logOut(){
        FirebaseModel.logOut { (error) in
            ModelNotification.LogOutNotification.post(data: error)
        }
    }
}
