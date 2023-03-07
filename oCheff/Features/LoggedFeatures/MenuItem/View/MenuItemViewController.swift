//
//  MenuItemViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 24/02/23.
//

import UIKit

class MenuItemViewController: UIViewController {
    @IBOutlet weak var addQuantityView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    let viewModel: MenuItemViewModel?
    private var quantity: Int = 1
    
    init(viewModel: MenuItemViewModel) {
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
        addQuantityView?.addBorder()
        setupQuantity()
    }
    
    func setupQuantity() {
        self.quantityLabel?.text = "\(self.quantity)"
    }

    //MARK: actions
    
    @IBAction func addItem(_ sender: Any) {
        self.backAction()
    }
    
    @IBAction func addQuantity(_ sender: Any) {
        quantity += 1
        setupQuantity()
    }
    
    @IBAction func removeQuantity(_ sender: Any) {
        if quantity > 1 {
            quantity -= 1
            setupQuantity()
        }
    }
}
