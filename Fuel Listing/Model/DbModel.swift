//
//  DbModel.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 4.10.2022.
//

import Foundation
import RealmSwift

class DbModel: Object {
    
    @Persisted var uuid = String()
    @Persisted var date = String()
    @Persisted var brand = String()
    @Persisted var fuelType = String()
    @Persisted var price = String()
    @Persisted var liter = String()
    @Persisted var totalPrice = String()
    @Persisted var imagePath = String()
}
