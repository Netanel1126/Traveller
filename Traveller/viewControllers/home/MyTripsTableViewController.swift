import UIKit
class MyTripsTableViewController: UITableViewController {
    
    var data = [Trip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = DefaultUser.getUser() {
            self.data = TripModel.instance.data
            _ = TravellerNotification.tripNotification.observe { _ in
                self.data = TripModel.instance.data.filter { $0.owners.contains(user.id) }
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = DefaultUser.getUser() {
            let allData = TripModel.instance.data
            data = allData.filter {$0.owners.contains(user.id)}
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripsCell", for: indexPath) as! TripsTableViewCell
        let index = indexPath.row
        cell.tripID = data[index].id
        cell.tripName.text = data[index].name
        cell.descriptionText.text = data[index].description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TripsTableViewCell
        let id = cell.tripID
        //if (TripModel.instance.getTrip(tripId: id!)?.owners.contains((DefaultUser.getUser()?.id)!))! {
            performSegue(withIdentifier: "enterTripSegue", sender: id)
       // } else {
           // performSegue(withIdentifier: "enterAsGuestSegue", sender: id)
       // }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterTripSegue" {
            let tripId = sender as! String
            let des = segue.destination as! GuideTabBarController
            des.tripId = tripId
        }
    }
    
}
