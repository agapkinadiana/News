//
//  LocationViewController.swift
//  News
//
//  Created by Diana Agapkina on 10/30/20.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
    
//    let locationManager = CLLocationManager()
//    var currentLocation: CLLocation?
//    let locationService = LocationService()

    override func viewDidLoad() {
        super.viewDidLoad()
//        locationService.delegate = self
//        setupLocation()
        
        guard let region = Locale.current.regionCode else {
            print("Region not choosen!")
            return
        }
        if region == "BY" {
            self.performSegue(withIdentifier: segueIdentifier, sender: self)
        } else {
            alertAppNotAvailable()
        }
    }
    
    private func alertAppNotAvailable() {
        let alert = UIAlertController(title: "Error❗️",
                                      message: "App Not Available in Your Country",
                                      preferredStyle: .alert)
        present(alert, animated: true)
    }
    
}

//extension LocationViewController: LocationServiceDelegate {
//    func didUpdateForBelarus(_ locationManager: LocationService) {
//        OperationQueue.main.addOperation {
//            self.performSegue(withIdentifier: "toNewsVC", sender: self)
//        }
//        
//        //self.performSegue(withIdentifier: "toNewsVC", sender: self)
//    }
//    
//    func didUpdateForOtherContries(_ locationManager: LocationService) {
//        alertAppNotAvailable()
//    }
//}
//
//extension LocationViewController: CLLocationManagerDelegate {
//    
//    func setupLocation() {
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        if !locations.isEmpty, currentLocation == nil {
//            currentLocation = locations.first
//            locationManager.stopUpdatingLocation()
//            requestForLocationCountry()
//        }
//    }
//    
//    
//    func requestForLocationCountry() {
//        
//        if let location = currentLocation {
//            locationService.getCurrentCounry(with: location)
//        }
//        
//        locationManager.stopUpdatingLocation()
//    }
//    
//}
