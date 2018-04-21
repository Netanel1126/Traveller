import UIKit

class MapAlerts{
    
    static func getEndDrawingAlert(map:[Position],myMap:MyMapView, tripName:String, tripDesc:String) -> UIAlertController{
        let alert = UIAlertController(title: "Are you finish editing?", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Apply", style: .default){
            (action) in
            myMap.drawing = false
            myMap.isScrollEnabled = true

            // Saving the trip in Firebase Database
            // TripModel class is inside model/db
            AuthManager.getConnectedUser { (user) in
                if(user != nil){
                    let tripId = UUID().uuidString
                    let trip = Trip(tripId: tripId, ownerId: (user?.id)!, name: tripName, description: tripDesc, path: map)
                    TripModel.instance.storeTrip(trip: trip) {
                        error in
                        if error != nil {
                            Logger.log(message: (error?.localizedDescription)! , event: .e)
                        }
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

