//
//  Editdata.swift
//  Assighment2
//
//  Created by eennebt on 9/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit

// THIS CLASS IS FOR EDITING, UPDATING DELETING INFORMATION ON A MENU ITEM
// WHEN AN ITEM IS SELECTED ON TEH ADMIN PAGE SEGUE DIRECTS TO THIS PAGE
// LINKED TO EDIT DATA VIEW CONTROLLER
class Editdata: UIViewController {
    // VARIABLES
    var finalName = ""
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var price: UITextField!
    let DB = DBmanager()
// VIEWDIDLOAD GRABS INFORMATION FROM CELL TAPPED ON FROM THE ADMIN PAGE
// USES SEGUE TO COLLECT INFORMATION
    override func viewDidLoad() {
        super.viewDidLoad()
        // ITEM INFORMATION PRICE, TYPE, NAME
        var ITEM = finalName.split(separator: ",")
        let MenuName = String(ITEM[0])
        let MenuType = String(ITEM[1])
        let MenuPrice = String(ITEM[2])
        NameText.text! = MenuName
        if(MenuType == " Main"){
        segment.selectedSegmentIndex = 0
        }else if (MenuType == " Entree"){
            segment.selectedSegmentIndex = 1
        }else{
            segment.selectedSegmentIndex = 2
        }
        price.text! = MenuPrice
}
    
    // UPDATE BUTTON UPDATES THE EITHER THE ORDERS TYPE OR PRICE USING THE NAME OF THE ITEM
    @IBAction func updateBtn(_ sender: Any) {
    // ITEM INFORMATION PRICE, TYPE, NAME
        let PRICE  = (price.text! as NSString).doubleValue
        let type  =  segment.titleForSegment(at: segment.selectedSegmentIndex)!
        let NAMER = NameText.text!
        let ITEMNAME = NAMER.trimmingCharacters(in: .whitespacesAndNewlines)
        
         // UPDATE ITEM
        DB.updateData(name: ITEMNAME, Type: type, price: PRICE)
       
         // ALERT INDICATING ITEM IS UPDATED
        let str1 : String = "Updated " + " " + ITEMNAME + " to Menu "
        let alert = UIAlertController(title: "UPDATED", message: str1 , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // DELETE BUTTON DELETS THE ITEM FORM TEH DATABASE
    @IBAction func Dltbtn(_ sender: Any) {
    // ITEM INFORMATION PRICE, TYPE, NAME
        let dlt : String = NameText.text!
        let ITEMNAME = dlt.trimmingCharacters(in: .whitespacesAndNewlines)
        // REMOVE ITEM FROM ORDER ENTITY
        DB.removeRecords(name: ITEMNAME, entity: "Order")
        
        // ALERT INDICATING ITEM IS UPDATED

        
        let str1 : String = "Deleted " + " " + ITEMNAME + " From Menu "
        let alert = UIAlertController(title: "Record Deleted", message:  str1, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("Deleted")
        NameText.text = " "
        price.text = " "
    }
    
}
