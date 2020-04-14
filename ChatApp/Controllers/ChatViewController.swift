//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Cristian Sedano Arenas on 14/04/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        
        do {
            
        try Auth.auth().signOut()
            
        } catch{
            print("Log Out Error")
        }
        
        guard navigationController?.popToRootViewController(animated: true) != nil else {
            print("No hay ViewControllers")
            return
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
    }
}
