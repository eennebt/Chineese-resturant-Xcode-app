//
//  DBmanager.swift
//  Assighment2
//
//  Created by eennebt on 8/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit
import CoreData

// DATABASE CLASS
class DBmanager: NSObject {
    
    var SEARCHRESULT = 0
    // STRING ARRAYS  ENTREE, DESERT, MAIN AND ENTIRE MENU
    var Entre : [String] = []
    var Desert : [String] = []
    var menu : [String] = []
    var EntireDB : [String] = []
    // CUSTOMER ORDER ARRAY
     var CustomerOrder : [String] = []
    // TOTAL COST
    var Totalcost : Double = 0.0

    // IMAGES ARRAY MENU IMAGES, ENTREE AND DESERT
    var fetchedImage = [UIImage]()
    var menuImage = [UIImage]()
    var entreeImage = [UIImage]()
    var Desertimage = [UIImage]()
    
   
// FUNCTION RETRIEVS EVERY IMAGE IN THE DATABASE
    func imageretrieve() -> [UIImage]{
        
        return fetchedImage;
    }
// RETRIEVES ENTREE ITEM
    func Entree () -> [String] {
        
        return Entre;
    }
// RETRIEVES DESERT ITEMS

    func DESERT () -> [String] {
        
        return Desert;
    }
    
// RETRIEVES EVERY ITEM IN THE DATABASE

    func allDB () -> [String]
    {
        return EntireDB;
    }
// IMAGE RETRIEVAL
    func menuimageretrieve() -> [UIImage]{
        
        return menuImage;
    }
//     DESERT RETRIEVAL
    func  Desertimageretrieve() -> [UIImage]{
        
        return Desertimage;
    }
    
// ENTREE RETREIVAL
    func entreeimageretrieve() -> [UIImage]{
        
        return entreeImage;
    }
// TOTAL COST OF ORDER
    func TotalCost () -> Double {
        
        return Totalcost;
    }
    
    


// MENU INFORMATION
    func getMenu () -> [String] {
        var info = ""
        //create a fetch request, telling it about the entity
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "Order")
        
        do {
            //go get the results
            let searchResults = try managedContext!.fetch(fetchRequest)
            
            // check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            SEARCHRESULT = searchResults.count
            //RETRIEVS ALL VALUES
            for trans in searchResults as [NSManagedObject] {
                let price = String(trans.value(forKey: "price") as! Double)
                let ordertype = trans.value(forKey: "ordertype") as! String
                let item = trans.value(forKey: "item") as! String
                let image = trans.value(forKey: "image") as! NSData
                fetchedImage.append(UIImage(data: image as Data)!)
                info = item + " , " + ordertype + ", " + price + "$ " + "\n"
//                EVERY VALUE APPENDED INTO ENTIRE DB ARRAY STRING
                
                EntireDB.append(info)
//              MAIN ITEMS APPENDED INTO MENU ITEMS
                if(ordertype == "Main"){
                    menu.append(info)
                    menuImage.append(UIImage(data: image as Data)!)

                }
//                DESERT ITEMS APPENEDED INTO DESERT ARRAY
                else if (ordertype == "Desert") {
                    Desert.append(info)
                    Desertimage.append(UIImage(data: image as Data)!)

                }
//              ENTREE ITEMS APPENEDED INTO ENTREE ARRAY
                else if (ordertype == "Entree"){
                    Entre.append(info)
                    entreeImage.append(UIImage(data: image as Data)!)
                }else{
                    print("nil")
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
        return menu;
    }
    
//    STORE STAFF INFORMATION NAME TABLE NUMBER AND ORDER INFORMATION
    func storeStaffInfo (name: String, tableno: Double, Order: String ) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "Staff", in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        //set the entity values
        transc.setValue(name, forKey: "name")
        transc.setValue(tableno, forKey: "tableno")
        transc.setValue(Order, forKey: "order")

        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    //    DELETE RECORDS FOR ENTITY
    func removeRecords (name: String, entity: String) {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let Managedcontext = appDelegate.persistentContainer.viewContext
// delete everything in the table Student and
        let deleteFetch = NSFetchRequest<NSManagedObject>(entityName: entity)
        
        do {
// PREDICATE FINDS THE ITEMS NAME INFORMATION AND DELETES ACCORDINGLY
            deleteFetch.predicate = NSPredicate(format: "item == %@", name)
            let products = try Managedcontext.fetch(deleteFetch)
            
// DELETE RECROD
            for product in products{
                Managedcontext.delete(product)
            }
        } catch {
            print ("There was an error")
        }
        do {
           try Managedcontext.save()
            
        } catch
        {
            
        }
    }
//   CUSTOMER ORDER INFORMATION DESERT, ENTREE, MAIN, PRICE, TABLE NUMBER
    func CustomerOrder (main: String, entree: String, desert: String,  price: Double) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "CustomerOrder", in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        //set the entity values
        transc.setValue(main, forKey: "desert")
        transc.setValue(entree, forKey: "entree")
        transc.setValue(desert, forKey: "main")
        transc.setValue(price, forKey: "price")
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
//   SHOW ORDER
    func ShowOrder () -> [String] {
        var info = ""
        //create a fetch request, telling it about the entity
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CustomerOrder")
        Totalcost = 0.0
        do {
            //go get the results
            let searchResults = try managedContext!.fetch(fetchRequest)
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            SEARCHRESULT = searchResults.count
            //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as [NSManagedObject] {
                // PRICE DESERT ENTREE AND MAIN
                let price = String(trans.value(forKey: "price") as! Double)
                Totalcost = Totalcost +  Double(price)!
                let desert = trans.value(forKey: "desert") as! String
                let entree = trans.value(forKey: "entree") as! String
                let main = trans.value(forKey: "main") as! String
                
                // DISPLAY ENTREE
                if(entree != ""){
                    info = price + "$  " + entree + "  " + "\n"
                    CustomerOrder.append(info)
                    print(info)
                }
                // DISPLAY DESERT
                else if (desert != ""){
                    info =  price + "$  " + desert + "  " + "\n"
                    CustomerOrder.append(info)
                }
                // DISPLAY MAIN DISH
                else if (main != ""){
                    info =  price + "$  " + main +   "  " + "\n"
                    CustomerOrder.append(info)
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
        return CustomerOrder;
    }
  // CLEAR DATABBASE DELETE ITEM IN THE CUSTOMER ORDER DATABASE
    func ClearDB (name: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let CONTEXT = appDelegate?.persistentContainer.viewContext
        // delete everything in the table Student and
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        // GRAB FETCH
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try CONTEXT?.execute(deleteRequest)
            try CONTEXT?.save()
        } catch {
            print ("There was an error")
        }
        }
    
  // UPDATE DATABASE ITEM FOR NAME
    func updateData (name: String, Type: String, price: Double) {
        //create a fetch request, telling it about the entity
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let Mcontext = appDelegate.persistentContainer.viewContext
        // GRAB FETCH REQUEST
        let retrieveFetch = NSFetchRequest<NSManagedObject>(entityName: "Order")
        do
        {
            retrieveFetch.predicate = NSPredicate(format: "item == %@",  name)
            let products = try Mcontext.fetch(retrieveFetch)
            // ITEM ORDERTYPE AND PRICE
            for product in products{
                print(name)
                product.setValue(name, forKey: "item")
                print(Type)
                product.setValue(Type, forKey: "ordertype")
                print(price)
                product.setValue(price, forKey: "price")
            }
                     do {
                        try Mcontext.save()
                        print("saved!")
                    }catch{
                        print("ERORR NOT SAVED" )
            }
        }catch{
            
            print("ERROR")
        }
    }
    
    
    var Staff : [String] = []
    func StaffMembers () -> [String] {
        var info = ""
        //create a fetch request, telling it about the entity
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "Staff")
        do {
            //go get the results
            let searchResults = try managedContext!.fetch(fetchRequest)
            
            //I like to check the size of the returned results!
             //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as [NSManagedObject] {
                let NAME = trans.value(forKey: "name") as! String
                let Tableno = String(trans.value(forKey: "tableno") as! Double)
                let order = trans.value(forKey: "order") as! String
                info =  "Tableno: " + Tableno + "  Staff:  " + NAME + ":  " +  order + "\n"
                Staff.append(info)
                
            }
        } catch {
            print("Error with request: \(error)")
        }
        return Staff;
    }
// UPDATE STAFF INFORMATION WHEN AN ORDER IS PLACED
    func updateStaff (tableno: Double, Name: String, order: String) {
    // GRAB FETCH REQUETS
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let Mcontext = appDelegate.persistentContainer.viewContext
        let retrieveFetch = NSFetchRequest<NSManagedObject>(entityName: "Staff")
        do
        {
            //  NAME AND TABLENO FIND
            retrieveFetch.predicate = NSPredicate(format: "name == %@  AND tableno == %f",  Name, tableno)
            let products = try Mcontext.fetch(retrieveFetch)
            for product in products{
                // UPDATE ORDER STATUS
                 product.setValue(order, forKey: "order")
                product.setValue(Name, forKey: "name")
                product.setValue(tableno, forKey: "tableno")
            }
            do {
                try Mcontext.save()
                print("saved!")
            }catch{
                print("ERORR NOT SAVED" )
            }
        }catch{
            print("ERROR")
        }
    }
// GRAB INFORMATION ON ADDITIONAL INFORMATION
    func Additionalinfo(text : String) -> String
    {
//GRAB APP DELEGATE
        var info = ""
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let Managedcontext = appDelegate.persistentContainer.viewContext
        // delete everything in the table Student and
        let FindFetch = NSFetchRequest<NSManagedObject>(entityName: "Order")
        
        do {
            //go get the results
            FindFetch.predicate = NSPredicate(format: "item == %@", text)
            let products = try Managedcontext.fetch(FindFetch)
            // FIND MOREINFO FOR AN INTEM TO DISPLAY
            for product in products{
                 let item = product.value(forKey: "moreinfo") as! String
                 info = item
            }
        } catch {
            print("Error with request: \(error)")
        }
        return info;
    }
}



