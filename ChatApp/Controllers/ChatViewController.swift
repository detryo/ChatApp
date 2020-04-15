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
    @IBOutlet weak var textBoxHeight: NSLayoutConstraint!
    
    let messageArray : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.messagesTableView.dataSource = self
        self.messagesTableView.delegate = self
        self.messagesTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        self.messagesTableView.rowHeight = UITableView.automaticDimension
        self.messagesTableView.estimatedRowHeight = 120
        
        self.messageTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideMessageZone))
        self.messagesTableView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: Firebase Method
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
        // Esta linea es opcional, si queremos que el usuario
        // escriba mas de una linea la quitamos
        self.messageTextField.endEditing(true)
        
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messageDB = Database.database().reference().child("Messages")
        let messageDic = ["sender" : Auth.auth().currentUser?.email,
                          "body" : self.messageTextField.text!]
        
        messageDB.childByAutoId().setValue(messageDic) { (error, ref) in
            
            if error != nil {
                print(error!)
            } else {
                print("save message")
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
            }
        }
    }
    
    @objc func hideMessageZone() {
        
        self.messageTextField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.5) {
            self.textBoxHeight.constant = 80
            self.view.layoutIfNeeded()
        }
    }
}

extension ChatViewController : UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        
        cell.userNameLabel.text = messageArray[indexPath.row].sender
        cell.messageLabel.text = messageArray[indexPath.row].body
        
        return cell
    }
}

extension ChatViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            
            self.textBoxHeight.constant = 80 + 50 + 258
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        hideMessageZone()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        return true
    }
}
