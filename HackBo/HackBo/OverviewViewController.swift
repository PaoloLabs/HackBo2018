//
//  OverviewViewController.swift
//  HackBo
//
//  Created by Paolo Ramos Mendez on 7/29/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 11.0/255.0, green: 43.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "FieldTableViewCell", bundle: nil), forCellReuseIdentifier: "FieldTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}

extension OverviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FieldTableViewCell") as! FieldTableViewCell
            cell.titleLbl.text = "Categoria"
            cell.field.placeholder = "Seleccione una categoria"
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FieldTableViewCell") as! FieldTableViewCell
            cell.titleLbl.text = "Item"
            cell.field.placeholder = ""
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FieldTableViewCell") as! FieldTableViewCell
            cell.titleLbl.text = "Monto"
            cell.field.placeholder = ""
            cell.field.keyboardType = .decimalPad
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
