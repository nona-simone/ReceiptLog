//
//  Receipt.swift
//  ReceiptTracker
//
//  Created by Simone on 8/30/19.
//  Copyright © 2019 Simone. All rights reserved.
//

import Foundation

class Receipt: NSObject {
    var storeName: String
    var dateOfPurchase: Date
    var purchaseAmount: Double
    var dateOfCreation: Date
    
    init(storeName: String, purchaseAmount: Double, dateOfPurchase: Date) {
        self.storeName = storeName
        self.dateOfPurchase = dateOfPurchase
        self.purchaseAmount = purchaseAmount
        self.dateOfCreation = Date()
        
        super.init()
    }
    
    //    Mark: - Save items with NSCoding
    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(storeName, forKey: "storeName")
//        aCoder.encode(dateOfPurchase, forKey: "dateOfPurchase")
//        aCoder.encode(purchaseAmount, forKey: "purchaseAmount")
//        aCoder.encode(dateOfCreation, forKey: "dateCreated")
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        storeName = aDecoder.decodeObject(forKey: "storeName") as! String
//        dateOfPurchase = aDecoder.decodeObject(forKey: "dateOfPurchase") as! Date
//        purchaseAmount = aDecoder.decodeDouble(forKey: "purchaseAmount")
//        dateOfCreation = aDecoder.decodeObject(forKey: "dateCreated") as! Date
//    }
    
}
