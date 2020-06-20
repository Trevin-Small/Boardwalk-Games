//
//  ReadMessage.swift
//  Boardwalk! Games MessagesExtension
//
//  Created by Trevin on 6/5/20.
//  Copyright © 2020 AKT Games. All rights reserved.
//
import Foundation
import Messages

class ReadMessage {
    
    var receivedMessage: MSMessage
    var receivedSession: MSSession
    var receivedURL: URL?
    var game: String
    var queryItems: [String:String] = [:]
    
    init(message: MSMessage){
        receivedMessage = message
        receivedURL = receivedMessage.url
        receivedSession = receivedMessage.session!
        game = ""
        let urlComponents = URLComponents(url: receivedURL!, resolvingAgainstBaseURL: true)
        if let components = urlComponents {
            if let URLQueryItems = components.queryItems {
                for queryItem in URLQueryItems {
                    queryItems[String(queryItem.name)] = String(queryItem.value ?? "")
                }
            }
        }
    }
    
    func getSession() -> MSSession {
        return receivedSession
    }
    
    func getQueryItems() -> [String:String] {
        return queryItems
    }
    
    func getGame() -> String {
        return queryItems["Game Name"] ?? ""
    }
    
    func getUUID() -> String {
        return queryItems["UUID"] ?? ""
    }
    
}
