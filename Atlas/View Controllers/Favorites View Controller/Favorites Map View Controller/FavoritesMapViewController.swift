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
    
    var viewModel: FavoritesMapViewModel?

    private static let identifier = "FavoritesMapViewController"
    
    static func newInstance(viewModel: FavoritesMapViewModel) -> FavoritesMapViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as! FavoritesMapViewController
        controller.viewModel = viewModel
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForTheme()
        mapView.delegate = self
        updateLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLocations()
        animateColor()
    }
    
    func annotationsOnMap(with viewModel: FavoritesMapViewModel) {
        mapView.removeAnnotations(mapView.annotations.filter { $0 !== mapView.userLocation })
        let userPins: [MapPin] = viewModel.userPins
        if userPins.isEmpty {
            return
        }
        mapView.showsUserLocation = true
        let coordinateRegion = MKCoordinateRegion(center: userPins.last!.coordinate, latitudinalMeters: 1800000, longitudinalMeters: 1800000)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotations(userPins)
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Anno")
    }
    
    func updateLocations() {
        viewModel?.locations = []
        viewModel?.locations = UserDefaults.locations
        guard let viewModel else { return }
        annotationsOnMap(with: viewModel)
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
