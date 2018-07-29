//
//  TransactionTableViewCell.swift
//  HackBo
//
//  Created by Geovani Mendoza on 7/29/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var lblArrow: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //mylabel.text = @"\u25BA section 1";
        // Configure the view for the selected state
    }
}
