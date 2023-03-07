//
//  HistoricViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import UIKit

class HistoricViewController: ViewController {
    @IBOutlet var historicTV: UITableView?
    
    let viewModel: HistoricViewModel?
    
    init(viewModel: HistoricViewModel) {
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
        self.historicTV?.delegate = self
        self.historicTV?.dataSource = self
        self.historicTV?.reloadData()
        self.historicTV?.register(UINib(nibName: HistoricCell.cellID, bundle: nil),
                                  forCellReuseIdentifier: HistoricCell.cellID)
        
    }
}

extension HistoricViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HistoricCell.cellID, for: indexPath) as? HistoricCell {
            return cell
        
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.showHistoricDetail()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = UIScreen.main.bounds.width
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        view.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 24, y: 5, width: 100, height: 30))
        label.text = "Abril"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.textGray
        view.addSubview(label)

        return view
    }
}
