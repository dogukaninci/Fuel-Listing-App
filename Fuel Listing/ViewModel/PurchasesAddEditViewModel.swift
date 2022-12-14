//
//  PurchasesAddEditViewModel.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 4.10.2022.
//

import Foundation
import UIKit

class PurchasesAddEditViewModel {
    
    var normalPrice = String()
    var dopedPrice = String()
    var brand = String()
    var fuelType = String()
    
    var imagePath = String()
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    var object = DbModel()
    
    var price = String(){
        didSet {
            self.totalPrice = String(format: "%.2f", (Float(liter) ?? 0) * (Float(price) ?? 0))
        }
    }
    var liter = "0.0" {
        didSet {
            if literTrigger == true {
                self.totalPrice = String(format: "%.2f", (Float(liter) ?? 0) * (Float(price) ?? 0))
            }
        }
    }
    var totalPrice = "0.0" {
        didSet {
            if totalPriceTrigger == true {
                self.liter = String(format: "%.2f", (Float(totalPrice) ?? 0) / (Float(price) ?? 0))
            }
        }
    }
    var priceTrigger: Bool = false
    var literTrigger: Bool = false
    var totalPriceTrigger: Bool = false
    
    
    init(normalPrice: String, dopedPrice: String, brand: String, fuelType: String) {
        self.normalPrice = normalPrice
        self.dopedPrice = dopedPrice
        self.price = normalPrice
        self.fuelType = fuelType
        self.brand = brand
    }
    init(object: DbModel) {
        self.object = object
        self.normalPrice = object.price
        self.dopedPrice = object.price
        self.price = object.price
        self.fuelType = object.fuelType
        self.brand = object.brand
        self.liter = object.liter
        self.totalPrice = object.totalPrice
        self.imagePath = object.imagePath
    }
    
    func saveData() {
        if object.uuid == "" {
            object.uuid = UUID().uuidString
            object.price = price
            object.liter = liter
            object.totalPrice = totalPrice
            object.date = DateManager.shared.dateString()
            object.brand = brand
            object.fuelType = fuelType
            object.imagePath = imagePath
            
            RealmManager.shared.save(object: object)
        }else {
            let copyObject = DbModel()
            copyObject.uuid = object.uuid
            copyObject.price = price
            copyObject.liter = liter
            copyObject.totalPrice = totalPrice
            copyObject.date = DateManager.shared.dateString()
            copyObject.brand = brand
            copyObject.fuelType = fuelType
            copyObject.imagePath = imagePath
            
            RealmManager.shared.update(object: copyObject)
        }
        
    }
    func changePriceToNormal() {
        self.price = normalPrice
    }
    func changePriceToDoped() {
        self.price = dopedPrice
    }
    func getImage() -> UIImage?{
        if FileManager.default.fileExists(atPath: imagePath) {
            let url = URL(string: imagePath)
            do {
                let data = try Data(contentsOf: url!)
                return UIImage(data: data)
            } catch {
                print("Not able to load image")
            }
        }
        return nil
    }
}
