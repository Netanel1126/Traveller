import UIKit

class TripsTableViewCell: UITableViewCell {
    
    var tripID:String?
    @IBOutlet weak var tripName: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    //save delete for the end because we need to update other devicces
//    @IBAction func removeTrip(_ sender: UIButton) {
//        AuthManager.getConnectedUser { (user) in
//            if user != nil{
//                TripModel.removeTrip(tripName: self.tripName.text!, tripCreatorID: (user?.id)!)
//                Logger.log(message: "\(self.tripName.text!) Was Removed", event: .d)
//                TripModel.getAllTrips(tripCreatorID: (user?.id)!)
//            }
//        }
//    }
}
