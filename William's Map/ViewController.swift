//
//  ViewController.swift
//  William's Map
//
//  Created by Student on 9/21/16.
//  Copyright © 2016 Uno. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var userLocation = CLLocation()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.checkLocationAuthorizationStatus()
        self.setupLocation()
        self.addGesture()
    }
    
    func checkLocationAuthorizationStatus(){
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
    
    func setupLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func addGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.addAnnotationToMap(_:)))
        longPress.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longPress)
    }
    
    func addAnnotationToMap(_ gestureRecognizer: UIGestureRecognizer){
        // Obtem o ponto onde o usuario fez long press
        let touchPoint = gestureRecognizer.location(in: mapView)
        // criando uma coordenada para o ponto
        let newCoordinate: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let newAnnotation: MKPointAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = newCoordinate
        newAnnotation.title = "Novo Local"
        newAnnotation.subtitle = "Informações"
        mapView.addAnnotation(newAnnotation)
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            userLocation = locations.last!
            print("Localizacao atual:  \(userLocation.coordinate)")
        }
    }
    
    
    
}

