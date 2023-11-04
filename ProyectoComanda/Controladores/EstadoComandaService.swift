//
//  EstadoComandaService.swift
//  ProyectoComanda
//
//  Created by Gary on 4/11/23.
//

import UIKit

class EstadoComandaService: NSObject {
    func obtenerTamaño() -> Int {
        let lista = obtenerEstados()
        return lista.count
        
    }
    
    func obtenerEstados() -> [EstadoComanda] {
        var arreglo: [EstadoComanda] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = EstadoComanda.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }
}
