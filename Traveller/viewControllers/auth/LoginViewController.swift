import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var onComplete: ((TravellerUser) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func login(_ sender: UIButton) {
        if isLegalFields() {
            AuthManager.signIn(email: email.text!, password: password.text!, onComplete: { user in
                self.onComplete!(user)
            }, onFailure: { error in
                ErrorAlerts.showPopupAlert(activator: self, title: "Authentication failed", message: error.localizedDescription, buttonAction: nil)
            })
        } else {
            ErrorAlerts.showPopupAlert(activator: self, title: "Email or password is invalid", message: "", buttonAction: nil)
        }
    }
    
    // Validates that the inserted email has a '@' sign, doesn't have a '.' sign before '@' and doesn't have empty textboxes.
    func isLegalFields() -> Bool{
        let emailText : String = email.text!
        let passwordText : String = password.text!
        let startIndex = emailText.startIndex
        var loopingIndex : String.Index
        var offset = 0
        var flag = false
        
        if emailText == "" || passwordText == "" { return false }
        
        while offset < emailText.count {
            loopingIndex = emailText.index(startIndex, offsetBy: offset)
            
            if emailText[loopingIndex] == "@" {
                if emailText[emailText.index(before: loopingIndex)] == "." { return false }
                flag = true
                break
            }
            
            offset = offset + 1
        }
        
        if !flag {
            return false
        }
        
        return true
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        
    }
}
