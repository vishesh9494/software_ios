//
//  customCell.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 27/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class customCell: UITableViewCell{
    @IBOutlet weak var studName: UILabel!
    @IBOutlet weak var reqRoom: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        studName.text="a"
        reqRoom.text="a"
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
