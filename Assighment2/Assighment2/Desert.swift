//
//  Desert.swift
//  Assighment2
//
//  Created by eennebt on 13/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit


// DESERT PAGE
class Desert: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
// VARIABLES
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var tablev: UITableView!
    var item : [String] = []
    let DB = DBmanager()
    // CELLS TUPLE
    var cells : [(item:String, switchl:Bool)] = []
    var fetchedImage = [UIImage]()

    
// TABLE VIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }

// TABLE VIEW IMAGES TEXT AND SWITCH VALUE DESERT
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CELL = tableView.dequeueReusableCell(withIdentifier: "Mycell", for: indexPath) as! TableViewCell
        CELL.DesertLbl.text = item[indexPath.row]
        CELL.DesertSwitch.setOn(cells[indexPath.row].switchl, animated: true)
        CELL.Desertimage.image = fetchedImage[indexPath.row]
        return CELL
    }

//  CELL FOR ROW FUNCTION REFERS TO TABLEVIEWCELL CLASS DELEGATES THE INFORMATION ON THE DISH A SWITCH VALUE AND AN IMAGE OF THE DISH
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let CELL = tableView.dequeueReusableCell(withIdentifier: "Mycell", for: indexPath) as! TableViewCell
        let msg : String = item[indexPath.row]
        lbl.text = msg
        cells[indexPath.row].switchl = !cells[indexPath.row].switchl
        CELL.DesertSwitch.setOn(cells[indexPath.row].switchl, animated: true)
        tablev.reloadData()

    }
    
// VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
            item = DB.getMenu()
            item = DB.DESERT()
            fetchedImage = DB.Desertimageretrieve()
        
//  APPEND IN THE TUPLE
        for items in item
        {
            cells.append((items , false))
        }
        // Do any additional setup after loading the view.
    }
    

//  SUBMIT BUTTON FOR ORDER ENTITY
    @IBAction func Submitbtn(_ sender: UIButton) {
        lbl.text = ""
        let rowcounter = tablev.numberOfRows(inSection: 0) - 1
        var count = 0
        for row in 0 ... rowcounter {
            if (cells[row].switchl == true){
                print("true")
                print(cells[row].item + "\n")
                var menuname = cells[row].item.split(separator: ",")
                let DesertName : String = String(menuname[0])
                let Price: String = String(menuname[2])
                let MYPRRICE = (Price as NSString).doubleValue
                DB.CustomerOrder(main: "", entree: "", desert: DesertName, price: MYPRRICE)
                count += 1
            }else{
                print("False")
            }
        }
        let countrer = String(count)
        let str1 : String = "Added " + " " + countrer + " To Order "
        let alert = UIAlertController(title: "Alert", message: str1 , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
