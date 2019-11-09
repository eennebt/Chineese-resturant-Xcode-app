//
//  Additionalinfo.swift
//  Assighment2
//
//  Created by eennebt on 17/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit

class Additionalinfo: UIViewController {
    var Namer = ""

    @IBOutlet weak var texter: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        var ItemsText = Namer.split(separator: " ")
         let MenuType = String(ItemsText[1])
        
        
        
        print(MenuName)
        print(MenuType)
 
        
        
        
//        let Price = String(Item[0])
//        let menuitem = String(Item[1])
//
//        texter.text!  = menuitem
        
        
        
     }
    

 

}
