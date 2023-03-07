//
//  MenuViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 24/02/23.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var categoriesColection: UICollectionView?
    @IBOutlet weak var productsTV: UITableView?
    
    let viewModel: MenuViewModel?
    let categories: [String] = ["Todos", "Sushi", "Yaksoba", "Combos", "Bebidas"]
    
    init(viewModel: MenuViewModel) {
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
        self.title = "Cardápio"
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupViews() {
        self.setupTableView()
        self.setupCollectionView()
    }
    
    private func setupTableView() {
        self.productsTV?.delegate = self
        self.productsTV?.dataSource = self
        self.productsTV?.reloadData()
        self.productsTV?.register(UINib(nibName: MenuCell.cellID, bundle: nil),
                                        forCellReuseIdentifier: MenuCell.cellID)
    }
    
    private func setupCollectionView() {
        self.categoriesColection?.delegate = self
        self.categoriesColection?.dataSource = self
        self.categoriesColection?.register(UINib(nibName: CategoriesCollCell.cellID, bundle: nil),
                                           forCellWithReuseIdentifier: CategoriesCollCell.cellID)
        self.categoriesColection?.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
    }
    
    //MARK: actions

    @IBAction func showOrder(_ sender: Any) {
        self.viewModel?.showOrders()
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.cellID,
                                                    for: indexPath) as? MenuCell {
            return cell
        
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = MenuItemViewModel()
        let vc = MenuItemViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let text = self.categories[section]
        
        let width = UIScreen.main.bounds.width
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        view.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 24, y: 0, width: 100, height: 20))
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.textGray
        view.addSubview(label)

        return view
    }
}
