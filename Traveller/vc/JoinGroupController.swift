//
//  JoinGroupController.swift
//  Traveller
//
//  Created by sapir shloush on 16.1.2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import UIKit

// Allows joining to a group with group id.
// Connected to LoginAndGuideHomePage.storyboard
class JoinGroupController : UIViewController {
    
    @IBOutlet weak var groupIdTextField: UITextField!
    
    // TODO: add some decoration to the screen
    
    @IBAction func joinGroup(_ sender: Any) {
        FirebaseModel.getDataFromFB(byId: groupIdTextField.text!, table: "Groups") { (correspondingGroup) in
            
        }
    }
}
