//
//  StaffOrdersViewController.swift
//  Assighment2
//
//  Created by eennebt on 12/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit
// STAFF ORDERS CLASS ILLUSTRATES ALL THE ORDERS PLACED TO THE RESTURANT AND THE STAFF MEMBERS THAT TOOK THE ORDERS AND TABLENUMBERS OF TEH TABLES SERVED
class StaffOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        var item : [String] = []
        let DB = DBmanager()
        @IBOutlet weak var text: UITextView!
    // TABLE VIEW COUNT
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return item.count
        }
        // DISPLAYS STAFF EMBER NAME AND TABLE NUMBER IN TABLE
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "mycells", for: indexPath)
            var ORDER = item[indexPath.row].split(separator: ":")
            // TABLENO
            let Tableno : String = String(ORDER[1])
            // STAFF MEMBERS NAME
            let Server : String = String(ORDER[2])
            
            cell.textLabel!.text = "TableNo: " + Tableno + "Name: " + Server
            return cell
        }
        // WHEN CELL IS CLICKED ON DISPLAY THE ENTIRE ORDER AND TOTAL PRICE OF ORDER
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            var menuname = item[indexPath.row].split(separator: ":")
            let MenuItems : String = String(menuname[3])
            let Price : String = String(menuname[4])
            text.text = " Customer ORDER: \n " + MenuItems + Price
        }
        // VIEW DID LOAD, LOADS EVERY ORDER INTO ITEM STRING ARRAY WHICH IS USED IN THE TABLE VIEW
        override func viewDidLoad() {
            super.viewDidLoad()
            item = DB.StaffMembers()
        }
    }
