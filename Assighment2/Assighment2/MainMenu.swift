//
//  ViewController2.swift
//  Assighment2
//
//  Created by eennebt on 8/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit

 // THIS CLASS IS FOR MAIN MENU DISHES/ITEMS INSERTED INTO THE DATABASE

class MainMenu: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //LIST OF VARIABLES
    var Menuitem : [String] = []
    @IBOutlet weak var MSG: UILabel!
    @IBOutlet weak var Confirm: UIButton!
    let db = DBmanager()
    var cells : [(item:String, switchl:Bool)] = []
    var fetchedImage = [UIImage]()
    @IBOutlet weak var de: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    // TABLE VIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return item.count
        return cells.count
    }
    
    // CELL FOR ROW FUNCTION REFERS TO TABLEVIEWCELL CLASS DELEGATES THE INFORMATION ON THE DISH A SWITCH VALUE AND AN IMAGE OF THE DISH
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
          let CELL = tableview.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! TableViewCell
            CELL.Labeltxt.text = cells[indexPath.row].item
            CELL.Switcher.setOn(cells[indexPath.row].switchl, animated: true)
            CELL.mainimage.image = fetchedImage[indexPath.row]
        return CELL
    }
    
    // WHEN ROW IS SELECTED LOFICAL STATE IS CHANGED TO EITHER TRUE OR FALSE WHETHER TO ADD THE DISH TO THE ORDER
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let CELL = tableview.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! TableViewCell        
        MSG.text = cells[indexPath.row].item
        cells[indexPath.row].switchl = !cells[indexPath.row].switchl
        CELL.Switcher.setOn(cells[indexPath.row].switchl, animated: true)
        tableview.reloadData()
    }
    
    //VIEW DID LOAD LOADS EVERYY MAIN MENU ITEM INTO AN ARRAY WHICH IS LOADED INTO THE TABLEVIEW
    // USING TUPLES
    override func viewDidLoad() {
        super.viewDidLoad()
        let results = db.getMenu()
         Menuitem = results
        fetchedImage = db.menuimageretrieve()
        for item in results
        {
            cells.append((item , false))
        }

    }
    //CONFIRM BUTTON, CONFRIMS THE ITEMS SELECTED AND ADDS THEM TO THE CUSTOMER ORDER ENTITY
    @IBAction func ConfirmBtn(_ sender: Any) {
  
        let rowcounter = tableview.numberOfRows(inSection: 0) - 1
        print(rowcounter)
        var count = 0
        for row in 0 ... rowcounter{
            if (cells[row].switchl == true){
                print("true")
                print(cells[row].item + "\n")
                
                        var menuname = cells[row].item.split(separator: ",")
                        let MainName : String = String(menuname[0])
                        let Price: String = String(menuname[2])
                        let MYPRRICE = (Price as NSString).doubleValue
                db.CustomerOrder(main: MainName, entree: "", desert: "", price: MYPRRICE)
                count += 1
            }else{
                print("False")
            }
        }
        
        let numOfItemsAdded = String(count as Int)
        let str1 : String = "Added: " + numOfItemsAdded + " Items " + "" + " To Order "

        let alert = UIAlertController(title: "Alert", message: str1 , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
 

}
