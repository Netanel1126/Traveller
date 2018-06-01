import UIKit
class MyTripsTableViewController: UITableViewController {
    
    var data = [Trip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarStyle()
        if let user = DefaultUser.getUser() {
            self.data = TripModel.instance.data
            _ = TravellerNotification.tripNotification.observe { _ in
                self.data = TripModel.instance.data.filter {
                    if $0.owners.contains(user.id) {
                        return true
                    } else {
                        if let isTraveler = GroupModel.instance.getGroup(groupId: $0.id)?.travellerIdList.contains(user.id) {
                            return isTraveler
                        } else {
                            return false
                        }
                    }
                }
                self.tableView.reloadData()
            }
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
