import UIKit

class LoginViewController: ViewController {

    @IBOutlet var backStackBackground: UIView!
    @IBOutlet var email: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var password: UITextField!
    var onComplete: ((TravellerUser) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        backStackBackground.layer.cornerRadius = 15
    }
   
    @IBAction func login(_ sender: UIButton) {
        if isLegalFields() {
            loginButton.isEnabled = false
            AuthManager.signIn(email: email.text!, password: password.text!, onComplete: { user in
                self.onComplete!(user)
            }, onFailure: { error in
                let errorPopup = ErrorPopupViewController.newInstance(msg: error.localizedDescription, onComplete: { self.loginButton.isEnabled = true })
                self.present(errorPopup, animated: true, completion: nil)
            })
        }
    }
    
    func isLegalFields() -> Bool{
        if !FieldValidation.isLegalEmail(str: email.text!) {
            let errorPopup = ErrorPopupViewController.newInstance(msg: "Illegal email address", onComplete: { self.loginButton.isEnabled = true })
            self.present(errorPopup, animated: true, completion: nil)
            return false
        }
        
        if !FieldValidation.isValidPassword(str: password.text!) {
            let errorPopup = ErrorPopupViewController.newInstance(msg: "Illegal password", onComplete: { self.loginButton.isEnabled = true })
            self.present(errorPopup, animated: true, completion: nil)
            return false
        }
        return true
    }
}
