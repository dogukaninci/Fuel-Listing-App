//
//  PurchasesListViewModel.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 4.10.2022.
//

import Foundation
import RealmSwift

final class PurchasesListViewModel {
    
    private var savedData: Results<DbModel>!
    
    var savedDataArray = [DbModel]()
    
    func readData() {
        savedData = RealmManager.shared.read()
        parser()
    }
    private func parser() {
        for data in savedData {
            savedDataArray.append(data)
        }
    }
}
