import UIKit

class AllTripsTableViewCell: UITableViewCell {

    var tripId:String?
    var inGroup:Bool?
    @IBOutlet weak var tripNameText: UILabel!
    @IBOutlet weak var tripDscription: UILabel!
    @IBOutlet weak var inGroupImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        AuthManager.getConnectedUser { (user) in
            if user != nil{
                self.userInGroup(travllerId: (user?.id)!)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func joinGroup(_ sender: UITapGestureRecognizer) {
        if inGroup == false{
            AuthManager.getConnectedUser { (user) in
                var alert = self.joinGroupAlert(tripId: self.tripId!, travllerId: (user?.id)!)
                TravellerNotification.JoinGroupNotification.post(data: alert)
            }
        }else{
            /*ToDo Move to TrevllerStoryBoard*/
        }
    }
    
    func userInGroup(travllerId:String){
        GroupModel.getGroup(groupId: tripId!, onSuccess: { (group) in
            if group != nil{
                if group.travellerIdList.contains(travllerId) || group.guideIdList.contains(travllerId){
                    self.inGroupImg.isHidden = false
                    self.inGroup = true
                }else{
                    self.inGroupImg.isHidden = true
                    self.inGroup = false
                }
            }
        }) { (error) in
            Logger.log(message: error.localizedDescription, event: .e)
        }
    }
    
    func joinGroupAlert(tripId:String ,travllerId:String) -> UIAlertController{
        let alert = UIAlertController(title: "Would you like to Join this Group", message: "", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            GroupModel.getGroup(groupId: tripId, onSuccess: { (group) in
                
                if group != nil{
                    group.travellerIdList.append(travllerId)
                    GroupModel.storeGroup(group: group, onComplete: { (error) in
                        if error != nil{
                            Logger.log(message: (error?.localizedDescription)!, event: .e)
                        }
                    })
                }
                
            }, onFailure: { (error) in
                if error != nil{
                    Logger.log(message: error.localizedDescription, event: .e)
                }
            })
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) in }
    
    alert.addAction(yesAction)
    alert.addAction(noAction)
    
    return alert
}
}
