//
//  EstablishmentFilterViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 19/02/23.
//

import UIKit

protocol EstablishmentFilterProtocol {
    func applyFilter(filter: EstablishmentFilter)
}

class EstablishmentFilterViewController: UIViewController {
    @IBOutlet weak var filterContent: UIView?
    
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var selectedDistanceText: UILabel!
    
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var selectedPriceText: UILabel!
    
    
    let delegate: EstablishmentFilterProtocol
    var filter: EstablishmentFilter?
    
    init(filter: EstablishmentFilter?, delegate: EstablishmentFilterProtocol) {
        self.delegate = delegate
        self.filter = filter
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
        self.loadFilter()
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
    
    private func loadFilter() {
        guard let filter = filter else {
            return
        }
        
        self.distanceSlider.value = Float(filter.distance ?? 3)
        self.priceSlider.value = Float(filter.averagePrice ?? 501)
        setupDistanceFilter()
        setupValueFilter()
    }
    
    //MARK: actions
    
    @IBAction func changeDistance(_ sender: Any) {
        setupDistanceFilter()
    }
    
    @IBAction func changePrice(_ sender: Any) {
        setupValueFilter()
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        let distance: Int? = getSelectedDistance()
//        let averagePrice: Double? = getSelectedAveragePrice()
        let averagePrice: Double? = nil
        
        filter = EstablishmentFilter(distance: distance,
                                     averagePrice: averagePrice)
        
        if let filter = self.filter {
            self.delegate.applyFilter(filter: filter)
        }
    
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupDistanceFilter() {
        let selectedDistance = Int(distanceSlider.value)
        
        if selectedDistance > 10 {
            self.selectedDistanceText.text = "+10KM"
        } else {
            self.selectedDistanceText.text = "\(selectedDistance)KM"
        }
    }
    
    private func setupValueFilter() {
        let selectedPrice = Int(priceSlider.value)
        
        if selectedPrice > 500 {
            self.selectedPriceText.text = "+R$500"
        } else {
            self.selectedPriceText.text = "R$\(selectedPrice)"
        }
    }
    
    private func getSelectedDistance() -> Int? {
        let selectedDistance = Int(distanceSlider.value)
        
        if selectedDistance > 10 {
            return nil
        } else {
            return selectedDistance
        }
    }
    
    private func getSelectedAveragePrice() -> Double? {
        let selectedPrice = Int(priceSlider.value)
        
        if selectedPrice > 500 {
            return nil
        } else {
            return Double(priceSlider.value)
        }
    }
}
