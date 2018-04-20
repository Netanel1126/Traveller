import UIKit

class MyTripsTableViewController: UITableViewController {
    
    var trips:[Trip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TravellerNotification.getAllTripsNotifcation.observe { (new_trips) in
            if new_trips != nil{
                self.trips.removeAll()
                self.trips = new_trips!
                self.tableView.reloadData()
            }
        }
        
        AuthManager.getConnectedUser { (user) in
            if user != nil{
                TripModel.getAllTrips(tripCreatorID: (user?.id)!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Logger.log(message: trips.count.description, event: .d)
        return trips.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripsCell", for: indexPath) as! TripsTableViewCell
        
        let content = trips[indexPath.row]
        
        cell.tripName.text = content.tripName
        cell.descriptionText.text = content.tripDescription
        
        return cell
    }

}
