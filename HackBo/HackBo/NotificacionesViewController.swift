//
//  NotificacionesViewController.swift
//  HackBo
//
//  Created by Paolo Ramos Mendez on 7/29/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit
import SwiftyJSON
import KRProgressHUD
import UserNotifications

class NotificacionesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrayNotification = [JSON]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 11.0/255.0, green: 43.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "NotTableViewCell", bundle: nil), forCellReuseIdentifier: "NotTableViewCell")
        self.getStadistic()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getStadistic() {
        KRProgressHUD.show()
        let userId = JsonData.sharedInstance.userData["data"]["id"].stringValue
        Services.sharedInstance.getTransaction(userId: userId) { (success, response) in
            if success {
                KRProgressHUD.dismiss()
                self.showNotification(data: response)
                
            }
        }
    }
    
    func showNotification(data: JSON) {
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
            if error != nil {
                print("Request authorization failed!")
            } else {
                print("Request authorization succeeded!")
                self.showAlert()
            }
        }
        
        //creating the notification content
        let content = UNMutableNotificationContent()
        
        //adding title, subtitle, body and badge
        content.title = "Felicidades !!!"
        content.subtitle = "Tu ahorro es \(data["data"]["ahorro"].stringValue) Bs."
        content.body = "Puedes acceder a nuevos servicios :D !!!"
        content.badge = 0
        
        //getting the notification trigger
        //it will be called after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //getting the notification request
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
        
        //adding the notification to notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            print("error >>> \(error)")
            
        }

    }
    
    func showAlert() {
        let objAlert = UIAlertController(title: "Alert", message: "Request authorization succeeded", preferredStyle: UIAlertControllerStyle.alert)
        
        objAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        //self.presentViewController(objAlert, animated: true, completion: nil)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(objAlert, animated: true, completion: nil)
    }
    
    func updateList() {
        self.arrayNotification = JsonData.sharedInstance.notificationArray["data"]["servicios"].arrayValue
        self.tableView.reloadData()
    }
}

extension NotificacionesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.arrayNotification[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotTableViewCell") as! NotTableViewCell
        cell.titleLbl.text = item["servicio"].stringValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.arrayNotification[indexPath.row]
         
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayNotification.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}

