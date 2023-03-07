//
//  EstablishmentsViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 19/02/23.
//

import UIKit

class EstablishmentsViewController: UIViewController {

    @IBOutlet var establishmentsTV: UITableView?
    @IBOutlet weak var searchTextField: UITextField?
    @IBOutlet weak var categoriesColection: UICollectionView?
    
    let viewModel: EstablishmentsViewModel?
    let categories: [String] = ["Tudo", "Oriental", "Italiano", "Burguer", "Doce", "Arabe", "Brasileira", "Outros"]
    
    init(viewModel: EstablishmentsViewModel) {
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
        self.title = "Etabelecimentos"
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupViews() {
        self.setupCollectionView()
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.establishmentsTV?.delegate = self
        self.establishmentsTV?.dataSource = self
        self.establishmentsTV?.reloadData()
        self.establishmentsTV?.register(UINib(nibName: EstablishmentCell.cellID, bundle: nil),
                                        forCellReuseIdentifier: EstablishmentCell.cellID)
    }
    
    private func setupCollectionView() {
        self.categoriesColection?.delegate = self
        self.categoriesColection?.dataSource = self
        self.categoriesColection?.register(UINib(nibName: CategoriesCollCell.cellID, bundle: nil),
                                           forCellWithReuseIdentifier: CategoriesCollCell.cellID)
        self.categoriesColection?.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
    }
    
    //MARK: actions
    
    @IBAction func showFilter(_ sender: Any) {
        let vc = EstablishmentFilterViewController(delegate: self)
        self.present(vc, animated: true, completion: nil)
    }
}

extension EstablishmentsViewController: UITableViewDelegate, UITableViewDataSource {
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
        self.viewModel?.showEstablishment()
    }
}

extension EstablishmentsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollCell.cellID, for: indexPath) as? CategoriesCollCell {
            let categorie = self.categories[indexPath.row]
            cell.setupCell(name: categorie)
            return cell
        
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categorie = self.categories[indexPath.row]
        let height: CGFloat = 40
        let width: CGFloat = categorie.widthOfString(usingFont: UIFont.systemFont(ofSize: 16)) + 20
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.establishmentsTV?.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}


extension EstablishmentsViewController: EstablishmentFilterProtocol {
    func applyFilter() {
        
    }
}
