//
//  ErrorPopupViewController.swift
//  Traveller
//
//  Created by Tal Sahar on 05/05/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

class ErrorPopupViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var errorMsg: UILabel!
    var preErrorMsg: String?
    var onComplete: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 15
        errorMsg.text = preErrorMsg
    }

    @IBAction func confirmTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        if let onComplete = onComplete {
            onComplete()
        }
    }
    
    static func newInstance(msg: String, onComplete: (() -> ())?) -> ErrorPopupViewController {
        let storyboard = UIStoryboard(name: "Popups", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ErrorPopupViewController") as! ErrorPopupViewController
        vc.preErrorMsg = msg
        if let onComplete = onComplete {
            vc.onComplete = onComplete
        }
        return vc
    }
}
