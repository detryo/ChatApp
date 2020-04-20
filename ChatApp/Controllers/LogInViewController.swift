//
//  LogInViewController.swift
//  ChatApp
//
//  Created by Cristian Sedano Arenas on 14/04/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        
        guard let pass = passwordTextField.text else {
            return
        }
        
        guard let email = emailTextField.text else {
            return
        }
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("Login con exito")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "fromLogInToChat", sender: self)
            }
        }
    }
}
