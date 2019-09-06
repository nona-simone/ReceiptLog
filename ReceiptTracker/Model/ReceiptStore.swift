//
//  ReceiptStore.swift
//  ReceiptTracker
//
//  Created by Simone on 8/30/19.
//  Copyright © 2019 Simone. All rights reserved.
//

import Foundation

class ReceiptStore {
    var allReceipts = [Receipt]()
    
    @discardableResult func createReceipt() -> Receipt {
        let newReceipt = Receipt(storeName: "Edit Store", purchaseAmount: 0.00)
        allReceipts.append(newReceipt)
        return newReceipt
    }
    
    func removeReceipt(_ receipt: Receipt) {
        if let index = allReceipts.firstIndex(of: receipt) {
            allReceipts.remove(at: index)
        }
    }
}
