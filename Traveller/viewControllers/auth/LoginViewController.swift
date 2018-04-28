import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var onComplete: ((TravellerUser) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
