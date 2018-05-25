import UIKit

class AllTripsTableViewController: UITableViewController {
    
    var allTrips = [Trip]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarStyle()
        _ = TravellerNotification.tripNotification.observe { _ in
            self.allTrips = TripModel.instance.data
            self.tableView.reloadData()
        }
        allTrips = TripModel.instance.data
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTrips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allTripsCell", for: indexPath) as! AllTripsTableViewCell
        let tripId = allTrips[indexPath.row].id
        cell.tripId = tripId
        cell.tripNameText.text = allTrips[indexPath.row].name
        cell.tripDscription.text = allTrips[indexPath.row].description
        
        if let user = DefaultUser.getUser() {
            guard let group = GroupModel.instance.getGroup(groupId: tripId) else { return cell }
            if (group.guideIdList.contains{$0 == user.id}) || group.travellerIdList.contains{$0 == user.id}{
                cell.inGroup = true
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = tableView.cellForRow(at: indexPath) as! AllTripsTableViewCell
        let user = DefaultUser.getUser()
        if row.inGroup {
            let cell = tableView.cellForRow(at: indexPath) as! AllTripsTableViewCell
            let id = cell.tripId
            performSegue(withIdentifier: "enterTripSegue", sender: id)
        } else {
                let alert = Alerts.joinGroupAlert(onAccept: {
                    GroupModel.instance.addUserToGroup(userId: (user?.id)!, groupId: row.tripId!){ error in
                        if error != nil {
                            ErrorAlerts.showPopupAlert(activator: self, title: (error?.localizedDescription)!, message: "", buttonAction: nil)
                        }else{
                            self.tableView.reloadData()
                        }
                    }
                }, onCancel: {
                    
                })
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterTripSegue"{
            let tripId = sender as! String
            let des = segue.destination as! GuideTabBarController
            des.tripId = tripId
        }
    }
}
