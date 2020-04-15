//
//  Message.swift
//  ChatApp
//
//  Created by Cristian Sedano Arenas on 15/04/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class Message {
    
    var sender : String = ""
    var body : String = ""
    
    init(sender : String, body : String) {
        
        self.sender = sender
        self.body = body
    }
}
