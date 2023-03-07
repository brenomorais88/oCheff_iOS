//
//  CurrentTableViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 24/02/23.
//

import UIKit

class CurrentTableViewController: ViewController {
    @IBOutlet weak var currentTableTV: UITableView?
    @IBOutlet weak var sendRequestsBtn: UIButton?
    
    let viewModel: CurrentTableViewModel?
    
    init(viewModel: CurrentTableViewModel) {
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
        self.setupBackButton()
        self.title = "Mesa atual"
    }
    
    private func setupViews() {
        setupTableView()
        sendRequestsBtn?.setupSecondaryBtn()
    }
    
    func setupTableView() {
        self.currentTableTV?.delegate = self
        self.currentTableTV?.dataSource = self
        self.currentTableTV?.register(UINib(nibName: CurrentTableHeaderCell.cellID, bundle: nil),
                                      forCellReuseIdentifier: CurrentTableHeaderCell.cellID)
        self.currentTableTV?.register(UINib(nibName: CurrentTableItemCell.cellID, bundle: nil),
                                      forCellReuseIdentifier: CurrentTableItemCell.cellID)
    }
    
    // MARK: actions

    @objc
    override func backAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func finishAccount(_ sender: Any) {
        self.viewModel?.closeAccount()
    }
    
    @IBAction func sendOrder(_ sender: Any) {
        self.viewModel?.sendOrder()
    }
}


extension CurrentTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        
        case 1:
            return 8
        
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CurrentTableHeaderCell.cellID,
                                                        for: indexPath) as? CurrentTableHeaderCell {
                cell.setup(delegate: self)
                return cell
            
            }
            
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CurrentTableItemCell.cellID,
                                                        for: indexPath) as? CurrentTableItemCell {
                return cell
            
            }
            
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 180
            
        case 1:
            return 85
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 20 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 1 { return nil }
        
        let width = UIScreen.main.bounds.width
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        view.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 24, y: 0, width: 100, height: 20))
        label.text = "Pedidos"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.textGray
        view.addSubview(label)

        return view
    }
}


extension CurrentTableViewController: CurrentTableHeaderCellProtocol {
    func openMenu() {
        self.viewModel?.openMenu()
    }
    
    func callWaiter() {
        self.viewModel?.callWaiter()
    }
}
