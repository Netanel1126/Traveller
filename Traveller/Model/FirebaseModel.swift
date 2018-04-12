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
    
    static func saveGroupToDatabase(group: Group) {
        let ref = databaseRef?.child("Groups").child("\(group.getName())")
        ref?.setValue(group.toJson())
    }
    
    static func saveTripToDatabase(trip: Trip) {
        let ref = databaseRef?.child("Trips").child("\(trip.getName())")
        ref?.setValue(trip.toJson())
    }
}
