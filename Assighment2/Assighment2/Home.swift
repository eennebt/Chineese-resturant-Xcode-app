//
//  ViewController.swift
//  Assighment2
//
//  Created by eennebt on 3/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit

// HOME CLASS
class Home: UIViewController {

    @IBOutlet weak var homeimage: UIImageView!
    var DB = DBmanager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let yourImage: UIImage = UIImage(named: "images")!
        homeimage.image = yourImage
    }
// START BUTTON RESETS PREVIOUS CUSTOMER ORDER
    @IBAction func StartBtn(_ sender: Any) {
         DB.ClearDB(name: "CustomerOrder")
    }
    
}

