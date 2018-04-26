//
//  Created by Tal Sahar on 02/04/2018.
//  Copyright © 2018 Globalbit. All rights reserved.
//

import Foundation
import UIKit
class TDButton: RoundButton {
    @IBInspectable var buttonColor: UIColor = UIColor.blue
    @IBInspectable var hoverColor: UIColor = UIColor.lightGray
    @IBInspectable var disableColor: UIColor = UIColor.lightGray
    @IBInspectable var defaultBorderColor: UIColor = UIColor.clear
    @IBInspectable var clickBorderColor: UIColor = UIColor.clear
    @IBInspectable var disableBorderColor: UIColor = UIColor.clear
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
    
    func configureButton() {
        addTarget(self, action: #selector(onClick(_:)), for: .touchDown)
        addTarget(self, action: #selector(onRelease(_:)), for: .touchUpInside)
    }
    
    override var isEnabled: Bool {
        didSet {
            isEnabled ? onRelease(self) : onDisable(self)
        }
    }
    
    @objc func onClick(_: UIButton) {
        backgroundColor = hoverColor
        borderColor = clickBorderColor
    }
    
    @objc func onRelease(_: UIButton) {
        backgroundColor = buttonColor
        borderColor = defaultBorderColor
    }
    
    @objc func onDisable(_: UIButton) {
        backgroundColor = disableColor
        borderColor = disableBorderColor
    }
}
