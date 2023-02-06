//
//  FavoritesMapViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 06/02/2023.
//

import UIKit
import MapKit

class FavoritesMapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForTheme()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateColor()
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

// class ViewController: UIViewController, MKMapViewDelegate {
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        .darkContent
//    }
//
//    @IBOutlet weak var mapView: MKMapView!
//
//    let locations = [
//
//        Location(name: "Dr. James Golf Course", latitude: 40.003252, longitude: -86.0655897),
//        Location(name: "Avon Town Hall", latitude: 39.7636057, longitude: -86.4080829),
//        Location(name: "Brookside Park", latitude: 39.7897185, longitude: -86.1070623)
//    ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        mapView.delegate = self
//        annotationsOnMap()
//
//    }
//
//    func annotationsOnMap() {
//
//        for location in locations {
//
//            let annotations = MKPointAnnotation()
//
//            annotations.title = location.name
//            annotations.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
//
//            mapView.addAnnotation(annotations)
//
//            let locationCoordinate2d = annotations.coordinate
//            let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//            let region = MKCoordinateRegion(center: locationCoordinate2d, span: span)
//
//            mapView.setRegion(region, animated: true)
//        }
//    }
// }

// struct Location {
//
//    let title: String
//    let latitude: Double
//    let longitude: Double
// }
