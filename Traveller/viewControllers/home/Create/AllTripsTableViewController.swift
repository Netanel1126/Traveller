import UIKit
import RxSwift

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTripCell", for: indexPath) as! HomeTripCell
        cell.setData(trip: allTrips[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = tableView.cellForRow(at: indexPath) as? HomeTripCell else {return}
        guard let user = DefaultUser.getUser() else {return}
        let trip = allTrips[indexPath.row]
        if row.flatSwitch.isSelected {
            let id = trip.id
            performSegue(withIdentifier: "enterTripSegue", sender: id)
        } else {
            let alert = Alerts.joinGroupAlert(onAccept: {
                GroupModel.instance.addUserToGroup(userId: user.id, groupId: trip.id){ error in
                    if error != nil {
            self.navigationController?.show(ErrorPopupViewController.newInstance(msg: "Error adding user to group", onComplete: nil), sender: nil)
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
