//
//  SWITCHES.swift
//  Assighment2
//
//  Created by eennebt on 15/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit

class SWITCHES: NSObject {
    var dataname : String
    var SwitchValue : Bool

    init(dat: String , sw : Bool) {
        self.dataname = dat
        self.SwitchValue = sw
    }
}
