//
//  MarketBookTableViewCell.swift
//  iMTS
//
//  Created by VADIM KASSIN on 3/14/16.
//  Copyright © 2016 VADIM KASSIN. All rights reserved.
//

import UIKit

class MarketBookTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sellLabel: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
