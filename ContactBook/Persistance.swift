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
    @objc dynamic var name:String = ""
}

class PersistanceContact {
    
    
    var arrayPhone = [Contacts().phoneNumber]
    var arrayName = [Contacts().name]
    
    
    var allData: Results<Contacts> {
        let realm = try! Realm()
        return realm.objects(Contacts.self)
    }
    
    
    let realm = try! Realm()

    func addRealm(addNumber:String, addName: String) {
        let add = Contacts()
        add.name = addName
        add.phoneNumber = addNumber

        try! realm.write{
            realm.add(add)
        }
    }

    func loadRealm() {
        
        arrayPhone = []
        arrayName = []

        let allRealm = realm.objects(Contacts.self)
    
        for note in allRealm {
            arrayPhone.append(note.phoneNumber)
            arrayName.append(note.name)
        }
    }
        
    func deleteRealm(delete: Contacts) {
        try! realm.write{
            realm.delete(delete)
        }
    }
}
