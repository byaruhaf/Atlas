//
//  FavoritesMapViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 06/02/2023.
//

import UIKit
import MapKit

class FavoritesMapViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBOutlet var mapView: MKMapView!
    
    let locations = [
        Location(name: "New York", locality: "NY", latitude: 40.7129822, longitude: -74.007205),
        Location(name: "Khartoum", locality: "Khartoum", latitude: 15.5885494, longitude: 32.535473),
        Location(name: "Durban", locality: "KZN", latitude: -29.8565296, longitude: 31.0193343),
        Location(name: "Cairo", locality: "Cairo", latitude: 30.0214489, longitude: 31.4904086)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForTheme()
        mapView.delegate = self
        annotationsOnMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateColor()
    }
    
    func annotationsOnMap() {
        var userPins: [MapPin] = []
        for location in locations {
            
            userPins.append(MapPin(title: location.name, locationName: location.locality, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
        }
        let coordinateRegion = MKCoordinateRegion(center: userPins[0].coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotations(userPins)
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Anno")
    }
        
    deinit {
        // Register for Observer
        registerForTheme()
    }
}

// swiftlint:disable notification_center_detachment
// swiftlint:disable explicit_init
extension FavoritesMapViewController: ThemeableColor {
    func registerForTheme() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(colorChanged), name: NSNotification.Name.init("ColorChanged"),
            object: nil)
    }
    
    func unregisterForTheme() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func colorChanged() {
        animateColor()
    }
    
    func animateColor() {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
        }
    }
}

extension FavoritesMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            
            let pointSize = UIImage.SymbolConfiguration(pointSize: 50)
            let caption = UIImage.SymbolConfiguration(textStyle: .largeTitle)
            let thin = UIImage.SymbolConfiguration(weight: .bold)
            let combined = caption.applying(pointSize).applying(thin)
            
            annotationView!.image = UIImage(systemName: "cloud", withConfiguration: combined)!
            annotationView!.clusteringIdentifier = "PinCluster"
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}

class MapPin: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
    }
}
