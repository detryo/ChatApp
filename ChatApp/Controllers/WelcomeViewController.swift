//
//  ViewController.swift
//  ChatApp
//
//  Created by Cristian Sedano Arenas on 09/04/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "goToChat", sender: self)
        }
    }
}
