import UIKit

class AllTripsTableViewCell: UITableViewCell {

    var tripId:String?
    var inGroup:Bool = false {
        didSet {
            if inGroup == true {
                self.inGroupImg.isHidden = false
            }
        }
    }
    @IBOutlet weak var tripNameText: UILabel!
    @IBOutlet weak var tripDscription: UILabel!
    @IBOutlet weak var inGroupImg: UIImageView!
}
