//
//  CloseAccountViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 25/02/23.
//

import UIKit

class CloseAccountViewController: ViewController {
    @IBOutlet weak var numberOfPersonsText: UILabel?
    @IBOutlet weak var numberOfPersons: UILabel?
    @IBOutlet weak var personTotal: UILabel?
    @IBOutlet weak var totalValue: UILabel?
    @IBOutlet weak var addPersonsView: UIView?
    @IBOutlet weak var ordersTableTV: UITableView!
    
    let viewModel: CloseAccountViewModel?
    
    private var personsInTable: Int = 1
    private var totalAccountValue: Double = 250.00
    
    init(viewModel: CloseAccountViewModel) {
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
        self.title = "Encerrar a conta"
        self.setupViews()
        self.setupAccountDivision()
    }
    
    private func setupViews() {
        addPersonsView?.addBorder()
        setupTableView()
    }
    
    func setupTableView() {
        self.ordersTableTV?.delegate = self
        self.ordersTableTV?.dataSource = self
        self.ordersTableTV?.register(UINib(nibName: CurrentTableItemCell.cellID, bundle: nil),
                                      forCellReuseIdentifier: CurrentTableItemCell.cellID)
    }
    
    func setupAccountDivision() {
        self.numberOfPersons?.text = "\(self.personsInTable)"
        self.numberOfPersonsText?.text = "1 pessoa"
        if self.personsInTable > 1 {
            self.numberOfPersonsText?.text = "\(self.personsInTable) pessoas"
        }
        
        self.totalValue?.text = totalAccountValue.toCurrency()
        
        let accountDivision: Double = totalAccountValue / Double(personsInTable)
        self.personTotal?.text = accountDivision.toCurrency()
    }
    
    //MARK: actions
    @IBAction func closeAccount(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func addPersonInAccount(_ sender: Any) {
        personsInTable += 1
        setupAccountDivision()
    }
    
    @IBAction func removePersonInAccount(_ sender: Any) {
        if personsInTable > 1 {
            personsInTable -= 1
            setupAccountDivision()
        }
    }
}

extension CloseAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CurrentTableItemCell.cellID,
                                                    for: indexPath) as? CurrentTableItemCell {
            return cell
        
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = UIScreen.main.bounds.width
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        view.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 24, y: 0, width: 200, height: 20))
        label.text = "Resumo do consumo"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.textGray
        view.addSubview(label)

        return view
    }
}
