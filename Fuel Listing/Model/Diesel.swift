//
//  Diesel.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 3.10.2022.
//

// MARK: - Diesel
struct Diesel: Codable {
    let result: [ResultDiesel]?
    let lastupdate: String?
    let success: Bool?
}

// MARK: - ResultDiesel
struct ResultDiesel: Codable {
    let marka: String?
    let dizel, katkili: Double?
}

