//
//  RealmManager.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 4.10.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    
    // Singleton
    static let shared = RealmManager()
    
    let realm = try! Realm()
    
    func save(object: DbModel) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("An error occurred while saving the category: \(error)")
        }
    }
    func read() -> Results<DbModel>{
        return realm.objects(DbModel.self)
        
    }
}
