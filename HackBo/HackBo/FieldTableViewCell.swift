//
//  FieldTableViewCell.swift
//  HackBo
//
//  Created by Paolo Ramos Mendez on 7/29/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit

class FieldTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var field: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
