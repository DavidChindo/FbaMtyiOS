//
//  RealmManager.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class RealmManager: NSObject {

    class func findFirst<T: Object>(object: T.Type) -> T?{
        let results = try! Realm().objects(object)
        return results.first
    }
    
    class func findPayments<T: Object>(_ object: T.Type, value: String, value1: String)->[T]{
        var results:[T] = []
        let predicate = NSPredicate(format: " dateValidity = %@ AND " + " status = %@ ", value,value1)
        let resultsRealm = try! Realm().objects(object.self).filter(predicate)
        let listResults = List<T>()
        listResults.append(objectsIn: resultsRealm)
        if listResults.count > 0{
            for r in listResults {
                results.append(r)
            }
        }
        
        return results
    }
    
    class func listUnique() -> [String] {
        var datesUnique: [String] = []
    
        let datesValidity = try! Realm().objects(Payments.self)
        
        if (datesValidity.count > 0){
            for d in datesValidity {
                    datesUnique.append(d.dateValidity!)
            }
        }
        
        return datesUnique
    }
    
    class func insert<T: Object>(_ object : T.Type,item: T){
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(item, update: true)
        }
        
        
    }
    
    class func insert<T: Object>(_ object : T.Type,items: [T]){
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(items, update: true)
        }
    }
    
    
    class func token() -> String{
        
        let user = findFirst(object: LoginResponse.self)
        return user != nil ? user!.token! : ""
    }
    
    class func user() -> String{
        
        let user = findFirst(object: LoginResponse.self)
        return user != nil ? user!.username! : ""
    }
    
    class func holdingsName()->[String]{
        
        var names:[String] = []
        if(MenuViewController.holdingResponses.count > 0){
            for holding in MenuViewController.holdingResponses {
                names.append(holding.NombreEdificio!)
            }
        }
        
        return names
    }
    
}
