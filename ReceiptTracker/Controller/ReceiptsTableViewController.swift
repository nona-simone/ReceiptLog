//
//  ReceiptsTableViewController.swift
//  ReceiptTracker
//
//  Created by Simone Grant on 8/30/19.
//  Copyright © 2019 Simone Grant. All rights reserved.
//

import UIKit

// TODO: - Add login page for user security
// TODO: - Add option for warranty tracker or insurance and color code entries
// TODO: - Add filters page to view respective categories independently
// TODO: - Add sections to categorize month and/ year


class ReceiptsTableViewController: UITableViewController {
    
    var receipts: ReceiptStore!
    
    //    MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view setup
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receipts.allReceipts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReceiptTableViewCell
        
        cell.styleLabels()
        let retailer = receipts.allReceipts[indexPath.row]
        
        //store name
        cell.storeNameLabel.text = retailer.storeName
        
        //receipt date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let purchaseDate = dateFormatter.string(from: retailer.dateOfPurchase)
        cell.purchaseDateLabel.text = "Purchased \(purchaseDate)"
        
        //purchase amount
        let numFormatter = NumberFormatter()
        numFormatter.minimumFractionDigits = 2
        numFormatter.numberStyle = .decimal
        let purchaseAmt = NSNumber(floatLiteral: retailer.purchaseAmount)
        cell.purchaseAmtLabel.text = "$" + numFormatter.string(from: purchaseAmt)!
        
        return cell
    }
    
    //    MARK: - TableView delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    //    MARK: - Receipt Methods
    
    @IBAction func addReceipt(_ sender: Any) {
        createReceipt()
    }
    
    func createReceipt() {
        let newReceipt = receipts.createReceipt()
        if let index = receipts.allReceipts.firstIndex(of: newReceipt) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editReceipt" {
            let destinationVC = segue.destination as! AddReceiptViewController
            if let row = tableView.indexPathForSelectedRow?.row {
                let receipt = receipts.allReceipts[row]
                destinationVC.retailer = receipt
            }
        }
    }
    
}
