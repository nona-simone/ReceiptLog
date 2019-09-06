//
//  ReceiptTableViewCell.swift
//  ReceiptTracker
//
//  Created by Simone on 9/5/19.
//  Copyright © 2019 Simone. All rights reserved.
//

import UIKit

class ReceiptTableViewCell: UITableViewCell {

    @IBOutlet weak var purchaseAmtLabel: UILabel!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    
    func styleLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        let captionFont = UIFont.preferredFont(forTextStyle: .caption1)
        storeNameLabel.font = bodyFont
        purchaseAmtLabel.font = bodyFont
        purchaseDateLabel.font = captionFont
    }

}
