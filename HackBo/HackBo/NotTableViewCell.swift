//
//  NotTableViewCell.swift
//  HackBo
//
//  Created by Paolo Ramos Mendez on 7/29/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit

class NotTableViewCell: UITableViewCell {
    
    @IBOutlet weak var servicio: UILabel!
    @IBOutlet weak var beneficios: UILabel!
    @IBOutlet weak var requerimientos: UILabel!
    @IBOutlet weak var interes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
