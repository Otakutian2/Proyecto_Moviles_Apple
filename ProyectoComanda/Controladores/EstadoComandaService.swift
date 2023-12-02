//
//  EstadoComandaService.swift
//  ProyectoComanda
//
//  Created by Gary on 4/11/23.
//

import UIKit
import CoreData

class EstadoComandaService: NSObject {
    
    func obtenerTamano() -> Int {
        let lista = obtenerEstados()
        return lista.count
        
    }
    
    func obtenerEstados() -> [EstadoComanda] {
        var arreglo: [EstadoComanda] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EstadoComanda> = EstadoComanda.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do{
            arreglo = try bd.fetch(fetchRequest)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }
    
    
    
    
    
    
   
}
