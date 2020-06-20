//
//  GameCell.swift
//  Boardwalk! Games MessagesExtension
//
//  Created by Trevin on 6/3/20.
//  Copyright © 2020 AKT Games. All rights reserved.
//

import Foundation
import UIKit

class GameCell: UITableViewCell {

    @IBOutlet weak var GamePreview: UIImageView!
    @IBOutlet weak var GameLabel: UILabel!
     
    func setGame(game: GameAttributes) {
        
        GamePreview.image = game.image
        GameLabel.text = game.title
        
        GamePreview.layer.cornerRadius = 15
        GamePreview.layer.borderWidth = 2.0
        
        switch game.title {
        case "More Coming Soon":
            GamePreview.layer.borderColor = UIColor.white.cgColor
        default:
            GamePreview.layer.borderColor = UIColor.black.cgColor
        }
        
        GameLabel.textColor = UIColor.black
        GameLabel.layer.cornerRadius = 15
    }
    
}
