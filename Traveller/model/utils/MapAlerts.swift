import UIKit

class MapAlerts{
    
    static func getEndDrawingAlert(map:[Position],myMap:MyMapView, tripName:String, tripDesc:String) -> UIAlertController{
        let alert = UIAlertController(title: "Are you finish editing?", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Apply", style: .default){
            (action) in
            print(map)
            myMap.drawing = false
            myMap.isScrollEnabled = true
            
            // Creating and saving the corresponding group in Firebase Database
            // GroupModel class is inside model/db
            
            /*Why?????
            AuthManager.getConnectedUser { (user) in
                if(user != nil){
                    let newGroup = Group(ownerId: (user?.id)!, groupName: "Group for " + newTrip.getName())
                    GroupModel.storeGroup(group: newGroup) { (error) in
                        print(error!)
                    }
                }*/
                
                // Saving the trip in Firebase Database
                // TripModel class is inside model/db
            AuthManager.getConnectedUser { (user) in
                if(user != nil){
                    TripModel.instance.storeTrip(tripCreatorID: (user!.id), tripName: tripName, trip: Trip(name: tripName, description: tripDesc ,path: map)) { (error) in
                        Logger.log(message: (error?.localizedDescription)! , event: .e)
                    }
                }
            }
            
            TravellerNotification.PopupEndNotification.post(data: true)

        }
        
        let action2 = UIAlertAction(title: "Dismiss", style: .destructive){
            (action) in
            myMap.clearCanvas()
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        return alert
    }
    
    static func ChangeDrawingAlert(myMap:MyMapView,callback: @escaping (UIAlertController) -> Void){
        let alert = UIAlertController(title: "Would you like to change your drawing?", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Yes", style: .default){
            (action) in
            myMap.clearCanvas()
            myMap.drawing = true
            myMap.isScrollEnabled = false
        }
        
        let action2 = UIAlertAction(title: "No", style: .destructive){
            (action) in
            myMap.drawing = false
            
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        callback(alert)
    }
    
}

