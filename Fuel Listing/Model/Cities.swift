//
//  City.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 2.10.2022.
//

import Foundation

// MARK: - Cities
struct Cities: Codable {
    let result: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let city: String?
    let districts: [District]?
}

// MARK: - City
struct District: Codable {
    let name: String?
}
