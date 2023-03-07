//
//  ProfileViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 18/02/23.
//

import UIKit

class ProfileViewController: ViewController {
    @IBOutlet weak var detailsStack: UIStackView?
    @IBOutlet weak var contactStack: UIStackView?
    @IBOutlet weak var preferencesStack: UIStackView?
    @IBOutlet weak var userImage: UIImageView?
        
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
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
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


