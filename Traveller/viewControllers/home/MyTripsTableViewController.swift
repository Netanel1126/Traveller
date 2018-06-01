import UIKit
class MyTripsTableViewController: UITableViewController {
    
    var data = [Trip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarStyle()
        
        let filter = { (trip: Trip) -> Bool in
            guard let group = GroupModel.instance.getGroup(groupId: trip.id) else {return false}
            guard let user = DefaultUser.getUser() else {return false}
            return group.travellerIdList.contains(user.id) || trip.owners.contains(user.id)
        }
        
            self.data = TripModel.instance.data.filter(filter)
            _ = TravellerNotification.tripNotification.observe { _ in
                self.data = TripModel.instance.data.filter(filter)
                self.tableView.reloadData()
            }
    }
       
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomeTripCell.self)", for: indexPath) as! HomeTripCell
            cell.setData(trip: data[indexPath.row])
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let id = data[indexPath.row].id
            performSegue(withIdentifier: "enterTripSegue", sender: id)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "enterTripSegue" {
                let tripId = sender as! String
                let des = segue.destination as! GuideTabBarController
                des.tripId = tripId
            }
        }
}
