//
//  ConfirmLocationViewController.swift
//  On_the_Map
//
//  Created by Hajar F on 11/11/19.
//  Copyright © 2019 Hajar F. All rights reserved.
//

import UIKit
import MapKit

// Mark: - Confirm Location Map View Controller
class ConfirmLocationViewController: UIViewController {
    
    // Mark: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    var location: StudentLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }
    
    // Mark: setupMap Function 
    private func setupMap () {
        guard let location = location else { return }
        var annotations = [MKPointAnnotation]()
        let lat = CLLocationDegrees(location.latitude!)
        let lon = CLLocationDegrees(location.longitude!)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        var fullName : String { return "\(location.firstName!) \(location.lastName!)"}
        annotation.title = fullName
        annotation.subtitle = location.mediaURL
        annotations.append (annotation)
        // Setting current mapView's region to be centered at the pin's coordinate
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        //new add 
        mapView.addAnnotation(annotation)
        mapView.delegate = self
        
    }
    
    // Mark: Finish Buttom
    @IBAction func finish(_ sender: Any) {
        API.Parser.postLocation(self.location!) { err  in
            guard err == nil else {
                self.showAlert(title: "Error", message: err!)
                return
            }
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // Mark: cancel Buttom
    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

// Mark: - Confirm Location Map View Controller
extension ConfirmLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
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
            if let toOpen = view.annotation?.subtitle!,
                let url = URL(string: toOpen), app.canOpenURL(url) {
                app.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
}


