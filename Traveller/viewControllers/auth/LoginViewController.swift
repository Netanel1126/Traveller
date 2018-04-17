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
            }, onFailure: {_ in 
            })
        }
    }
    
    func isLegalFields() -> Bool{
        //TODO:: IMPLEMENT
        return true
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        
    }
}
