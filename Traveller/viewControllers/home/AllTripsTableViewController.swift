import UIKit

class AllTripsTableViewController: UITableViewController {
    
    var allTrips = [Trip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = TravellerNotification.tripNotification.observe { _ in
            self.allTrips = TripModel.instance.data
            self.tableView.reloadData()
        }
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
            let group = GroupModel.instance.data.filter{$0.groupId == tripId}.first
            if (group?.guideIdList.contains{$0 == user.id})! || (group?.travellerIdList.contains{$0 == user.id})! {
                cell.inGroup = true
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = tableView.cellForRow(at: indexPath) as! AllTripsTableViewCell
        if row.inGroup {
            //TODO:: Implement
        } else {
            if let user = DefaultUser.getUser() {
                let alert = Alerts.joinGroupAlert(onAccept: {
                    GroupModel.instance.addUserToGroup(userId: user.id, groupId: row.tripId!){ error in
                        if error != nil {
                            //TODO:: Implement
                        }
                    }
                }, onCancel: {
                    
                })
            alert.show(self, sender: nil)
            }
        }
    }
}
