//
//  NewTableViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 20/02/23.
//

import UIKit

class NewTableViewController: ViewController {
    
    @IBOutlet weak var establishmentsTV: UITableView?
    @IBOutlet weak var codeTextField: UITextField?
    @IBOutlet weak var searchTableBtn: UIButton?
    @IBOutlet weak var qrCodeBtn: UIButton?
    
    let viewModel: NewTableViewModel?
    
    init(viewModel: NewTableViewModel) {
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
        self.title = "Abrir nova mesa"
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupViews() {
        self.setupTableView()
        searchTableBtn?.setupSecondaryBtn()
    }

    private func setupTableView() {
        self.establishmentsTV?.delegate = self
        self.establishmentsTV?.dataSource = self
        self.establishmentsTV?.reloadData()
        self.establishmentsTV?.register(UINib(nibName: EstablishmentCell.cellID, bundle: nil),
                                        forCellReuseIdentifier: EstablishmentCell.cellID)
    }
    
    //MARK: actions
    
    @IBAction func searchTable(_ sender: Any) {
    
    }
    
    @IBAction func showQrCode(_ sender: Any) {
    
    }
    
}

extension NewTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: EstablishmentCell.cellID,
                                                    for: indexPath) as? EstablishmentCell {
            return cell
        
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.viewModel?.delegate else {
            return
        }
        self.showCurrentTable(delegate: delegate)
    }
}

