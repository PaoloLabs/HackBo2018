//
//  ProfileViewController.swift
//  HackBo
//
//  Created by Paolo Ramos Mendez on 7/29/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit
import KRProgressHUD

class ProfileViewController: UIViewController {

    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var telfField: UITextField!
    @IBOutlet weak var ciField: UITextField!
    let user = JsonData.sharedInstance.userData

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 11.0/255.0, green: 43.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // Do any additional setup after loading the view.
        self.userField.text = user["data"]["nombre"].stringValue
        self.mailField.text = user["data"]["email"].stringValue
        self.telfField.text = user["data"]["celular"].stringValue
        self.ciField.text = user["data"]["ci"].stringValue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let user = JsonData.sharedInstance.userData
        self.userField.text = user["data"]["nombre"].stringValue
        self.mailField.text = user["data"]["email"].stringValue
        self.telfField.text = user["data"]["celular"].stringValue
        self.ciField.text = user["data"]["ci"].stringValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func updateAction(_ sender: UIButton) {
        KRProgressHUD.show()
        let userId = JsonData.sharedInstance.userData["data"]["id"].stringValue
        let nombre = self.userField.text ?? user["data"]["nombre"].stringValue
        let celular = self.telfField.text ?? user["data"]["celular"].stringValue
        let edad = self.mailField.text ?? ""
        let ci = self.ciField.text ?? user["data"]["ci"].stringValue
    
        Services.sharedInstance.updateUser(userId: userId, nombre: nombre, celular: Int(celular) ?? 0, edad: Int(edad) ?? 0, ci: Int(ci) ?? 0) { (success, response) in
            KRProgressHUD.dismiss()
            if success {
                JsonData.sharedInstance.userData = response
            }
        }
    }
}
