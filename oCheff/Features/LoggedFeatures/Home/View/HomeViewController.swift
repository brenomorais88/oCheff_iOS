//
//  HomeViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 18/02/23.
//

import UIKit

class HomeViewController: ViewController {
    @IBOutlet weak var openTableView: UIView?
    @IBOutlet weak var showEstablishments: UIView?
    @IBOutlet weak var showFavorites: UIView?
    @IBOutlet weak var adsContentView: UIView?
    
    private var adsPageController: CustomPageViewController?
    private var currentIndex: Int = 0
    private var ads: [AdsPageContentViewController] = []
    private var adTimer: Timer?
    
    let viewModel: HomeViewModel?
    
    init(viewModel: HomeViewModel) {
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
        self.loadAds()
        self.setupPageController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        startAdTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        adTimer?.invalidate()
    }
    
    private func setupViews() {
        self.openTableView?.addBorder()
        self.showEstablishments?.addBorder()
        self.showFavorites?.addBorder()
    }
    
    private func loadAds() {
        guard let img1 = UIImage(named: "sample_ad_1") else { return }
        guard let img2 = UIImage(named: "sample_ad_2") else { return }
        guard let img3 = UIImage(named: "sample_ad_3") else { return }
        guard let img4 = UIImage(named: "sample_ad_4") else { return }
        
        ads.append(AdsPageContentViewController(image: img1, pageIndex: 0))
        ads.append(AdsPageContentViewController(image: img2, pageIndex: 1))
        ads.append(AdsPageContentViewController(image: img3, pageIndex: 2))
        ads.append(AdsPageContentViewController(image: img4, pageIndex: 3))
        
    }
    
    private func setupPageController() {
        self.adsPageController = CustomPageViewController(transitionStyle: .scroll,
                                                          navigationOrientation: .horizontal,
                                                          options: nil)
        guard let view = self.adsPageController?.view else { return }
        
        self.adsPageController?.dataSource = self
        self.adsPageController?.delegate = self
        
        view.frame = CGRect(x: 0,
                            y: 0,
                            width: self.adsContentView?.frame.width ?? 0.0,
                            height: self.adsContentView?.frame.height ?? 0.0)
        
        self.adsContentView?.addSubview(view)
        
        let firstVC: UIViewController = self.ads.first ?? UIViewController()
        self.adsPageController?.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        self.adsPageController?.didMove(toParent: self)
    }
    
    private func startAdTimer() {
        adTimer = Timer.scheduledTimer(timeInterval: 5,
                                       target: self,
                                       selector: #selector(changeAd),
                                       userInfo: nil,
                                       repeats: true)
    }
    
    @IBAction func openNewTable(_ sender: Any) {
        self.viewModel?.openNewTable()
    }
    
    @IBAction func searchEstablishment(_ sender: Any) {
        self.viewModel?.showEstablishments()
    }
    
    @IBAction func showFavorites(_ sender: Any) {
        self.viewModel?.showFavorites()
    }
}

extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    @objc
    func changeAd() {
        let index = currentIndex + 1

        if index < self.ads.count {
            let vc = self.ads[index]
            self.adsPageController?.setViewControllers([vc],
                                                       direction: .forward,
                                                       animated: true,
                                                       completion: nil)
            currentIndex = index
        
        } else {
            currentIndex = 0
            let vc = self.ads.first ?? UIViewController()
            self.adsPageController?.setViewControllers([vc],
                                                       direction: .forward,
                                                       animated: true,
                                                       completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
        guard let currentVC = viewController as? AdsPageContentViewController else {
            return nil
        }
            
        currentIndex = currentVC.index
            
        if currentIndex == 0 {
            return nil
        }
            
        currentIndex -= 1
            
        return self.ads[currentIndex]
    }
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let currentVC = viewController as? AdsPageContentViewController else {
            return nil
        }

        currentIndex = currentVC.index

        if currentIndex >= self.ads.count - 1 {
            return nil
        }

        currentIndex += 1

        return self.ads[currentIndex]
    }
}
