//
//  EstablishmentsViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 19/02/23.
//

import UIKit

class EstablishmentsViewController: ViewController {

    @IBOutlet var establishmentsTV: UITableView?
    @IBOutlet weak var searchTextField: UITextField?
    @IBOutlet weak var categoriesColection: UICollectionView?
    
    let viewModel: EstablishmentsViewModel?
    var categories: [EstablishmentCategoryResponse] = []
    var establishments: [EstablishmentResponse] = []
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupViews() {
        self.setupCollectionView()
        self.setupTableView()
    }
    
    private func loadCategories() {
        self.showLoading()
       
        self.viewModel?.getEstablishmentCategory(callback: { success, response in
            if success {
                self.categories = response ?? []
                self.categoriesColection?.reloadData()
                self.categoriesColection?.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
                self.loadEstablishments()
            } else {
                self.dismissLoading()
                self.showFullScreenError(delegate: self)
            }
        })
    }
    
    private func loadEstablishments() {
        self.viewModel?.getNearEstablishments(pageNumber: 1, callback: { success, response in
            if success {
                self.establishments = response ?? []
                self.establishmentsTV?.reloadData()
            } else {
                self.showFullScreenError(delegate: self)
            }
            self.dismissLoading()
        })
    }
    
    private func setupTableView() {
        self.establishmentsTV?.delegate = self
        self.establishmentsTV?.dataSource = self
        self.establishmentsTV?.register(UINib(nibName: EstablishmentCell.cellID, bundle: nil),
                                        forCellReuseIdentifier: EstablishmentCell.cellID)
    }
    
    private func setupCollectionView() {
        self.categoriesColection?.delegate = self
        self.categoriesColection?.dataSource = self
        self.categoriesColection?.register(UINib(nibName: CategoriesCollCell.cellID, bundle: nil),
                                           forCellWithReuseIdentifier: CategoriesCollCell.cellID)
        
    }
    
    //MARK: actions
    
    @IBAction func showFilter(_ sender: Any) {
        let vc = EstablishmentFilterViewController(filter: self.viewModel?.filter,
                                                   delegate: self)
        self.present(vc, animated: true, completion: nil)
    }
}

extension EstablishmentsViewController: UITableViewDelegate, UITableViewDataSource {
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

extension EstablishmentsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollCell.cellID, for: indexPath) as? CategoriesCollCell {
            let categorie = self.categories[indexPath.row]
            cell.setupCell(name: categorie.name)
            return cell
        
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categorie = self.categories[indexPath.row]
        let height: CGFloat = 40
        let width: CGFloat = categorie.name.widthOfString(usingFont: UIFont.systemFont(ofSize: 16)) + 20
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showLoading()
        let categorie = self.categories[indexPath.row]
        if categorie.id == -1 {
            self.viewModel?.selectedCategoryId = nil
            
        } else {
            self.viewModel?.selectedCategoryId = categorie.id
        }
        
        self.loadEstablishments()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}


extension EstablishmentsViewController: EstablishmentFilterProtocol {
    func applyFilter(filter: EstablishmentFilter) {
//        self.showLoading()
        self.viewModel?.filter = filter
        self.loadEstablishments()
    }
}
