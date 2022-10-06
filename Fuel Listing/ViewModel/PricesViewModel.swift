//
//  PricesViewModel.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 3.10.2022.
//

import Foundation

class PricesViewModel {
    
    // Selected city
    private var city: String!
    
    // Selected district
    private var district: String!
    
    // Selected fuelType
    var fuelType: String!
    
    var diesel = [ResultDiesel]() {
        didSet {
            reloadTableView?()
        }
    }
    var gasoline = [ResultGasoline]() {
        didSet {
            reloadTableView?()
        }
    }
    
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

