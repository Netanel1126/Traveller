//
//  Alerts.swift
//  Traveller
//
//  Created by admin on 30/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import UIKit

class ErrorAlerts {
    
    static func showPopupAlert(activator: UIViewController, title: String, message: String, buttonAction: ((UIAlertAction) -> Swift.Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: buttonAction)
        
        alert.addAction(OKAction)
        activator.present(alert, animated: true, completion: nil)
    }
}
