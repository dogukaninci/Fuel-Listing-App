//
//  DateManager.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 5.10.2022.
//

import Foundation
class DateManager {
    
    // Singleton
    static let shared = DateManager()
    
    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "us")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date.now)
    }
}
