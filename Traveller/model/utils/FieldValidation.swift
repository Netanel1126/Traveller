//
//  FieldValidation.swift
//  Traveller
//
//  Created by Tal Sahar on 12/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
public class FieldValidation {
    static func isLegalEmail(str: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: str)
    }
    
    static func isValidPassword() -> Bool {
        let passwordRegex = ".{8}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    static func isLegalName(str: String) -> Bool {
        return str.count > 3 && str.count < 20
    }
}
