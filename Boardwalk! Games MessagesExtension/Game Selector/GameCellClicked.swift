//
//  GameCellClicked.swift
//  Boardwalk! Games MessagesExtension
//
//  Created by Trevin on 6/4/20.
//  Copyright © 2020 AKT Games. All rights reserved.
//

import UIKit

extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        
        if indexPath.row == 2 {
            cell.selectionStyle = .none
        }
        return cell
    }
    
    // When Game Preview Cell is Clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameName: String = games[indexPath.row].title
        
        // Exclude More Coming Soon Cell
        if gameName != "More Coming Soon" {
            self.requestPresentationStyle(.compact)
            let NewMessage = newGameMessage()
            activeConversation?.insert(NewMessage.createMessage(gameName: gameName, newGame: "True"), completionHandler: { (error:Error?) in })
        }
    }
}
