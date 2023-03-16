//
//  ProfileViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import UIKit

class ProfileViewController: ViewController {
    @IBOutlet weak var detailsStack: UIStackView?
    @IBOutlet weak var contactStack: UIStackView?
    @IBOutlet weak var preferencesStack: UIStackView?
    @IBOutlet weak var userImage: UIImageView?
    @IBOutlet weak var userName: UILabel?
    @IBOutlet weak var userDocument: UILabel?
    @IBOutlet weak var userPhone: UILabel?
    @IBOutlet weak var userMail: UILabel?
    
    var imagePicker = UIImagePickerController()
    let viewModel: ProfileViewModel?
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = nil
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func loadData() {
        self.showLoading()
        guard let phone = Defaults.shared.getSessionPhone() else { return }
        self.viewModel?.getUserFromPhone(phone: phone, callback: { success, user in
            self.dismissLoading()
            if success, let user = user {
                self.loadUserData(user: user)
                
            } else {
                print("show error")
            }
        })
    }
    
    private func loadUserData(user: User) {
        let name = user.name ?? ""
        let surName = user.surName ?? ""
        
        self.userName?.text = "\(name) \(surName)"
        self.userDocument?.text = user.document
        self.userPhone?.text = user.phone
        self.userMail?.text = user.email
        
        if let photo = user.photo {
            self.userImage?.image = UIImage.base64StringToImage(string: photo)
        }
    }

    private func setupViews() {
        self.detailsStack?.addBorder()
        self.contactStack?.addBorder()
        self.preferencesStack?.addBorder()
    }
    
    private func getImage(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func deleteImage() {
        userImage?.image = UIImage(named: "user_placeholder")
    }
    
    //MARK: actions
    
    @IBAction func editImage(_ sender: Any) {
        let alert = UIAlertController(title: "Alterar imagem", message: nil, preferredStyle: .actionSheet)
            
        alert.addAction(UIAlertAction(title: "Biblioteca", style: .default , handler:{ (UIAlertAction)in
            self.getImage(sourceType: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Câmera", style: .default , handler:{ (UIAlertAction)in
            self.getImage(sourceType: .camera)
        }))

        alert.addAction(UIAlertAction(title: "Remover", style: .destructive , handler:{ (UIAlertAction)in
            self.deleteImage()
        }))
            
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        alert.popoverPresentationController?.sourceView = self.view

        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func openSuport(_ sender: Any) {
        
    }
    
    @IBAction func changePassword(_ sender: Any) {
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        Defaults.shared.cleanSessionPhone()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setRootNotLoggedUser()
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImage?.image = image
        }

        picker.dismiss(animated: true, completion: nil);
    }
}


