//
//  addLoctionViewcontroller.swift
//  On_the_Map
//
//  Created by Hajar F on 11/9/19.
//  Copyright © 2019 Hajar F. All rights reserved.
//

import UIKit
import CoreLocation

// Mark: Add Location View Controller
class AddLocationViewController: UIViewController , UITextFieldDelegate {
    
    // Mark: IBOutlet 
    @IBOutlet weak var loctionTextField: UITextField!
    @IBOutlet weak var mediaTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.cancelButton(_:)))
        
        loctionTextField.delegate = self
        mediaTextField.delegate = self
    }
    
    // // Mark: pass student location to other screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ConfirmLocationViewController {
            destination.location = (sender as! StudentLocation)
        }
    }
    
    
    // Mark: Find Location on the Map
    @IBAction func findLocation(_ sender: Any) {
        guard let location = loctionTextField.text,
            let mediaLink = mediaTextField.text,
            location != "", mediaLink != "" else {
                self.showAlert(title: "Missing information", message: "Please fill both fields and try again")
                return
        }
        let studentLocation = StudentLocation (mapString: location, mediaURL:mediaLink)
        geocodeCoordinates(studentLocation)
    }
    
    private func geocodeCoordinates(_ studentLocation: StudentLocation) {
        
        let ai = UIActivityIndicatorView()
        self.view.addSubview(ai)
        self.view.bringSubviewToFront(ai)
        ai.center = self.view.center
        ai.hidesWhenStopped = true
        ai.startAnimating()
        
        CLGeocoder().geocodeAddressString(studentLocation.mapString ?? "") { (placeMarks, err) in
            ai.stopAnimating()
            if let firstPlaceMark = placeMarks?.first {
                let newStudentLocation = StudentLocation(createdAt: nil, firstName: API.userInfo.firstName!, lastName: API.userInfo.lastName!, latitude: firstPlaceMark.location?.coordinate.latitude, longitude: firstPlaceMark.location?.coordinate.longitude, mapString: studentLocation.mapString, mediaURL: studentLocation.mediaURL, objectId: nil, uniqueKey: API.userInfo.key, updatedAt: nil)
                
                self.performSegue(withIdentifier: "mapSegue", sender: newStudentLocation)
            } else {
                self.showAlert(title: "Error", message: "Could not found location")
            }
        }
        
    }
    
    
    // Mark: cancel to add
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
