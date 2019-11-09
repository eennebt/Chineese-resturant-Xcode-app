//
//  ViewController1.swift
//  Assighment2
//
//  Created by eennebt on 3/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit


// LINKED TO WAITERS PAGE
class Waiters: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // VARIABLES
    @IBOutlet weak var staff: UIPickerView!
    @IBOutlet weak var STAFF: UILabel!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var SubmitBtn: UIButton!
    // STAFF MEMBERS NAMES
    let pickerdata = ["John", "Billy", "Fred", "Sarah", "HARISON", "JONES", "PHIL"]
    var tableno : Double = 0.0
    let db = DBmanager()

    
    // UIPICKER VIEW INFORMATION
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerdata.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerdata[row]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        STAFF.lineBreakMode = NSLineBreakMode.byClipping
        self.staff.dataSource = self
        self.staff.delegate = self
    }
    // UIPICKER VIEW INFORMATION GRABS STAFF INFORMATION AND POPULATES THE PICKER WITH STAFF NAMES
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let valueSelected = pickerdata[row] as String
        for num in pickerdata{
            if (num == pickerdata[row]){
                STAFF.text =  valueSelected
            }
            
        }
        
    }
//    STEPPER VIEW IS TABLE NUMBERS
    @IBAction func Stepper(_ sender: UIStepper)
    {
        lbl.text =  String(sender.value)
      tableno  = sender.value

    }
//   SUBMIT BUTTON SUBMITS THE DATA INTO THE DATABASE STORING THE STAFF INFORMATION
    @IBAction func SUBMIT(_ sender: Any) {
    
       let string1 = lbl.text
       let string2 = STAFF.text
        if(((string1 != nil) && (string2 != nil))){
            //   ALERT INDICATING THAT INDICATES THAT THE INFORMATION HAS BEEN ADDED TO ENTITTY
            let MESSAGE = "TableNo: " + string1! +   "  Waiter: " +  string2!
            let alert = UIAlertController(title: title, message: MESSAGE, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
        let tableno = Double(string1!)
        db.storeStaffInfo(name: string2!, tableno: tableno!, Order: "")
    }
 
}
