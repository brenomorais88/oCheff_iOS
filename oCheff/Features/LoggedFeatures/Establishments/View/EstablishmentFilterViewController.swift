//
//  EstablishmentFilterViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 19/02/23.
//

import UIKit

protocol EstablishmentFilterProtocol {
    func applyFilter()
}
class EstablishmentFilterViewController: UIViewController {
    @IBOutlet weak var filterContent: UIView?
    
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var selectedDistanceText: UILabel!
    
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var selectedPriceText: UILabel!
    
    
    let delegate: EstablishmentFilterProtocol
    
    init(delegate: EstablishmentFilterProtocol) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
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
    }
    
    private func setupViews() {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = UIScreen.main.bounds.height - 50
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        self.filterContent?.roundTop(bounds: bounds)
    }
    
    //MARK: actions
    
    @IBAction func changeDistance(_ sender: Any) {
        let selectedDistance = Int(distanceSlider.value)
        
        if selectedDistance > 10 {
            self.selectedDistanceText.text = "+10KM"
        } else {
            self.selectedDistanceText.text = "\(selectedDistance)KM"
        }
    }
    
    @IBAction func changePrice(_ sender: Any) {
        let selectedPrice = Int(priceSlider.value)
        
        if selectedPrice > 500 {
            self.selectedPriceText.text = "+R$500"
        } else {
            self.selectedPriceText.text = "R$\(selectedPrice)"
        }
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        self.delegate.applyFilter()
        self.dismiss(animated: true, completion: nil)
    }
}
