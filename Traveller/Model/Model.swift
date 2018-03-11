import Foundation

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
    static let ConnectedUser = ModelNotificationBase<String>(name: "ConnectedUserNotificatio")
    static let NewUserNotification = ModelNotificationBase<String>(name : "NewUserNotification")
    static let LogInNotification = ModelNotificationBase<String>(name : "LogInNotification")
    
    static func removeObserver(observer:Any){
        NotificationCenter.default.removeObserver(observer)
    }
}


class Model{
    static let instance = Model()
    let fire = FirebaseModel()
    
    func getConnectedUserAndObserve(){
        FirebaseModel.getConnectedUserAndObservecallback { (userEmail) in
            ModelNotification.ConnectedUser.post(data: userEmail)
        }
    }
    
    func addNewUserToDatabase(user:TravellerUser){
        FirebaseModel.createNewUser(userT: user) { (error) in
            ModelNotification.NewUserNotification.post(data: error)
        }
    }
}
