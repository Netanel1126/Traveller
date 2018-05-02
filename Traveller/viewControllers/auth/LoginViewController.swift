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
    
    //TODO:: Implement using FieldValidation
    func isLegalFields() -> Bool{
        
        return true
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        
    }
}
