//
//  JsonData.swift
//  HackBo
//
//  Created by Paolo Ramos Mendez on 7/29/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit
import SwiftyJSON

private let _sharedInstance = JsonData()

class JsonData: NSObject {
    class var sharedInstance: JsonData {
        return _sharedInstance
    }
    
    fileprivate override init() {
        super.init()
    }
    
    var userData = JSON()
    var incomeData = JSON()
    var expenseData = JSON()
    
    func addUserData(resp: JSON) {
        self.userData = resp
    }
    
    func addIncomeData(resp: JSON) {
        self.incomeData = resp
    }
    
    func addExpenseData(resp: JSON) {
        self.expenseData = resp
    }
}
