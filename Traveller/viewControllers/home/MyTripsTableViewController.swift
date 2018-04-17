import UIKit

class MyTripsTableViewController: UITableViewController {
    
    // TODO:: use notifications to add trips list from Firebase. I don't remember what function of TableView refreshes or updates data to it, sorry.

    var trips:[Trip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TravellerNotification.getAllTripsNotifcation.observe { (trips) in
            self.trips = trips!
            self.tableView.reloadData()
        }
        
        AuthManager.getConnectedUser { (user) in
            if user != nil{
                TripModel.getAllTrips(tripCreatorID: (user?.id)!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripsCell", for: indexPath) as! TripsTableViewCell
        
        

        return cell
    }

}
