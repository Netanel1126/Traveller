import Foundation
import Firebase
import FirebaseDatabase
/*
 Child List:
 Users: "Users/{userId}"
 Groups: "Groups/{groupId}"
 Trips: "Trips/{tripId}"
 */
class FirebaseModel{
    
    static var databaseRef:DatabaseReference? = Database.database().reference()
    static let groupPath = "Groups/"
    static let userPath = "Users/"
    static let tripPath = "Trips/"
    
    //path example "Users/{userId}"
    static func loadSingleObject(path: String, onComplete: @escaping ([String:Any]) -> Void, onFailure: @escaping (Error) -> Void) {
        let ref = databaseRef?.child(path)
        ref?.observeSingleEvent(of: .value, with: { snapshot in
            if let json = snapshot.value as? [String: Any] {
                onComplete(json)
            } else {
                let error = NSError(domain: "error reading \(path) from FirebaseDB", code: 0, userInfo: nil)
                onFailure(error)
            }
        })
    }
    
    //path example "Users/{userId}"
    static func storeObject(path: String, json: [String:Any], onComplete: @escaping (Error?) -> Void) {
        let ref = databaseRef?.child(path)
        ref?.setValue(json, withCompletionBlock: { (error, ref) in
            if error == nil {
                onComplete(nil)
            } else {
                Logger.log(message: "Error storing object \(path) on FirebaseDB", event: .e)
                onComplete(error!)
            }
        })
    }
    
    static func loadAllDataAndObserve(path: String, onUpdate: @escaping ([Dictionary<String,Any>])->Void){
        guard let ref = databaseRef?.child(path) else { return }
        ref.observe(DataEventType.value, with: {(snapshot:DataSnapshot) in
            Logger.log(message: "\(ref.key) : load all data)", event: .i)
            var childrensArray = [Dictionary<String,Any>]()
            for child in snapshot.children.allObjects{
                if let childData = child as? DataSnapshot{
                    if let dataJson = childData.value as? Dictionary<String,Any>{
                        childrensArray.append(dataJson)
                    }
                }
            }
            onUpdate(childrensArray)
        })
    }
}
