//
//  AdminpageViewController.swift
//  Assighment2
//
//  Created by eennebt on 8/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit
import CoreData
// THIS CLASS IS LINKED TO THE ADMIN PAGE VIEW CONTROLLER
class AdminpageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//    VARIABLES
//    STORE INFORMATION  ON DATABASE ENTIRE MENU
    var EntireDB : [String] = []
    let db = DBmanager()
//    IMAGES ARRAY STORE IMAGES
    var fetchedImage = [UIImage]()
    var txt  = ""
    var textpass : String = ""
    var entreeName : String = ""
    @IBOutlet weak var myimageView: UIImageView!
    @IBOutlet weak var tableDB: UITableView!
    @IBOutlet weak var additionalinfo: UITextField!
    @IBOutlet weak var ItemName: UITextField!
    @IBOutlet weak var MenuType: UISegmentedControl!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var imgbtn: UIButton!
    @IBOutlet weak var showdb: UIButton!
    @IBOutlet weak var hidebtn: UIButton!
    
    
    
//   IMAGES STUFF GRAB FROM THE GALLERY
    @IBAction func importimage(_ sender: Any)
    {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        myimageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    
//  TABLE VIEW INFORMATION
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntireDB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = EntireDB[indexPath.row]
        cell.imageView!.image = fetchedImage[indexPath.row]
        return cell
    }
    
//  WHEN CELL IS SELECTED INFORMATION IS PASSED ONTO THE EDIT DATA PAGE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.entreeName = EntireDB[indexPath.row]
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1"{
            let controller = segue.destination as! Editdata
            controller.finalName = self.entreeName
        }
    }
    
  
//  VIEW DID LOAD LAODS EVERY ITEM ON THE MENU INTO THE TABLEVIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        EntireDB = db.getMenu()
        EntireDB = db.allDB()
        fetchedImage = db.imageretrieve()
        tableDB.isHidden = true
        hidebtn.isHidden = true
    }
    
//  SAVE BUTTON SAVES NEW RECORD TO ORDER ENTITY

    @IBAction func SAVEBTN(_ sender: Any) {
//  NEWITEM SAVED INCLUDES PRICE NAME, IMAGE, ADDITIONAL INFORMATION, ORDER TYPE...
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let NewItem = NSEntityDescription.insertNewObject(forEntityName:"Order" , into: context)
        let ordertype = MenuType.titleForSegment(at: MenuType.selectedSegmentIndex)
        let Additional : String =  additionalinfo.text!
        NewItem.setValue(ItemName.text, forKey: "item")
        NewItem.setValue(Double(price.text!)!, forKey: "price")
        NewItem.setValue(ordertype, forKey: "ordertype")
        NewItem.setValue( myimageView.image?.pngData(), forKey: "image")
        NewItem.setValue(Additional, forKey: "moreinfo")
       
        do{
            try context.save()
            print("SAVED record")
            
        }catch
        {
            
            
        }
        tableDB.reloadData()
        let Item : String = ItemName.text!
        ItemName.text = ""
        price.text = ""
        myimageView.image = nil
        
//  MESSAGE ALERTED WHEN SAVED
        let str1 : String = "Added " + " " + Item + " To Menu "
        let alert = UIAlertController(title: "Saved", message: str1 , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

//  SHOW TABLE BUTTON
    @IBAction func Showdb(_ sender: Any) {
        tableDB.reloadData()
        showdb.isHidden = true
        savebtn.isHidden = true
        tableDB.isHidden = false
        imgbtn.isHidden = true
        hidebtn.isHidden = false
    
        
    }
//  HIDE TABLE
    @IBAction func hidetable(_ sender: Any) {
        tableDB.isHidden = true
        showdb.isHidden = false
        savebtn.isHidden = false
        imgbtn.isHidden = false
        hidebtn.isHidden = true
        
    }
    
  
}
