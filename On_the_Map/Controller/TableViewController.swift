//
//  TableViewController.swift
//  On_the_Map
//
//  Created by Hajar F on 11/9/19.
//  Copyright © 2019 Hajar F. All rights reserved.
//

import Foundation
import UIKit

// Mark: -- Table View Controller
class TableViewController:  ContainerViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocations()
    }
    
    //MARK: refresh Button
    override func refresh(_ sender: Any) {
        super.refresh(sender)
        getLocations()
    }
    
    private func getLocations() {
        API.Parser.getStudentLocations { studentLocations in
            if studentLocations != nil {
                LocationsData.studentLocations = studentLocations!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.showAlert(title: "Error", message: "Could not load data")
            }
        }
    }
    
}
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationsData.studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationCell") as! StudentLocationCell
        let studentLocation = LocationsData.studentLocations[indexPath.row]
        cell.configureStudentLocationCell(studentLocation: studentLocation)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = LocationsData.studentLocations[indexPath.row]
        if let url = URL(string: selectedCell.mediaURL ?? "") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, completionHandler: nil)
            }else{
                
                let alertView = UIAlertController(title: "", message: "Cannot Open URL", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alertView, animated: true){
                    self.view.alpha = 1.0
                }
                
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
