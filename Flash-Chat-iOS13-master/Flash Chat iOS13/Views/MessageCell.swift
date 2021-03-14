//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by JAY LEE on 2021/03/13.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightimageView: UIImageView!
    @IBOutlet weak var leftimageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = CGFloat(20) //messageBubble.frame.size.height/
        
        func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
    }
}



