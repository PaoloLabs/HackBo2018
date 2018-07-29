//
//  OverviewViewController.swift
//  HackBo
//
//  Created by Paolo Ramos Mendez on 7/29/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit
import SwiftyJSON
import KRProgressHUD

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ingresoItem: UIBarButtonItem!
    @IBOutlet weak var gastoItem: UIBarButtonItem!
    
    var categoryCell = FieldTableViewCell()
    var itemCell = FieldTableViewCell()
    var montoCell = FieldTableViewCell()
    var category = JSON()
    var categoryArray = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 11.0/255.0, green: 43.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "FieldTableViewCell", bundle: nil), forCellReuseIdentifier: "FieldTableViewCell")
        self.categoryArray = JsonData.sharedInstance.incomeData["data"].arrayValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ingresoAction(_ sender: UIBarButtonItem) {
        self.ingresoItem.tintColor = UIColor(red: 95.0/255.0, green: 190.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        self.gastoItem.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = "INGRESO";
        self.tableView.reloadData()
        self.categoryArray = JsonData.sharedInstance.incomeData["data"].arrayValue
        print("\(JsonData.sharedInstance.incomeData)")
        
    }
    
    @IBAction func egresoAction(_ sender: UIBarButtonItem) {
        self.gastoItem.tintColor = UIColor(red: 95.0/255.0, green: 190.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        self.ingresoItem.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = "EGRESO";
        self.tableView.reloadData()
        self.categoryArray = JsonData.sharedInstance.expenseData["data"].arrayValue
        print("\(JsonData.sharedInstance.expenseData)")
    }
    
    func showCategory() {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        for item in self.categoryArray {
            let item = UIAlertAction(title: item["categoria"].stringValue, style: .default)
            { _ in
                self.category = item
                self.categoryCell.field.text = item["categoria"].stringValue
            }
            actionSheetControllerIOS8.addAction(item)
        }
        actionSheetControllerIOS8.view.tintColor = UIColor.black
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        
        KRProgressHUD.show()
        let userId = JsonData.sharedInstance.userData["data"]["id"].intValue
        let categoriaId = self.category["id"].intValue
        let item = self.itemCell.field.text ?? ""
        let monto = Double(self.montoCell.field.text ?? "") ?? 0.0
        
        Services.sharedInstance.newTransaction(userId: userId, catId: categoriaId, item: item, amount: monto) { (success, response) in
            KRProgressHUD.dismiss()
            if success {
                self.itemCell.field.text = ""
                self.categoryCell.field.text = ""
                self.montoCell.field.text = ""
            }
        }
    }
    
}

extension OverviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            self.categoryCell = tableView.dequeueReusableCell(withIdentifier: "FieldTableViewCell") as! FieldTableViewCell
            self.categoryCell.titleLbl.text = "Categoria"
            self.categoryCell.field.placeholder = "Seleccione una categoria"
            self.categoryCell.field.isUserInteractionEnabled = false
            return self.categoryCell
        }
        if indexPath.row == 1 {
            self.itemCell = tableView.dequeueReusableCell(withIdentifier: "FieldTableViewCell") as! FieldTableViewCell
            self.itemCell.titleLbl.text = "Item"
            self.itemCell.field.placeholder = ""
            self.itemCell.field.isUserInteractionEnabled = true
            return self.itemCell
        }
        if indexPath.row == 2 {
            self.montoCell = tableView.dequeueReusableCell(withIdentifier: "FieldTableViewCell") as! FieldTableViewCell
            self.montoCell.titleLbl.text = "Monto"
            self.montoCell.field.placeholder = ""
            self.montoCell.field.keyboardType = .decimalPad
            self.montoCell.field.isUserInteractionEnabled = true
            return self.montoCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //Create the AlertController and add Its action like button in Actionsheet
            self.showCategory()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}
