//
//  ViewController.swift
//  HackBo
//
//  Created by Paolo Ramos Mendez on 7/28/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Services.sharedInstance.login("paololabsplus@gmail.com") { (success, response) in
            print("\(success) >>> \(response)")
        }
        
        Services.sharedInstance.getIncomeCategory { (success, response) in
            print("\(success) >>> \(response)")
        }
        
        Services.sharedInstance.getExpenseCategory { (success, response) in
            print("\(success) >>> \(response)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

