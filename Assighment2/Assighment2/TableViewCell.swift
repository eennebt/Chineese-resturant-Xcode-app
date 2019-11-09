//
//  TableViewCell.swift
//  Assighment2
//
//  Created by eennebt on 15/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit
// TABLEVIEW CELL
class TableViewCell: UITableViewCell {
    
    //Main DISH BTNS cell
    @IBOutlet weak var Labeltxt: UILabel!
    @IBOutlet weak var Switcher: UISwitch!
    @IBOutlet weak var mainimage: UIImageView!
    
    //DESERT BTNS cell
    @IBOutlet weak var DesertLbl: UILabel!
    @IBOutlet weak var DesertSwitch: UISwitch!
    @IBOutlet weak var Desertimage: UIImageView!
    
    //ENTREE BTNS cell
    @IBOutlet weak var EntreeLabel: UILabel!
    @IBOutlet weak var EntreeSwitch: UISwitch!
    @IBOutlet weak var Entreeimage: UIImageView!
    
     // Order Page
    @IBOutlet weak var Ordername: UILabel!
    @IBOutlet weak var Orderinfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
