import UIKit

class AllTripsTableViewController: UITableViewController {
    
    var allTrips = [Trip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TravellerNotification.tripNotification.observe { (v) in
            self.allTrips = TripModel.instance.data
            self.tableView.reloadData()
        }
        
        TravellerNotification.JoinGroupNotification.observe { (alert) in
            self.present(alert!, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allTrips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "allTripsCell", for: indexPath) as! AllTripsTableViewCell
        
        cell.tripId = allTrips[indexPath.row].id
        cell.tripNameText.text = allTrips[indexPath.row].name
        cell.tripDscription.text = allTrips[indexPath.row].description
        
        return cell
    }

}
