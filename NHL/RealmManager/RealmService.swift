//
//  RealmService.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 19.01.2022.
//

import UIKit
import RealmSwift

final class RealmService {
    
    // MARK: - Public Properties
    
    static let shared = RealmService()
    public let realm = try! Realm()
    
    // MARK: - Initializers
    
    private init() { }
    
    // MARK: - Public Methods
    
    func create<T: Object>(_ object: T, completion: @escaping () -> Void) {
        do {
            try realm.write {
                realm.add(object)
                completion()
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func get<Element: Object>(_ type: Element.Type) -> Results<Element> {
        let objects = realm.objects(type)
        return objects
    }
    
    func update(_ block: () -> Void) {
        do {
            try realm.write {
                block()
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}
