//
//  PurchasesAddEditViewModel.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 4.10.2022.
//

import Foundation

class PurchasesAddEditViewModel {
    
    var price = String(){
        didSet {
            self.totalPrice = String((Float(liter) ?? 0) * (Float(price) ?? 0))
        }
    }
    var liter = String() {
        didSet {
            if literTrigger == true {
            self.totalPrice = String((Float(liter) ?? 0) * (Float(price) ?? 0))
            }
        }
    }
    var totalPrice = String(){
        didSet {
            if totalPriceTrigger == true {
                self.liter = String((Float(totalPrice) ?? 0) / (Float(price) ?? 0))
            }
        }
    }
    var priceTrigger: Bool = false
    var literTrigger: Bool = false
    var totalPriceTrigger: Bool = false
    
    
    init(price: String) {
        self.price = price
    }
    
    func saveData(object: DbModel) {
        RealmManager.shared.save(object: object)
    }
}
