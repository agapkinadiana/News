//
//  LocationService.swift
//  News
//
//  Created by Diana Agapkina on 10/30/20.
//

import Foundation
import CoreLocation

//protocol LocationServiceDelegate: class {
//    func didUpdateForBelarus(_ locationManager: LocationService)
//    func didUpdateForOtherContries(_ locationManager: LocationService)
//}
//
//class LocationService {
//
//    var delegate: LocationServiceDelegate?
//
//    func getCurrentCounry(with location: CLLocation) {
//        let geocoder: CLGeocoder = CLGeocoder()
//
//        geocoder.reverseGeocodeLocation(location) { placemarks, error in
//            guard let place = placemarks?[0] else { fatalError("No Placemarks Provided \(String(describing: error?.localizedDescription))")}
//
//            guard let country = place.country else { return }
//
//            if country == "Belarus" {
//                self.delegate?.didUpdateForBelarus(self)
//            } else {
//                self.delegate?.didUpdateForOtherContries(self)
//            }
//        }
//    }
//}
