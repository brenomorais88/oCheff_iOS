//
//  OrderViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 24/02/23.
//

import UIKit

class OrderViewController: ViewController {
    @IBOutlet weak var orderTV: UITableView?
    
    let viewModel: OrderViewModel?
    
    init(viewModel: OrderViewModel) {
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
        self.setupBackButton()
        self.title = "Enviar pedido"
        self.setupViews()
    }
    
    private func setupViews() {
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.orderTV?.delegate = self
        self.orderTV?.dataSource = self
        self.orderTV?.reloadData()
        self.orderTV?.register(UINib(nibName: OrderCell.cellID, bundle: nil),
                                        forCellReuseIdentifier: OrderCell.cellID)
    }
    
    // MARK: actions
    
    @IBAction func sendOrder(_ sender: Any) {
        self.showWarning(titleText: "Teste",
                         message: "Teste do componente padrao de mensagems com dois botoes",
                         showSecondaryButton: true,
                         buttonText: "ok, entendi",
                         secondaryButtonText: "cancelar",
                         delegate: self)
    }
}

extension OrderViewController: WarningProtocol {
    func didTapContinueButton() {
        for vc in self.navigationController?.viewControllers ?? [] {
            if ((vc as? CurrentTableViewController) != nil) {
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
        print("continuar")
    }
    
    func didTapSecondaryButton() {
        print("cancelar")
    }
}
                                    
extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.cellID,
                                                    for: indexPath) as? OrderCell {
            return cell
        
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
