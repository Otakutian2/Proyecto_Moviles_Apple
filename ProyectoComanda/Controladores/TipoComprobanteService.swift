//
//  TipoComprobanteService.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//

import UIKit
import CoreData

class TipoComprobanteService: NSObject {
    func obtenerTamano() -> Int {
        let lista = obtenerTipos()
        return lista.count
        
    }
    
    func obtenerTipos() -> [TipoComprobante] {
        var arreglo: [TipoComprobante] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TipoComprobante> = TipoComprobante.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do{
            arreglo = try bd.fetch(fetchRequest)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }
    
    func obtenerTipo(nombre: String) -> TipoComprobante? {
           let delegate = UIApplication.shared.delegate as! AppDelegate
           let bd = delegate.persistentContainer.viewContext

           let fetchRequest: NSFetchRequest<TipoComprobante> = TipoComprobante.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "tipo == %@", nombre)

           do {
               let tc = try bd.fetch(fetchRequest)
               return tc.first
           } catch let error as NSError {
               print(error.localizedDescription)
               return nil
           }
       }

}
