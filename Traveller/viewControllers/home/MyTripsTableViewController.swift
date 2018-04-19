import UIKit
class MyTripsTableViewController: UITableViewController {
    
    var dataObserver: Any?
    var data = [Trip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AuthManager.getConnectedUser { user in
            self.data = TripModel.instance.data
            self.dataObserver = TravellerNotification.tripNotification.observe { _ in
                self.data = TripModel.instance.data
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripsCell", for: indexPath) as! TripsTableViewCell
        let index = indexPath.row
        cell.tripName.text = data[index].tripName
        cell.descriptionText.text = data[index].tripDescription
        return cell
    }
}
