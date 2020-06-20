//
//  UUID.swift
//  Boardwalk! Games MessagesExtension
//
//  Created by Trevin on 6/8/20.
//  Copyright © 2020 AKT Games. All rights reserved.
//

import Messages

class MyUUID {
    
    let defaults = UserDefaults.standard
    
    init() {
        guard defaults.string(forKey: "UUID") != nil else {
            defaults.set(UUID().uuidString ,forKey: "UUID")
            return
        }
    }
    
    func getUUID() -> String {
        return defaults.string(forKey: "UUID")!
    }
}
