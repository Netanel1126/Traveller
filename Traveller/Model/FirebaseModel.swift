import Foundation
import Firebase
import FirebaseDatabase

class FirebaseModel{
    
    static var databaseRef:DatabaseReference? = Database.database().reference()

    init() {
        FirebaseModel.databaseRef = Database.database().reference()
    }
    
    static func getConnectedUserAndObservecallback(callback: @escaping (String?)-> Void){
        let userEmail = Auth.auth().currentUser?.email;
        if userEmail != nil {
            print("User: \(userEmail) is Connected")
            callback(userEmail)
        }
        else{
            callback(nil)
        }
    }
    
    static func addUserToFirebase(user: TravellerUser){
        let myRef = databaseRef?.child("Users").child(user.email)
        myRef?.setValue(user.tojson())
    }
    
    /*Adds new user to firebase returns a string by callback if error*/
    static func createNewUser(userT: TravellerUser , callback: @escaping (String?)-> Void){
        
        if let userG = userT as? TravellerGuide{
            FirebaseModel.chackAuthentication(authentication: userG.authentication, callback: { (error) in
                if error != nil {
                    callback(error)
                    return
                }
            })
        }
        Auth.auth().createUser(withEmail: userT.email, password: userT.password){ (user, error) in
            if(error != nil){
                callback(error?.localizedDescription)
            }
            else{
                FirebaseModel.addUserToFirebase(user: userT)
                callback(nil)
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
                callback(nil)
            }
        }
    }
    
    static func chackAuthentication(authentication:String,callback: @escaping(String?)-> Void){
        var myRef = databaseRef?.child("Authentications").child(authentication)
        
        myRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            if let val = snapshot.value as? [String:Any]{
                callback(nil)
            }else{
                callback("Error - Authentication is incorrect")
            }
        })
    }
}
