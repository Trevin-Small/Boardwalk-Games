//
//  MessagesViewController.swift
//  Boardwalk! Games MessagesExtension
//
//  Created by Trevin on 6/3/20.
//  Copyright © 2020 AKT Games. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    @IBOutlet var GameSelector: UIView!
    @IBOutlet weak var GameOptionsTable: UITableView!
    
    var games: [GameAttributes] = []
    let LocalUUID = MyUUID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        games = createArray()
        GameOptionsTable.delegate = self
        GameOptionsTable.dataSource = self
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // If extension is opening from a selected extension message object
        if let selectedMessage = conversation.selectedMessage {
            didSelect(selectedMessage, conversation: conversation)
        }
    }
    
    override func didResignActive(with conversation: MSConversation) {
        UserDefaults.standard.synchronize()
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Check if received message is part of a session. If not, game ended (Win or Loss Scenario)
        if let receivedSession = message.session {
            // Check if the received messages session matches the opened messages session
            if receivedSession == conversation.selectedMessage?.session {
                let receivedMessage = ReadMessage(message: message)
                print(receivedMessage.getGame())
            }
        }
    }
    
    override func didSelect(_ message: MSMessage, conversation: MSConversation) {
        GameSelector.isHidden = true
        let ReceivedMessage = ReadMessage(message: message)
        let gameName = ReceivedMessage.getGame()
        let ResponseGameMessage = GameMessage()
        
        // If selected Message was sent by a seperate device
        if  ReceivedMessage.getUUID() != LocalUUID.getUUID() {
            
            switch ReceivedMessage.getGame() {
            
            case "Skeeball":
                let Skeeball = skeeballGame(queryItems: ReceivedMessage.getQueryItems())
                Skeeball.updateUI()
                // Skeeball.playGamge()?
                let message = ResponseGameMessage.responseMessage(gameName: gameName, session: ReceivedMessage.getSession(), url: Skeeball.responseURL())
                activeConversation?.insert(message, completionHandler: { (error:Error?) in })
                
            case "Cornhole":
                let Cornhole = cornholeGame(queryItems: ReceivedMessage.getQueryItems())
                Cornhole.updateUI()
                // Cornhole.playGame()?
                let message = ResponseGameMessage.responseMessage(gameName: gameName, session: ReceivedMessage.getSession(), url: Cornhole.responseURL())
                activeConversation?.insert(message, completionHandler: { (error:Error?) in })
                
            case "Drunk Cornhole":
                let DrunkCornhole = drunkCornholeGame(queryItems: ReceivedMessage.getQueryItems())
                DrunkCornhole.updateUI()
                // DrunkCornhole.playGame()?
                let message = ResponseGameMessage.responseMessage(gameName: gameName, session: ReceivedMessage.getSession(), url: DrunkCornhole.responseURL())
                activeConversation?.insert(message, completionHandler: { (error:Error?) in })
                
            default:
                break
            }
            
        // If the Selected Message was sent by local device
        } else {

            switch ReceivedMessage.getGame() {
            
            case "Skeeball":
                // Display UI With Gray Tint, "Waiting For Opponent"
                return
            
            case "Cornhole":
                // Display UI With Gray Tint, "Waiting For Opponent"
                return
            
            case "Drunk Cornhole":
                // Display UI With Gray Tint, "Waiting For Opponent"
                return
            
            default:
                break
            }
        }
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        self.dismiss()
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the extension content without sending
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
    
}


//------------------------------------------------------------------------------------------------------
// ---------------------- Game Preview Cell Extension --------------------------------------------------
//------------------------------------------------------------------------------------------------------


extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Create an array of Game objects with appropriate images and text
    func createArray() -> [GameAttributes] {
        var tempGames: [GameAttributes] = []
        
        // Create New Game Objects, store information for Cells
        let Game1 = GameAttributes(image: Images.skeeball, title: "Skeeball")
        let Game2 = GameAttributes(image: Images.cornhole, title: "Cornhole")
        let Game3 = GameAttributes(image: Images.drunkCornhole, title: "Drunk Cornhole")
        let Game4 = GameAttributes(image: Images.comingSoon, title: "More Coming Soon")
        
        // Append Game Objects to Array
        tempGames.append(Game1)
        tempGames.append(Game2)
        tempGames.append(Game3)
        tempGames.append(Game4)
        
        return tempGames
    }
    
    // Define Number of Cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    // Configure The Cells and their Data, runs as many times as there are cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Variable game equals the Game object of index from games array
        let game = games[indexPath.row]
        
        // Create instance of GameCell as "cell" with tableViewCell identifier gameCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as! GameCell
        
        // Assign correct Image and Title to Cell based on game object that is passed in
        cell.setGame(game: game)
        
        // Make Cell "Coming Soon" have no selection animation
        if indexPath.row == games.count - 1 {
            cell.selectionStyle = .none
        }
        return cell
    }
    
    // When Game Preview Cell is Clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameName: String = games[indexPath.row].title
        let NewGameMessage = GameMessage()
        let message = NewGameMessage.createMessage(gameName: gameName, uuid: LocalUUID.getUUID())
        // Exclude More Coming Soon Cell
        if gameName != "More Coming Soon" {
            self.requestPresentationStyle(.compact)
            activeConversation?.insert(message, completionHandler: { (error:Error?) in })
        }
    }
    
// End of Extension
}
