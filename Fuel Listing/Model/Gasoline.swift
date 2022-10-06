//
//  Gasoline.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 3.10.2022.
//
import Foundation

// MARK: - Gasoline
struct Gasoline: Codable {
    let result: [ResultGasoline]?
    let lastupdate: String?
    let success: Bool?
}

// MARK: - ResultGasoline
struct ResultGasoline: Codable {
    let marka: String?
    let benzin: Double?
    let katkili: Katkili?
}

enum Katkili: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Katkili.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Katkili"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

