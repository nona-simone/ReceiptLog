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


class ReceiptsTableViewController: UITableViewController, receiptDetailViewControllerDelegate {
    
    var receipts: ReceiptStore!
    
    //    MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view setup
        navigationController?.navigationBar.prefersLargeTitles = true
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
        configureItems(for: cell, with: retailer)
        
        return cell
    }
    
    //    MARK: - TableView delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    //    MARK:- Receipt Methods
    
    func createReceipt(_ receipt: Receipt) {
        var newReceipt = receipts.createReceipt()
        newReceipt = receipt
        if let index = receipts.allReceipts.firstIndex(of: newReceipt) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func configureItems(for cell: UITableViewCell, with receipt: Receipt) {
        //store name 10
        let storeNameLabel = cell.viewWithTag(10) as! UILabel
        storeNameLabel.text = receipt.storeName
        //date of purchase 11
        let purchaseDateLabel = cell.viewWithTag(11) as! UILabel
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let purchaseDate = dateFormatter.string(from: receipt.dateOfPurchase)
        purchaseDateLabel.text = "Purchased \(purchaseDate)"
        //amount paid 12
        let purchaseAmtLabel = cell.viewWithTag(12) as! UILabel
        let numFormatter = NumberFormatter()
        numFormatter.minimumFractionDigits = 2
        numFormatter.numberStyle = .decimal
        let purchaseAmt = NSNumber(floatLiteral: receipt.purchaseAmount)
        purchaseAmtLabel.text = "$" + numFormatter.string(from: purchaseAmt)!
    }
    
    //    MARK:- ReceiptDetailViewControllerDelegate
    
    func receiptDetailViewControllerDidCancel(_ controller: ReceiptDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func receiptDetailViewController(_ controller: ReceiptDetailViewController, didFinishEditing receipt: Receipt) {
        if let index = receipts.allReceipts.index(of: receipt) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureItems(for: cell, with: receipt)
            }
        }
    }
    
    func receiptDetailViewController(_ controller: ReceiptDetailViewController, didFinishAdding receipt: Receipt) {
        createReceipt(receipt)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddReceipt" {
            let destinationVC = segue.destination as! ReceiptDetailViewController
            destinationVC.delegate = self
        } else if segue.identifier == "editReceipt" {
            let destinationVC = segue.destination as! ReceiptDetailViewController
            if let row = tableView.indexPathForSelectedRow?.row {
                let receipt = receipts.allReceipts[row]
                destinationVC.receiptToEdit = receipt
            }
        }
    }
    
}
