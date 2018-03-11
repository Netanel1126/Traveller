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
    
    /*Adds new user to firebase returns a string by callback if error*/
    static func createNewUser(withEmail : String,password: String , callback: @escaping (String?)-> Void){
        Auth.auth().createUser(withEmail: withEmail, password: password){ (user, error) in
            if(error != nil){
                callback(error?.localizedDescription)
            }
            else{
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
}
