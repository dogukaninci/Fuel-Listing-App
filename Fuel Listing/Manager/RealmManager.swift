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
    func update(object: DbModel) {
        let result = realm.objects(DbModel.self).filter("uuid == %@", object.uuid).first
        do {
            try realm.write {
                result?.price = object.price
                result?.liter = object.liter
                result?.totalPrice = object.totalPrice
            }
        } catch {
            print("An error occurred while saving the category: \(error)")
        }
    }
}
