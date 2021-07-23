//
//  Persistance.swift
//  ContactBook
//
//  Created by Виталий Крюков on 23.07.2021.
//

import Foundation
import RealmSwift


class Contacts: Object{
    
    @objc dynamic var phoneNumber:String = ""
}

class PersistanceContact {
    
    
    var arrayPhone = [Contacts().phoneNumber]
    
    var allData: Results<Contacts> {
        let realm = try! Realm()
        return realm.objects(Contacts.self)
    }
    
    
    let realm = try! Realm()

    func addRealm(addName:String) {
        let add = Contacts()
        add.phoneNumber = addName

        try! realm.write{
            realm.add(add)
        }
    }

    func loadRealm() {
        
        arrayPhone = []

        let allRealm = realm.objects(Contacts.self)
    
        for note in allRealm {
            arrayPhone.append(note.phoneNumber)
        }
    }
        
    func deleteRealm(delete: Contacts) {
        try! realm.write{
            realm.delete(delete)
        }
    }
}
