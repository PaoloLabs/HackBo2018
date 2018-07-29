//
//  EstadisticasViewController.swift
//  HackBo
//
//  Created by Paolo Ramos Mendez on 7/29/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit
import Charts
import KRProgressHUD
import SwiftyJSON

class EstadisticasViewController: UIViewController {
    @IBOutlet weak var infOutflow: PieChartView!
    @IBOutlet weak var inflowCategory: PieChartView!
    @IBOutlet weak var outflowCategory: PieChartView!
    @IBOutlet weak var scrollView: UIScrollView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 11.0/255.0, green: 43.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        scrollView.alwaysBounceVertical = true

        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        setChart(dataPoints: months, values: unitsSold)
        // Do any additional setup after loading the view.
        self.getStadistics()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setInflowVsOutflowPieChart(data: [String], values: [Double]){
        
    }
    func setInflowByCategoryChart(data: [String], values: [Double]){
    
    }
    func setOutflowByCategoryChart(data: [String], values: [Double]){
    
    }

    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry1 = PieChartDataEntry(value: Double(i), label: dataPoints[i], data:  dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry1)
            //tips en un scroll
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        outflowCategory.data = pieChartData
        inflowCategory.data = pieChartData
        outflowCategory.data = pieChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
    }
    
    func getStadistics() {
        KRProgressHUD.show()
        let userId = JsonData.sharedInstance.userData["data"]["id"].stringValue
        Services.sharedInstance.getGraphStatistics(userId: userId) { (success, response) in
            KRProgressHUD.dismiss()
            if success {
                print(response)
                let ingresos = response["data"]["ingresos_porcentaje"].doubleValue
                let gastos = response["data"]["gastos_porcentaje"].doubleValue
                
                print("INGRESOS \(ingresos) >>> \(gastos)")
            }
        }
    }
}
