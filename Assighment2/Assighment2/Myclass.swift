//
//  Myclass.swift
//  Assighment2
//
//  Created by eennebt on 10/10/19.
//  Copyright © 2019 eennebt. All rights reserved.
//

import UIKit

class Myclass: NSObject {

    func foo() -> Int {
        struct Holder {
            static var timesCalled = 0
        }
        Holder.timesCalled += 1
        return Holder.timesCalled
    }
}
