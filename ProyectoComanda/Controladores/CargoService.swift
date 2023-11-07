//
//  CargoService.swift
//  ProyectoComanda
//
//  Created by Gary on 4/11/23.
//

import UIKit
import CoreData

class CargoService: NSObject {
    func obtenerTamano() -> Int {
        let lista = obtenerCargos()
        return lista.count
        
    }
    
    func obtenerCargos() -> [Cargo] {
        var arreglo: [Cargo] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cargo> = Cargo.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do{
            arreglo = try bd.fetch(fetchRequest)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }
    func obtenerCargoPorId(id: Int16)-> Cargo? {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cargo> = Cargo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let cargo = try bd.fetch(fetchRequest)
            return cargo.first
        } catch let ex as NSError{
            print(ex.localizedDescription)
            return nil
        }
    }

}
