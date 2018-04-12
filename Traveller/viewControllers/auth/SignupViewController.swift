import UIKit

class SignupViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var fNameText: UITextField!
    @IBOutlet weak var lnameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var phoneNumText: UITextField!
    @IBOutlet weak var userIMG: UIImageView!
    var selectedImage: UIImage? {
        didSet {
            if let selectedImage = selectedImage {
                userIMG.image = selectedImage
            }
        }
    }
    var onComplete: ((TravellerUser) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configure image gesture
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(chooseImageFromGallery(tapGestureRecognizer:)))
        userIMG.isUserInteractionEnabled = true
        userIMG.addGestureRecognizer(imageTap)
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
        selectedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signup(_ sender: Any) {
        if verifyFields() {
            let imageName = "profile_\(String(describing: fNameText.text))_\(String(describing: lnameText.text))_\(UUID().uuidString)"
            ImageFirebaseStorage.storeImage(image: userIMG.image!, name: imageName) {
                imageUrl in
                let signupStruct = TravellerUser.SignUpStruct(email: self.emailText.text!, password: self.passwordText.text!, firstName: self.fNameText.text!, lastName: self.lnameText.text!, phone: self.phoneNumText.text!, imgUrl: imageUrl!)
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
        //TODO:: Implement (create class which check every field)
        return true
    }
}
