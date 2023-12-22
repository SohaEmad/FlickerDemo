//
//  LocationManager.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 22/12/2023.
//

import CoreLocation
import Combine

class LocationProvider: NSObject, ObservableObject {
    var locationManager = CLLocationManager()
    
    @Published var curentLocaiton: CLLocation? = nil
    var status: CLAuthorizationStatus? = nil
    @Published var authoried: Bool = false
    
    override init() {
        super.init()
        locationManager.delegate = self
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.requestAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringSignificantLocationChanges()
    }
    private func requestAuthorization() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways ||
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            return
        }
        self.locationManager.requestAlwaysAuthorization()
    }
}
extension LocationProvider : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.curentLocaiton = locations.last
    }
    
    func setAuthorithed() {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse, .restricted:
            self.authoried = true
        default:
            self.authoried = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
        self.setAuthorithed()
    }
}
