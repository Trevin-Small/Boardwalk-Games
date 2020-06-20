//
//  MessageGenerator.swift
//  Boardwalk! Games MessagesExtension
//
//  Created by Trevin on 6/4/20.
//  Copyright © 2020 AKT Games. All rights reserved.
//
import Messages

class GameMessage {
    
    func createMessage(gameName: String, uuid: String) -> MSMessage {
        
        let newSession = MSSession()
        let message = MSMessage(session: newSession)
        let layout = MSMessageTemplateLayout()
        var image: UIImage
        var components = URLComponents()
        components.queryItems = [URLQueryItem(name: "Game Name", value: gameName), URLQueryItem(name: "Game State", value: "New Game"), URLQueryItem(name: "UUID", value: uuid)]
        
        switch gameName {
        case "Skeeball":
            image = Images.skeeball
        case "Cornhole":
            image = Images.cornhole
        case "Drunk Cornhole":
            image = Images.drunkCornhole
        default:
            image = Images.comingSoon
        }
        
        layout.image = image
        layout.caption = gameName
        layout.subcaption = "Boardwalk! Games"
        message.layout = layout
        message.summaryText = "BoardWalk! Games - " + gameName
        message.url = components.url
        return message
    }
    
    func responseMessage(gameName: String, session: MSSession, url: URL) -> MSMessage {
        let message = MSMessage(session: session)
        let layout = MSMessageTemplateLayout()
        var image: UIImage
        
        switch gameName {
        case "Skeeball":
            image = Images.skeeball
        case "Cornhole":
            image = Images.cornhole
        case "Drunk Cornhole":
            image = Images.drunkCornhole
        default:
            image = Images.comingSoon
        }
        
        layout.image = image
        layout.caption = gameName
        layout.subcaption = "Boardwalk! Games"
        message.layout = layout
        message.summaryText = gameName
        message.url = url
        return message
    }
}
