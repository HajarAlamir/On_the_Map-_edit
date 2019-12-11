//
//  ContainerViewController.swift
//  On_the_Map
//
//  Created by Hajar F on 11/19/19.
//  Copyright © 2019 Hajar F. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var locationsData: LocationsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addLocation(_:)))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refresh(_:)))
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.logout(_:)))
        
        navigationItem.rightBarButtonItems = [plusButton, refreshButton]
        navigationItem.leftBarButtonItem = logoutButton
    }
    
    
    @objc private func addLocation(_ sender: Any) {
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddLocationViewController") as! UINavigationController
        present(navController, animated: true, completion: nil)
    }
    // Mark: refresh Button
    @objc func refresh(_ sender: Any) {
        
    }
    
    @objc private func logout(_ sender: Any) {
        
        API.logoutt { error in
            if error != nil {
                self.showAlert(title: "Error", message: "Logout Error")
            } else {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    private func loadStudentLocations() {
        API.Parser.getStudentLocations { (data) in
            guard let data = data else {
                self.showAlert(title: "Error", message: "No internet connection found")
                return
            }
            guard data.count > 0 else {
                self.showAlert(title: "Error", message: "No pins found")
                return
            }
            LocationsData.studentLocations = data
        }
    }
    
    
    
}
