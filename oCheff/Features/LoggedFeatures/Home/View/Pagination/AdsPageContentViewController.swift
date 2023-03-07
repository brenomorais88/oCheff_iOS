//
//  AdsPageContentViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 18/02/23.
//

import UIKit

class AdsPageContentViewController: UIViewController {
    @IBOutlet weak var adImage: UIImageView!
    
    let image: UIImage
    let index: Int
    
    init(image: UIImage, pageIndex: Int) {
        self.image = image
        self.index = pageIndex
        super.init(nibName: nil, bundle: nil)
    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        self.image = UIImage()
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupViews() {
        self.adImage.image = image
    }
    
}
