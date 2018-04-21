//
//  NibLoader.swift
//  Traveller
//
//  Created by Tal Sahar on 21/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func loadView(view: UIView){
        view.frame = bounds
        addSubview(view)
    }
}
