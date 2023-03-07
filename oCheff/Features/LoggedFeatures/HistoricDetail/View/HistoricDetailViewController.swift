//
//  HistoricDetailViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 19/02/23.
//

import UIKit


class HistoricDetailViewController: ViewController {
    @IBOutlet var historicTV: UITableView?
    
    let viewModel: HistoricDetailViewModel?
    
    init(viewModel: HistoricDetailViewModel) {
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
        self.title = "Resumo do Pedido"
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupViews() {
        self.historicTV?.delegate = self
        self.historicTV?.dataSource = self
        self.historicTV?.reloadData()
        self.historicTV?.register(UINib(nibName: HistoricDetailItemCell.cellID, bundle: nil),
                                  forCellReuseIdentifier: HistoricDetailItemCell.cellID)
        self.historicTV?.register(UINib(nibName: HistoricDetailHeaderCell.cellID, bundle: nil),
                                  forCellReuseIdentifier: HistoricDetailHeaderCell.cellID)
        self.historicTV?.register(UINib(nibName: HistoricDetailBottomCell.cellID, bundle: nil),
                                  forCellReuseIdentifier: HistoricDetailBottomCell.cellID)
        
    }
}

extension HistoricDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 2:
            return 1
        
        default:
            return 4
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HistoricDetailHeaderCell.cellID,
                                                        for: indexPath) as? HistoricDetailHeaderCell {
                return cell
            
            }
            
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HistoricDetailItemCell.cellID,
                                                        for: indexPath) as? HistoricDetailItemCell {
                return cell
            
            }
            
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HistoricDetailBottomCell.cellID,
                                                        for: indexPath) as? HistoricDetailBottomCell {
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
            return 35
            
        case 2:
            return 125
            
        default:
            return 0
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let customCell = cell as? HistoricDetailBottomCell {
//            customCell.setupLayout()
//        }
//    }
}
