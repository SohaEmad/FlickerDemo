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
    @Published var authoried: Bool = false
    var status: CLAuthorizationStatus? = nil

    
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
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
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

extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
