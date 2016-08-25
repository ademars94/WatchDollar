//
//  ExpenseCell.swift
//  WatchDollar
//
//  Created by Alex DeMars on 8/24/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class ExpenseCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
