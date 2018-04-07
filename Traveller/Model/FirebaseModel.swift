import Foundation
import Firebase
import FirebaseDatabase

class FirebaseModel{
    
    static var databaseRef:DatabaseReference? = Database.database().reference()
    static let storageRootPath = "gs://travller-1617f.appspot.com"
    static var storageRef = Storage.storage().reference(forURL: storageRootPath)
    
    init() {
        FirebaseModel.databaseRef = Database.database().reference()
    }
    
    static func getConnectedUserAndObserve(callback: @escaping (TravellerUser?)-> Void){
        
        if let userEmail = Auth.auth().currentUser?.email as? String{
        //if userEmail != nil {
            print("User: \(userEmail) is Connected")
            FirebaseModel.getUserFromFB(byId: userEmail, callback: { (user) in
                if user != nil{
                    callback(user)
                }
                else{
                    callback(nil)
                }
            })
        }
        else{
            callback(nil)
        }
    }
    
    static func getDataFromFB(byId: String,table: String ,callback: @escaping ([String:Any]?) -> Void){
        let myRef = databaseRef?.child(table).child(byId)
        
        myRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            if let val = snapshot.value as? [String:Any]{
                callback(val)
            }else{
                callback(nil)
            }
        })
    }
    
    static func getUserFromFB(byId: String,callback: @escaping (TravellerUser?) -> Void){
        print(byId.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil))
        FirebaseModel.getDataFromFB(byId: byId.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil), table: "Users") { (val) in
            if val != nil{
                var user:TravellerUser? = nil
                
                if val!["userType"] as! String == "Guide"{
                    user = TravellerGuide(fromJson: val!)
                }else if val!["userType"] as! String == "Traveller"{
                    user = TravellerUser(fromJson: val!)
                }
                callback(user)
            }else{
                callback(nil)
            }
        }
    }
    
    static func addUserToFirebase(user: TravellerUser){
        let myRef = databaseRef?.child("Users").child(user.email.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil).lowercased())
        
        myRef?.setValue(user.tojson())
    }
    
    /*Adds new user to firebase returns a string by callback if error*/
    static func createNewUser(userT: TravellerUser , callback: @escaping (String?)-> Void){
        Auth.auth().createUser(withEmail: userT.email, password: userT.password){ (user, error) in
            if(error != nil){
                callback(error?.localizedDescription)
            }
            else{
                FirebaseModel.addUserToFirebase(user: userT);
                callback("");
            }
        }
    }
    
    /*Log in to the app returns a string by callback if error*/
    static func logIn(withEmail : String,password: String , callback: @escaping (String?)-> Void){
        Auth.auth().signIn(withEmail: withEmail, password: password) { (user, error) in
            if(error != nil){
                callback(error?.localizedDescription)
            }
            else{
                callback("")
            }
        }
    }
    
    static func chackAuthentication(user: TravellerUser,callback: @escaping(String?)-> Void){
        
      if let userG = user as? TravellerGuide{
        
        var myRef = databaseRef?.child("Authentications").child(userG.authentication)
        
        myRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.value != nil{
                callback("")
            }else{
                callback("Error - Authentication is incorrect")
            }
        })
      }else{
        callback(nil)
        }
    }
    
    static func logOut(callback: @escaping(Bool)-> Void){
        let fbAuth = Auth.auth()
        do{
            try fbAuth.signOut()
            callback(true)
        }catch let error as NSError{
            print("Error Signing Out: %@", error)
            callback(false)
        }
    }
    
    static func saveGroupToDatabase(group: Group) {
        let ref = databaseRef?.child("Groups").child("\(group.getName())")
        ref?.setValue(group.toJson())
    }
    
    static func saveTripToDatabase(trip: Trip) {
        let ref = databaseRef?.child("Trips").child("\(trip.getName())")
        ref?.setValue(trip.toJson())
    }
    
    static func saveImageToDatabase(image: UIImage, name: String, callback: @escaping (String?) -> Void) {
        FirebaseModel.storageRef = Storage.storage().reference(forURL: FirebaseModel.storageRootPath)
        let fileRef = FirebaseModel.storageRef.child(name)
        if let data = UIImageJPEGRepresentation(image, 0.8) {
            fileRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    callback(nil)
                } else {
                    let downloadUrl = metadata!.downloadURL()
                    callback(downloadUrl?.absoluteString)
                }
            }
        }
    }
    
    static func getImageFromFirebase(url: String, callback: @escaping (UIImage?) -> Void) {
        FirebaseModel.storageRef = Storage.storage().reference(forURL: url)
        FirebaseModel.storageRef.getData(maxSize: 10000000, completion: { (data, error) in
            if error == nil && data != nil {
                let image = UIImage(data: data!)
                callback(image)
            } else {
                callback(nil)
            }
        })
    }
}
