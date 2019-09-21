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
    
    @discardableResult func createReceipt(_ newItem: Receipt) -> Receipt {
        let newReceipt = Receipt(storeName: newItem.storeName, purchaseAmount: newItem.purchaseAmount, dateOfPurchase: newItem.dateOfPurchase)
        allReceipts.append(newReceipt)
        return newReceipt
    }
    
    func removeReceipt(_ receipt: Receipt) {
        if let index = allReceipts.firstIndex(of: receipt) {
            allReceipts.remove(at: index)
        }
    }
}
