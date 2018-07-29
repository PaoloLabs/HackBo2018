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
        // Do any additional setup after loading the view.
        self.getStadistics()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setInflowVsOutflowPieChart(data: [String], values: [Double]){
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<data.count {
            let dataEntry1 = PieChartDataEntry(value: Double(values[i]), label: data[i], data:  data[i] as AnyObject)
            dataEntries.append(dataEntry1)
            print("value >>> \(Double(values[i]))")
        }
        let pieChartDataset3 = PieChartDataSet(values: dataEntries, label: "Ingresos vs Gastos")
        let pieChartData = PieChartData(dataSet: pieChartDataset3)
        
        infOutflow.data = pieChartData
        
        var colors: [UIColor] = []
        for _ in 0..<data.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        pieChartDataset3.colors = colors
    }
    func setInflowByCategoryChart(data: [String], values: [Double]){
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<data.count {
            let dataEntry1 = PieChartDataEntry(value: Double(values[i]), label: data[i], data:  data[i] as AnyObject)
            dataEntries.append(dataEntry1)
        }
        let pieChartDataset3 = PieChartDataSet(values: dataEntries, label: "Ingresos por Categoría")
        let pieChartData = PieChartData(dataSet: pieChartDataset3)
        
        inflowCategory.data = pieChartData
        
        var colors: [UIColor] = []
        for _ in 0..<data.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        pieChartDataset3.colors = colors
    }
    func setOutflowByCategoryChart(data: [String], values: [Double]){
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<data.count {
            let dataEntry1 = PieChartDataEntry(value: Double(values[i]), label: data[i], data:  data[i] as AnyObject)
            dataEntries.append(dataEntry1)
        }
        let pieChartDataset3 = PieChartDataSet(values: dataEntries, label: "Ingresos por Categoría")
        let pieChartData = PieChartData(dataSet: pieChartDataset3)
        
        outflowCategory.data = pieChartData
        
        var colors: [UIColor] = []
        for _ in 0..<data.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        pieChartDataset3.colors = colors
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
                let st_x = ["Ingresos","Egresos"]
                let st_y = [ingresos,gastos]
                self.setInflowVsOutflowPieChart(data: st_x, values: st_y)
                //ingresos detalle
                let ingresos_detalle = response["data"]["ingresos_detalle"].arrayValue
                var ingresos_label: [String] = []
                var ingresos_value: [Double] = []
                for data in ingresos_detalle {
                    ingresos_label.append(data["categoria"].stringValue)
                    ingresos_value.append(data["porcentaje"].doubleValue)
                }
                self.setInflowByCategoryChart(data: ingresos_label, values: ingresos_value)
                //gastos detalle
                let gastos_detalle = response["data"]["gastos_detalle"].arrayValue
                var gastos_label: [String] = []
                var gastos_value: [Double] = []
                for data in gastos_detalle {
                    gastos_label.append(data["categoria"].stringValue)
                    gastos_value.append(data["porcentaje"].doubleValue)
                }
                self.setOutflowByCategoryChart(data: gastos_label, values: gastos_value)
                print("INGRESOS \(ingresos) >>> \(gastos)")
            }
        }
    }
}
