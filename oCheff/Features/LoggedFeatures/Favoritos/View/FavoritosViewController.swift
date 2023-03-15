//
//  FavoritosViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 20/02/23.
//

import UIKit

class FavoritosViewController: ViewController {

    @IBOutlet var favoritesTV: UITableView?
    @IBOutlet weak var searchTextField: UITextField?
    
    let viewModel: FavoritosViewModel?
    var establishments: [EstablishmentResponse] = []
    
    init(viewModel: FavoritosViewModel) {
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
        self.loadContentData()
        self.setupBackButton()
        self.title = "Favoritos"
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupViews() {
        self.setupTableView()
    }
    
    private func loadContentData() {
        
        self.viewModel?.getFavoritesEstablishments(callback: { sucsess, response in
            self.establishments = response ?? []
            self.favoritesTV?.reloadData()
        })
    }

    private func setupTableView() {
        self.favoritesTV?.delegate = self
        self.favoritesTV?.dataSource = self
        self.favoritesTV?.reloadData()
        self.favoritesTV?.register(UINib(nibName: EstablishmentCell.cellID, bundle: nil),
                                        forCellReuseIdentifier: EstablishmentCell.cellID)
    }
}

extension FavoritosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.establishments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: EstablishmentCell.cellID,
                                                    for: indexPath) as? EstablishmentCell {
            let establishment = self.establishments[indexPath.row]
            cell.setupCell(establishment: establishment)
            return cell
        
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.showEstablishment()
    }
}
