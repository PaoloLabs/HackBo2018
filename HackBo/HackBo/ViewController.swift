//
//  ViewController.swift
//  HackBo
//
//  Created by Paolo Ramos Mendez on 7/28/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit
import KRProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    let userTest = "ferna.mace.34@gmail.com"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginMode(_ sender: UIButton) {
        self.nameTxt.text = self.userTest
        if let mail = nameTxt.text {
            KRProgressHUD.show()
            Services.sharedInstance.login(mail) { (success, response) in
                if success {
                    JsonData.sharedInstance.addUserData(resp: response)
                    Services.sharedInstance.getIncomeCategory(completionHandler: { (success, income) in
                        if success {
                            JsonData.sharedInstance.addIncomeData(resp: income)
                            Services.sharedInstance.getExpenseCategory(completionHandler: { (success, expense) in
                                if success {
                                    KRProgressHUD.dismiss()
                                    JsonData.sharedInstance.addExpenseData(resp: expense)
                                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
                                    {
                                        self.present(vc, animated: true, completion: nil)
                                    }
                                }
                            })
                        }
                    })
                }
            }
        }
    }
    
    
}

