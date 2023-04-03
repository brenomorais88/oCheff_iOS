//
//  EstablishmentsViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 19/02/23.
//

import Foundation
import Alamofire
import CoreLocation

class EstablishmentsViewModel: ViewModel {
    let delegate: HomeCoordinatorProtocol
    let service: EstablishmentService
    
    var filter: EstablishmentFilter
    var selectedCategoryId: Int? = nil
    
    init(delegate: HomeCoordinatorProtocol,
         service: EstablishmentService) {
        self.delegate = delegate
        self.service = service
        self.filter = EstablishmentFilter(distance: 2,
                                          averagePrice: nil)
        super.init()
    }
    
    func showEstablishment(id: Int) {
        self.delegate.showEstablishment(id: id)
    }
    
    func getEstablishmentCategory(callback: @escaping (Bool, [EstablishmentCategoryResponse]?) -> ()) {
        self.service.getEstablishmentCategory { success, categories in
            if success {
                if var cat = categories {
                    
                    let allCategories = EstablishmentCategoryResponse(id: -1, name: "Tudo")
                    
                    cat.append(allCategories)
                    let sorted = cat.sorted { $0.id < $1.id }
                    
                    callback(true, sorted)
                    
                } else {
                    callback(false, nil)
                }
                
            } else {
                callback(false, nil)
            }
        }
    }
    
    func getNearEstablishments(pageNumber: Int, callback: @escaping (Bool, [EstablishmentResponse]?) -> ()) {
        let location = getUsetLocation()
        let lat = location?.coordinate.latitude
        let lng = location?.coordinate.longitude
        
//        let lat = -23.6130207
//        let lng = -46.609477
        
        let params = EstablishmentRequest(userLatitude: lat,
                                          userLongitute: lng,
                                          distance: filter.distance,
                                          averagePrice: filter.averagePrice,
                                          category: selectedCategoryId,
                                          pageNumber: pageNumber,
                                          pageSize: 10)
        print(params)
        self.service.getNearEstablishments(params: params, callback: callback)
    }
    
    private func getUsetLocation() -> CLLocation? {
        
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        switch locManager.authorizationStatus {
        case .restricted, .denied:
            return nil
            
        default:
            return locManager.location
        }
    }
}

    
