//
//  MainMeetingViewCell.swift
//  Traveller
//
//  Created by Tal Sahar on 01/06/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit
import AIFlatSwitch

class HomeTripCell: UITableViewCell {

    @IBOutlet weak var flatSwitch: AIFlatSwitch!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var tripDescription: UITextView!
    

    func setData(trip: Trip) {
        guard let guideA = TravellerUserModel.instance.getUser(userId: trip.owners[0]) else {return}
        guard let guideB = TravellerUserModel.instance.getUser(userId: trip.owners[1]) else {return}
        guard let user = DefaultUser.getUser() else {return }
        guard let group = GroupModel.instance.getGroup(groupId: trip.id) else {return}
        let isRegistered = trip.owners.contains(user.id) || group.travellerIdList.contains(user.id)
        let image = user.imgUrl
        self.setData(image: image, name: trip.name, description: trip.description, guideA: guideA.fullname(), guideB: guideB.fullname(), isRegistered: isRegistered)
    }
    
    func setData(image: String? = nil, name: String, description: String, guideA: String, guideB: String, isRegistered: Bool) {
        if image == nil || image == "" {
            profileImage.image = UIImage(named: "default_profile")
        } else {
            ImageFirebaseStorage.loadImage(url: image!, onComplete: {
                if let image = $0 {
                    self.profileImage.image = image
                } else {
                    self.profileImage.image = UIImage(named: "default_profile")
                }
            })
        }
        self.name.text = name
        self.guideLabel.text = "Guides:\n\(guideA), \(guideB)"
        self.tripDescription.text = description
        self.flatSwitch.isSelected = isRegistered
        self.flatSwitch.isHidden = !isRegistered
    }
    
}
