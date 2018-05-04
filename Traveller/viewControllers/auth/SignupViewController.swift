import UIKit

class SignupViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var verifyPassword: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    var onComplete: ((TravellerUser) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configure image gesture
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(chooseImageFromGallery(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(imageTap)
    }
    
    @objc func chooseImageFromGallery(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.allowsEditing = true
            present(controller, animated: true, completion: nil)
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.profileImage.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signup(_ sender: Any) {
        if verifyFields() {
            signupButton.isEnabled = false
            let imageName = "profile_\(String(describing: firstName.text))_\(String(describing: lastName.text))_\(UUID().uuidString)"
            ImageFirebaseStorage.storeImage(image: profileImage.image!, name: imageName) {
                imageUrl in
                let signupStruct = TravellerUser.SignUpStruct(email: self.email.text!, password: self.password.text!, firstName: self.firstName.text!, lastName: self.lastName.text!, phone: self.phone.text!, imgUrl: imageUrl)
                AuthManager.signUp(userStruct: signupStruct, onComplete: {
                    user in
                    self.onComplete!(user)
                }, onFailure: {
                    error in
                })
            }
        }
    }
    
    func verifyFields() -> Bool {
        let user = TravellerUserModel.instance.data.filter {$0.firstName == firstName.text && $0.lastName == lastName.text}.first
        if user != nil {
            return false
        }
        //TODO:: Implement (create class which check every field)
        return true
    }
}
