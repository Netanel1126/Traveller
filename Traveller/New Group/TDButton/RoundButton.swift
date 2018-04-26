//
//  Created by Tal Sahar on 27/03/2018.
//  Copyright © 2018 Globalbit. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    required override init(frame: CGRect) {
        super.init(frame: frame)
        configureRadius()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureRadius()
    }
    
    func configureRadius() {
        layer.cornerRadius = frame.height / 2
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            layer.borderWidth = 1
        }
    }
}
