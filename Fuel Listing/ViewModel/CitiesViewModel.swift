//
//  CitiesViewModel.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 2.10.2022.
//

import Foundation

final class CitiesViewModel {
    
    var cities = [Result]()
    
    init(){
        fetchDays()
    }
    
    private func fetchDays() {
        FuelService.shared.loadJson(filename: "Cities", completion: { response in
            self.cities = response ?? []
        })
    }
}
