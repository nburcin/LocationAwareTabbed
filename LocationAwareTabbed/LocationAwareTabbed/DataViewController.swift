//
//  DataViewController.swift
//  LocationAwareTabbed
//
//  Created by Nicholas Burcin on 10/31/18.
//  Copyright © 2018 Burcin Software. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DataViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationManager = CLLocationManager()
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        latitudeLabel.layer.cornerRadius = 10.0
        latitudeLabel.clipsToBounds = true
        longitudeLabel.layer.cornerRadius = 10.0
        longitudeLabel.clipsToBounds = true
        courseLabel.layer.cornerRadius = 10.0
        courseLabel.clipsToBounds = true
        speedLabel.layer.cornerRadius = 10.0
        speedLabel.clipsToBounds = true
        altitudeLabel.layer.cornerRadius = 10.0
        altitudeLabel.clipsToBounds = true
        addressLabel.layer.cornerRadius = 10.0
        addressLabel.clipsToBounds = true
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let truncLatitude = String(format: "%.4f", latitude)
        self.latitudeLabel.text = "Latitude: " + truncLatitude + " ˚"
        let longitude = userLocation.coordinate.longitude
        let truncLongitude = String(format: "%.4f", longitude)
        self.longitudeLabel.text = "Longitude: " + truncLongitude + " ˚"
        let course = userLocation.course
        let truncCourse = String(format: "%.4f", course)
        self.courseLabel.text = "Course: " + truncCourse
        let speed = userLocation.speed
        self.speedLabel.text = "Speed: " + String(format: "%.4f", speed) + " m/s"
//        let truncSpeed = String(format: "&.4f", speed)
//        if speed == 0 || speed == 0.0 {
//            self.speedLabel.text = "Speed: " + truncSpeed + " m/s"
//        } else {
//            self.speedLabel.text = "Speed: " + String(speed) + " m/s"
//        }
        
        let altitude = userLocation.altitude
        self.altitudeLabel.text = "Altitude: " + String(format: "%.4f", altitude) + " m"
//        let latDelta: CLLocationDegrees = 0.05
//        let lonDelta: CLLocationDegrees = 0.05
//        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
//        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        let region = MKCoordinateRegion(center: center, span: span)
//        self.map.setRegion(region, animated: true)
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
                    var subAdministrativeArea = ""
                    if placemark.subAdministrativeArea != nil {
                        subAdministrativeArea = placemark.subAdministrativeArea!
                    }
                    var administrativeArea = ""
                    if placemark.administrativeArea != nil {
                        administrativeArea = placemark.administrativeArea!
                    }
                    var postalCode = ""
                    if placemark.postalCode != nil {
                        postalCode = placemark.postalCode!
                    }
                    var country = ""
                    if placemark.country != nil {
                        country = placemark.country!
                    }
                    print(subThoroughfare + " " + thoroughfare + "\n" + subAdministrativeArea + ", " + administrativeArea +  " " + postalCode + "\n" + country)
                    self.addressLabel.text = "\(subThoroughfare + " " + thoroughfare + "\n" + subAdministrativeArea + ", " + administrativeArea +  " " + postalCode + "\n" + country)"
                
                    
                }
            }
        }
    }
}

