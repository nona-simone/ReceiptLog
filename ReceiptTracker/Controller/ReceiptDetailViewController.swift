//
//  AddReceiptViewController.swift
//  ReceiptTracker
//
//  Created by Simone on 8/30/19.
//  Copyright © 2019 Simone. All rights reserved.
//

import UIKit

protocol receiptDetailViewControllerDelegate: class {
    func receiptDetailViewControllerDidCancel(_ controller: ReceiptDetailViewController)
    func receiptDetailViewController(_ controller: ReceiptDetailViewController, didFinishEditing receipt: Receipt)
    func receiptDetailViewController(_ controller: ReceiptDetailViewController, didFinishAdding receipt: Receipt)
}

class ReceiptDetailViewController: UIViewController, UINavigationControllerDelegate {

    //    TODO: - Add OCR capabilities to convert image to text
    //    TODO: - Get business api to add store number/address data if available
    //    TODO: - Add camera overlay to ensure receipt is captured correctly
    //    TODO: - Add database to persist and store receipts
    //    TODO: - Add jpeg to pdf conversion
    //    TODO: - Add download/print button for pdf copies of receipts
    
    //    IBOutlets
    @IBOutlet weak var retailerTextField: UITextField!
    @IBOutlet weak var purchaseDateTextField: UITextField!
    @IBOutlet weak var purchaseTotalTextField: UITextField!
    @IBOutlet weak var entryCreatedLabel: UILabel!
    @IBOutlet weak var receiptImageView: UIImageView!
    
    //    property observer for nav title
    var retailer: Receipt! {
        didSet {
            navigationItem.title = retailer.storeName
        }
    }
    
    weak var delegate: receiptDetailViewControllerDelegate?
    var receiptToEdit: Receipt?
    
//    var receiptImage: ReceiptImage!
    
    //format price and date
    let numFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    //    MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        userInput()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        userInput()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //get rid of first responder
        view.endEditing(true)
        //save receipt
//        setReceiptValues()
    }
    
    //    MARK:- IBAction
    @IBAction func cancel() {
        delegate?.receiptDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let savedReceipt = receiptToEdit {
            retailerTextField.text = savedReceipt.storeName
            purchaseTotalTextField.text = numFormatter.string(from: savedReceipt.purchaseAmount as NSNumber) ?? ""
            purchaseDateTextField.text = dateFormatter.string(from: savedReceipt.dateOfPurchase)
            entryCreatedLabel.text = "Entry created \(dateFormatter.string(from: savedReceipt.dateOfCreation))"
            delegate?.receiptDetailViewController(self, didFinishAdding: savedReceipt)
        } else {
           if let newReceipt = retailer {
                setReceiptValues(newReceipt)
                delegate?.receiptDetailViewController(self, didFinishAdding: newReceipt)
            }
        }
    }
    
    //    MARK:- User Input
    
    func userInput() {
        //store name - empty textfield of default value
        retailerTextField.text == "Edit Store" ? (retailerTextField.text = "") : (retailerTextField.text = retailer.storeName)
        
        //purchase amount - empty textfield of default value
        purchaseTotalTextField.text == "0.00" ? (purchaseTotalTextField.text = "") : (purchaseTotalTextField.text = numFormatter.string(from: retailer.purchaseAmount as NSNumber) ?? "")
        
        //dates
        purchaseDateTextField.text = dateFormatter.string(from: retailer.dateOfPurchase)
        entryCreatedLabel.text = "Entry created \(dateFormatter.string(from: retailer.dateOfCreation))"
    }
    
    func setReceiptValues(_ receipt: Receipt) {
        if let purchaseAmt = purchaseTotalTextField.text, let value = numFormatter.number(from: purchaseAmt), let storeName = retailerTextField.text, let purchaseDate = purchaseDateTextField.text, let date =  dateFormatter.date(from: "\(purchaseDate)") {
            receipt.purchaseAmount = value.doubleValue
            receipt.storeName = storeName
            receipt.dateOfPurchase = date
        }
    }
    
    @IBAction func enterDate(_ sender: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        sender.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)
    }
    
    @objc func dateValueChanged(sender: UIDatePicker) {
        purchaseDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
}



extension ReceiptDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}


extension ReceiptDetailViewController: UIImagePickerControllerDelegate {
    
    //    TODO: - Refactor to make source only available for camera
    @IBAction func captureReceiptImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            //no camera available
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        //place image on screen
        receiptImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    //delete image
    func deleteImage() {
        let blankImage = UIImage()
        receiptImageView.image = blankImage
    }
    
    @IBAction func deleteChoseImage(sender: UIBarButtonItem) {
        deleteImage()
    }


}
