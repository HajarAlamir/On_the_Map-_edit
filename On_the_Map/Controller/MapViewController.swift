//
//  MapViewController.swift
//  On_the_Map
//
//  Created by Hajar F on 11/6/19.
//  Copyright © 2019 Hajar F. All rights reserved.
//

import UIKit
import MapKit


// Mark: -- Map View Controller
class MapViewController: ContainerViewController, MKMapViewDelegate {
    
    // Mark: IBOutlet mapView
    @IBOutlet weak var mapView: MKMapView!
    
    
    override var locationsData: LocationsData? {
        didSet {
            updatePins()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.delegate = self
        getLocations()
    }
    
    override func refresh(_ sender: Any) {
        super.refresh(sender)
        getLocations()
    }
    
    private func getLocations() {
        API.Parser.getStudentLocations { studentLocations in
            if studentLocations != nil {
                LocationsData.studentLocations = studentLocations!
                DispatchQueue.main.async {
                    self.updatePins()
                }
            } else {
                self.showAlert(title: "Error", message: "Could not load data")
            }
        }
    }
    
    // Mark: update Pins Function
    func updatePins() {
        let locations = LocationsData.studentLocations
        
        var annotations = [MKPointAnnotation]()
        
        for location in locations {
            
            guard let latitude = location.latitude, let longitude = location.longitude else { continue }
            let lat = CLLocationDegrees(latitude)
            let long = CLLocationDegrees(longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let first = location.firstName
            let last = location.lastName
            let mediaURL = location.mediaURL
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first ?? "") \(last ?? "")"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        
        //  add the annotations to the map.
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
    }
    
    
    // Mark: Map view Function
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.pinTintColor = .red
                pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
}
