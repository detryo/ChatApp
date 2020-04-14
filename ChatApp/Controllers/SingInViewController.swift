//
//  SingInViewController.swift
//  ChatApp
//
//  Created by Cristian Sedano Arenas on 14/04/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import Firebase

class SingInViewController: UIViewController {
    
    @IBOutlet weak var emailTextFiel: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    @IBOutlet weak var conditionsSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
   
    @IBAction func registerPressed(_ sender: UIButton) {
        
        guard conditionsSwitch.isOn else {
            let controller = UIAlertController(title: "", message: "No has aceptado las condiciones", preferredStyle: .alert)
            let notAccept = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            controller.addAction(notAccept)
            present(controller, animated: true, completion: nil)
            return
        }
        
        guard passwordTextField.text == password2TextField.text else {
            let controller = UIAlertController(title: "", message: "La contraseña no coincide", preferredStyle: .alert)
            let passError = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            controller.addAction(passError)
            present(controller, animated: true, completion: nil)
            return
        }
        
        guard let email = emailTextFiel.text, let pass = passwordTextField.text else {
            let controller = UIAlertController(title: "", message: "Escribe el correo", preferredStyle: .alert)
            let emailError = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            controller.addAction(emailError)
            present(controller, animated: true, completion: nil)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: pass ) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("el usuario se ha registrado")
                self.performSegue(withIdentifier: "fromRegistreToChat", sender: self)
            }
        }
    }
}
