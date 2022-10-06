//
//  PricesViewModel.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 3.10.2022.
//

import Foundation
import UIKit

class PricesViewModel {
    
    // Selected city
    private var city: String!
    
    // Selected district
    private var district: String!
    
    // Selected fuelType
    var fuelType: String!
    
    var diesel = [ResultDiesel]() {
        didSet {
            reloadTableView?()        }
    }
    private var sortedDiesel = [ResultDiesel]()
    
    var gasoline = [ResultGasoline]() {
        didSet {
            reloadTableView?()
        }
    }
    private var sortedGasoline = [ResultDiesel]()
    
    private var orderFlag: Bool = true
    
    var orderString = "Tap to sort prices"
    var orderIcon: UIImage = UIImage(systemName: "hand.tap.fill")!
    
    // Closure for reload table view
    var reloadTableView: (() -> Void)?
    
    init(city: String, district: String) {
        self.fuelType = "diesel"
        // District,city info coming from CitiesViewController
        self.city = city.localizedLowercase.replaceTurkishChar()
        self.district = district.localizedLowercase.replaceTurkishChar()
    }
    /// Fetch fuel prices from Service
    func fetchPrices(fuelType: String) {
        if fuelType == "diesel" {
            FuelService.shared.fetchPricesDiesel(city: city, district: district) { [weak self] pricesArray in
                if let diesels = pricesArray {
                    self?.diesel = diesels.result ?? []
                }
            }
        } else if fuelType == "gasoline" {
            FuelService.shared.fetchPricesGasoline(city: city, district: district) { [weak self] pricesArray in
                if let gasolines = pricesArray {
                    self?.gasoline = gasolines.result ?? []
                }
            }
        }

    }
    func changeFuelType(fuelType: String) {
        self.fuelType = fuelType
    }
    func parseJson(value: Katkili) -> String {
        switch value {
        case .double(let price):
            return String(format: "%2.2f",price)
        case .string(let price):
            return price
        }
    }
    func sortPrices() {
        if orderFlag == true {
            let sortedDiesel = diesel.sorted { $0.dizel! > $1.dizel! }
            diesel = sortedDiesel
            let sortedGasoline = gasoline.sorted { $0.benzin! > $1.benzin! }
            gasoline = sortedGasoline
            orderFlag = false
            orderString = "descending order"
            orderIcon = UIImage(systemName: "chevron.down")!
            
        } else {
            let sortedDiesel = diesel.sorted { $0.dizel! < $1.dizel! }
            diesel = sortedDiesel
            let sortedGasoline = gasoline.sorted { $0.benzin! < $1.benzin! }
            gasoline = sortedGasoline
            orderFlag = true
            orderString = "ascending order"
            orderIcon = UIImage(systemName: "chevron.up")!
        }
    }
}
extension String {
    func replaceTurkishChar() -> String {
        return self.replacingOccurrences(of: "ç", with: "c")
            .replacingOccurrences(of: "ş", with: "s")
            .replacingOccurrences(of: "ğ", with: "g")
            .replacingOccurrences(of: "ö", with: "o")
            .replacingOccurrences(of: "ü", with: "u")
            .replacingOccurrences(of: "ş", with: "s")
            .replacingOccurrences(of: "ı", with: "i")
    }
}

