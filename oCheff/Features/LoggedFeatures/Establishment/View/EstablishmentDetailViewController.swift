//
//  EstablishmentDetailViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 20/02/23.
//

import UIKit
import MapKit

class EstablishmentDetailViewController: ViewController {
    @IBOutlet weak var waitListButton: UIButton!
    @IBOutlet weak var openTableButton: UIButton!
    
    let viewModel: EstablishmentDetailViewModel?
    
    init(viewModel: EstablishmentDetailViewModel) {
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
        self.setupBackButton(color: .white)
        self.setupTranslucentNavBar()
        self.setupFavoriteButtom()
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
       return .lightContent
   }
    
    private func setupViews() {
        self.waitListButton.setupSecondaryBtn()
    }
    
    //MARK: actions
    
    @IBAction func showMenu(_ sender: Any) {
        self.viewModel?.openMenu()
    }
    
    @IBAction func enterWaitList(_ sender: Any) {
        self.showWarning(titleText: "Teste",
                         message: "Teste do componente padrao de mensagems com dois botoes",
                         buttonText: "ok, entendi",
                         delegate: self)
        
    }
    
    @IBAction func openNewTable(_ sender: Any) {
        guard let delegate = self.viewModel?.delegate else {
            return
        }
        self.showCurrentTable(delegate: delegate)
    }
    
    @IBAction func showRoutes(_ sender: Any) {
        let alert = UIAlertController(title: "Qual aplicativo você deseja usar?", message: nil, preferredStyle: .actionSheet)
            
        alert.addAction(UIAlertAction(title: "Waze", style: .default , handler:{ (UIAlertAction)in
            print("abrir waze")
        }))
        
        alert.addAction(UIAlertAction(title: "Google Maps", style: .default , handler:{ (UIAlertAction)in
            print("abrir gg maps")
        }))

        alert.addAction(UIAlertAction(title: "Maps", style: .default , handler:{ (UIAlertAction)in
            print("abrir apple maps")
        }))
            
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        alert.popoverPresentationController?.sourceView = self.view

        self.present(alert, animated: true, completion: nil)
    }
    
    override func tapFavoriteIcon() {
        print("favoritar")
    }
}

extension EstablishmentDetailViewController: WarningProtocol {
    func didTapContinueButton() {
        print("continuar")
    }
    
    func didTapSecondaryButton() {
        print("cancelar")
    }
}
