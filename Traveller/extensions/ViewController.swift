//
//  ViewController.swift
//  Traveller
//
//  Created by Tal Sahar on 26/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarStyle()
    }
}

extension UIViewController {
    // Background Color gradient
    var colors: [UIColor] {
        var colors = [UIColor]()
        colors.append(UIColor(red: 21 / 255, green: 163 / 255, blue: 204 / 255, alpha: 1))
        colors.append(UIColor(red: 21 / 255, green: 204 / 255, blue: 198 / 255, alpha: 1))
        return colors
    }
    
    func setNavigationBarStyle() {
        // NavigationBar styling
        if let navigationBar = navigationController?.navigationBar {
            // navigationBar background Color gradient
            navigationController?.navigationBar.setGradientBackground(colors: colors)
            navigationBar.layer.masksToBounds = false
            // Shadow
            navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
            navigationBar.layer.shadowOpacity = 0.6
            navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            navigationBar.layer.shadowRadius = 2
            navigationBar.shadowImage = UIImage()
            // Title
            navigationBar.titleTextAttributes = [
                NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white,
                NSAttributedStringKey.font: UIFont(name: "Helvetica", size: 19)!,
            ]
            // back button
            self.navigationController?.navigationBar.tintColor = UIColor.white
        }
    }
    
    func hideKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
