//
//  Helper.swift
//  On_the_Map
//
//  Created by Hajar F on 11/11/19.
//  Copyright © 2019 Hajar F. All rights reserved.
//

import Foundation
import UIKit



extension UIViewController {
    
    // Mark: -- Alert Method
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}

extension UIViewController {
    func displayAlert(title:String, message:String?) {
        
        if let message = message {
            let alert = UIAlertController(title: title, message: "\(message)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    
}




