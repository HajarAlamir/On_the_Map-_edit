//
//  LoginViewController.swift
//  On_the_Map
//
//  Created by Hajar F on 10/31/19.
//  Copyright © 2019 Hajar F. All rights reserved.
//

import UIKit

// Mark: Login View Controller
class LoginViewController: UIViewController {
    
    // Mark: - OutLets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet  weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // Mark:setupUI
    private func setupUI() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // Mark:loginButton
    @IBAction func loginButton(_ sender: Any) {
        
        API.postSession(username: usernameTextField.text!, password: passwordTextField.text!) { (errString) in
            guard errString == nil else {
                self.showAlert(title: "Error", message: errString!)
                return
            }
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "Login", sender: nil)
            }
        }
    }
    
    
    // Mark: signUp Button
    
    @IBAction func signUpButton(_ sender: Any) {
        /* Open Udacity Sign Up URL */
        if let url = URL(string: "https://www.udacity.com/account/auth#!/signup"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

