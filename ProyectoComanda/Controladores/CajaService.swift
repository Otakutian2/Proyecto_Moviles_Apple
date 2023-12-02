//
//  CajaService.swift
//  ProyectoComanda
//
//  Created by Gary on 11/11/23.
//

import UIKit
import CoreData

class CajaService: NSObject {
    func obtenerCaja() -> Caja? {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Caja> = Caja.fetchRequest()
        do {
            let resultado = try bd.fetch(fetchRequest)
            if let primer = resultado.first{
                return primer
            }else {
                return nil
            }
        } catch let ex as NSError {
            print(ex.localizedDescription)
            return nil
        }
    }
    
    func obtenerTamano() -> Int {
        var arreglo: [Caja] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = Caja.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo.count
    }
    
    func actualizarCaja(Caja : Caja){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    func listadoCaja() -> [Caja] {
        var arreglo: [Caja] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = Caja.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }
    
    func obtenerCajaporId(id: Int16)-> Caja? {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Caja> = Caja.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let mesa = try bd.fetch(fetchRequest)
            return mesa.first
        } catch let ex as NSError{
            print(ex.localizedDescription)
            return nil
        }
    }

}
