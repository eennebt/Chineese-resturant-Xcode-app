//
//  entree.swift
//  Assighment2
//
//  Created by eennebt on 9/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit

class entree: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var entreeitem : [String] = []
    var cells : [(item:String, switchl:Bool)] = []
    var fetchedImage = [UIImage]()
    let db = DBmanager()
    @IBOutlet weak var EntreeLabel: UILabel!
    @IBOutlet weak var SubmitBtn: UIButton!
    @IBOutlet weak var EntreeTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entreeitem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CELL = tableView.dequeueReusableCell(withIdentifier: "entreeCell", for: indexPath) as! TableViewCell
        CELL.EntreeLabel.text = entreeitem[indexPath.row]
        CELL.EntreeSwitch.setOn(cells[indexPath.row].switchl, animated: true)
        CELL.Entreeimage.image = fetchedImage[indexPath.row]
        return CELL
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let msg : String = entreeitem[indexPath.row]
        EntreeLabel.text = msg
        let CELL = tableView.dequeueReusableCell(withIdentifier: "entreeCell", for: indexPath) as! TableViewCell
        cells[indexPath.row].switchl = !cells[indexPath.row].switchl
        CELL.EntreeSwitch.setOn(cells[indexPath.row].switchl, animated: true)
        EntreeTable.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        entreeitem = db.getMenu()
        entreeitem = db.Entree()
        fetchedImage = db.entreeimageretrieve()
        for item in entreeitem
        {
            cells.append((item , false))
        }
    }

    @IBAction func SubmitBtn(_ sender: Any) {
        let rowcounter = EntreeTable.numberOfRows(inSection: 0) - 1
        print(rowcounter)
        var count = 0
        for row in 0 ... rowcounter{
            if (cells[row].switchl == true){
                var menuname = cells[row].item.split(separator: ",")
                let entreeName : String = String(menuname[0])
                let Price: String = String(menuname[2])
                let MYPRRICE = (Price as NSString).doubleValue
                db.CustomerOrder(main: "", entree: entreeName, desert: "", price: MYPRRICE)
                count += 1
            }else{
                print("False")
            }
        }
        let counter = String(count as Int)
        let str1 : String = "Added: " + counter + " Items " + "" + " To Order "
        let alert = UIAlertController(title: "Alert", message: str1 , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

