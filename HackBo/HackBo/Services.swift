//
//  Services.swift
//  HackBo
//
//  Created by Paolo Ramos Mendez on 7/29/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

private let _sharedInstance = Services()

class Services: NSObject {

    class var sharedInstance: Services {
        return _sharedInstance
    }
    
    fileprivate override init() {
        super.init()
    }
    
    let serverUrl = "http://10.31.67.40:8000"
    
//    Obtener información de usuario por email: [GET] http://10.31.67.40:8000/user/getUserByEmail/<email>
    func login(_ mail: String, completionHandler: @escaping (_ success: Bool, _ response: JSON) -> ()) {
        Alamofire.request("\(serverUrl)/user/getUserByEmail/\(mail)").responseJSON { (response) in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            completionHandler(response.error == nil, JSON(response.data ?? Data()))
            
        }
    }
    
//    Obtener todas las transacciones por usuario id: [GET] http://10.31.67.40:8000/transaction/getTransactionByUser/<userId>
    func getTransaction(userId: String, completionHandler: @escaping (_ success: Bool, _ response: JSON) -> ()) {
        Alamofire.request("\(serverUrl)/transaction/getTransactionByUser/\(userId)").responseJSON { (response) in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            completionHandler(response.error == nil, JSON(response.data ?? Data()))
        }
    }
    
//    Crear nueva transacción: [POST] http://10.31.67.40:8000/transaction/createTransaction
//    {
//    "usuarioId": 1,
//    "categoriaId": 1,
//    "item": "Salario mensual - Julio",
//    "monto": 4000
//    }
    func newTransaction(userId: Int, catId: Int, item: String, amount: Double, completionHandler: @escaping (_ success: Bool, _ response: JSON) -> ()) {
        let parameters: Parameters = [
            "usuarioId": userId,
            "categoriaId": catId,
            "item": item,
            "monto": amount
        ]
        print("\(parameters)")
        
        let headers: HTTPHeaders = [ "Content-Type": "application/json"]
        Alamofire.request("http://10.31.67.40:8000/transaction/createTransaction", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().response(completionHandler: { (response) in
            
            print(response)
            completionHandler(response.error == nil, JSON(response.data ?? Data()))
        })
    }
    
//    Obtener todas las categorias de ingresos: [GET] http://10.31.67.40:8000/category/getCategoriesByType/ingreso
    func getIncomeCategory(completionHandler: @escaping (_ success: Bool, _ response: JSON) -> ()) {
        Alamofire.request("\(serverUrl)/category/getCategoriesByType/ingreso").responseJSON { (response) in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            completionHandler(response.error == nil, JSON(response.data ?? Data()))
        }
    }
    
//    Obtener todas las categorias de gastos: [GET] http://10.31.67.40:8000/category/getCategoriesByType/gasto
    func getExpenseCategory(completionHandler: @escaping (_ success: Bool, _ response: JSON) -> ()) {
        Alamofire.request("\(serverUrl)/category/getCategoriesByType/gasto").responseJSON { (response) in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            completionHandler(response.error == nil, JSON(response.data ?? Data()))
        }
    }
    
}
