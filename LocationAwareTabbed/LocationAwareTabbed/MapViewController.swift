//
//  MapViewController.swift
//  LocationAwareTabbed
//
//  Created by Nicholas Burcin on 10/31/18.
//  Copyright © 2018 Burcin Software. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    override func viewDidAppear(_ animated: Bool) {
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: span)
        self.map.setRegion(region, animated: true)
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if let error = error {
                print(error)
            } else {
                if let placemark = placemarks?[0] {
                    var subThoroughfare = ""
                    if placemark.subThoroughfare != nil {
                        subThoroughfare = placemark.subThoroughfare!
                    }
                    var thoroughfare = ""
                    if placemark.thoroughfare != nil {
                        thoroughfare = placemark.thoroughfare!
                    }
                    var subLocality = ""
                    if placemark.subLocality != nil {
                        subLocality = placemark.subLocality!
                    }
                    var subAdministrativeArea = ""
                    if placemark.subAdministrativeArea != nil {
                        subAdministrativeArea = placemark.subAdministrativeArea!
                    }
                    var postalCode = ""
                    if placemark.postalCode != nil {
                        postalCode = placemark.postalCode!
                    }
                    var country = ""
                    if placemark.country != nil {
                        country = placemark.country!
                    }
                    print(subThoroughfare + thoroughfare + "\n" + subLocality + "\n" + subAdministrativeArea + "\n" + postalCode + "\n" + country)
                    
                }
            }
        }
    }

}

