//
//  Alerts.swift
//  Traveller
//
//  Created by Tal Sahar on 21/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import UIKit
class Alerts {
    
    static func joinGroupAlert(onAccept: @escaping () -> Void, onCancel: @escaping () -> Void) -> UIAlertController{
        let alert = UIAlertController(title: "Would you like to Join this Group", message: "", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            onAccept()
            }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) in onCancel()}
        alert.addAction(yesAction)
        alert.addAction(noAction)
        return alert
    }
}

