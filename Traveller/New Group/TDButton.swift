//
//  Created by Tal Sahar on 02/04/2018.
//  Copyright © 2018 Globalbit. All rights reserved.
//

import Foundation
import UIKit
class TDButton: UIButton {
    @IBInspectable var buttonDefaultColor: UIColor = UIColor.blue
    @IBInspectable var hoverColor: UIColor = UIColor.lightGray
    @IBInspectable var disableColor: UIColor = UIColor.lightGray
    @IBInspectable var borderColor: UIColor = UIColor.clear
    @IBInspectable var clickBorderColor: UIColor = UIColor.clear
    @IBInspectable var disableBorderColor: UIColor = UIColor.clear

    required override init(frame: CGRect) {
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
        addTarget(self, action: #selector(onRelease(_:)), for: .touchDragExit)
    }
    
    override func awakeFromNib() {
        backgroundColor = buttonDefaultColor
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 1
        self.isEnabled = Bool(isEnabled)
    }
    
    override var isEnabled: Bool {
        didSet {
            isEnabled ? onRelease(self) : onDisable(self)
        }
    }
    
    @objc func onClick(_: UIButton) {
        backgroundColor = hoverColor
        layer.borderColor = clickBorderColor.cgColor
    }
    
    @objc func onRelease(_: UIButton) {
        backgroundColor = buttonDefaultColor
        layer.borderColor = borderColor.cgColor
    }
    
    @objc func onDisable(_: UIButton) {
        backgroundColor = disableColor
        layer.borderColor = disableBorderColor.cgColor
    }
}
