//
//  OrderPage.swift
//  Assighment2
//
//  Created by eennebt on 9/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit
import MessageUI
// LINKED TO ORDER PAGE VIEW CONTROLLER USED FORM CONFIRMING AN ORDER WHNE COMPELTED
class OrderPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
// VARIABLES
    var item : [String] = []
    let DB = DBmanager()
    var itemName : String = ""
    var staff : [String] = []
    @IBOutlet weak var ordertable: UITableView!
    @IBOutlet weak var Ordertag: UILabel!
    @IBOutlet weak var TotalPrice: UILabel!
    @IBOutlet weak var ClearDB: UIButton!
    
    
    
    // TABLE VIEW POPULATES THE CUSTOMERS ORDER

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    // TABLE VIEW POPULATES THE CUSTOMERS ORDER
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CELL = ordertable.dequeueReusableCell(withIdentifier: "ordercell", for: indexPath) as! TableViewCell
         CELL.Ordername.text = item[indexPath.row]
        self.itemName = item[indexPath.row]
//      MENUNAME INFO
        var menuname =  itemName.split(separator: " ")
//      ADDITIONAL INFO
        let AdditionalInfo = menuname[1]
        let trimmedString = AdditionalInfo.trimmingCharacters(in: .whitespacesAndNewlines)
//      ADDITIONAL INFO AOUT THE DISH SEARCH IN THE DATABASE
        let Moreinfo = DB.Additionalinfo(text: String(trimmedString))
        CELL.Orderinfo.text = "Additional Info: " + Moreinfo
        return CELL
    }
    
    
// VIEW DID LOAD POPULATES TABLE WITH SELECT CUSTOMER ORDER ENTITY
    override func viewDidLoad() {
        super.viewDidLoad()
            Ordertag.isHidden = true
            TotalPrice.isHidden = true
            item = DB.ShowOrder()
            staff = DB.StaffMembers()

    }
    
// SHOWS ENTIRE ORDER OF THE CUSTOMER
    @IBAction func confirmOrder(_ sender: Any) {

        
        var PRICE : Double = 0.00
        PRICE = DB.TotalCost()
        ordertable.reloadData()
        TotalPrice.text! = "Total: " + String(format: "%g", PRICE) + "$"
        Ordertag.isHidden = false
        TotalPrice.isHidden = false
        
        
    }
    
//  CLEARS CUSTOMER ORDER
    @IBAction func clearBtn(_ sender: Any) {
        DB.ClearDB(name: "CustomerOrder")
        TotalPrice.isHidden = true
        let alert = UIAlertController(title: "Order Cleared", message: "CustomerOrder cleared", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        ordertable.reloadData()
        ordertable.isHidden = true
        self.viewDidLoad()
        
    }

    //  SMS FUNCTIONS SENDS MESSAGE TO THE CUSTOMER

    @IBAction func SMS(_ sender: Any) {
        
        displayMessageInterface()
        
    }
    
    
    func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self as? MFMessageComposeViewControllerDelegate;
        
        // Configure the fields of the interface.
        composeVC.recipients = ["3142026521"]
        
        for item in item
        {
            composeVC.body = "ORDER MESSAGE: \n " +  item + "\n Price: " + TotalPrice.text! + "\n"
        }
// IF CAN SEND TEXT SEND OTHERWISE PRINT THE MESSAGE IN THE TERMINAL
         if canSendText() {
            self.present(composeVC, animated: true, completion: nil)
            print("Message sent")
        } else {
            print("Can't send messages. The Contents is: \n ")
            print("\n Price: " + TotalPrice.text! + "\n")
            
            for item in item
            {
                print( "ORDER: " +  item  )
            }
        }
    }
// CAN SEND TEXT MESSAGE
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
// SUBMIT ORDER TO DATABASE
    @IBAction func SubmitOrder(_ sender: Any) {
        var num = ""
        var server_name = ""
        var info = ""
//  ENTIRE CUSTOEMR ORDER
        for item in staff{
            var ITEM = item.split(separator: ":")
            let MenuType = String(ITEM[1])
            let MenuPrice = String(ITEM[2])
            var table = MenuType.split(separator: " ")
            let tableno = String(table[0])
            num = tableno
            server_name = MenuPrice
        }
        let trimmedString = server_name.trimmingCharacters(in: .whitespacesAndNewlines)
        let tablenum = (num as NSString).doubleValue
        
// SUBMIT ORDER TO DATABASE
        for item in item
        {
            info = info + item
            print(info)
            
        }
        var PRICE : Double = 0.00
        PRICE = DB.TotalCost()
        let TotalPrice:String = String(format:"%g", PRICE)
        info = info + "\n Total Price: " + TotalPrice + "$"
        print(info)
// UPDATE STAFF INFORMATION INCLUDING THE ORDER TO BE VIEWED IN STAF MEMBERS PAGE
        DB.updateStaff(tableno: tablenum, Name: trimmedString, order: info)
        let alert = UIAlertController(title: "Order Cleared", message: "CustomerOrder Submited", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
