//
//  CargoService.swift
//  ProyectoComanda
//
//  Created by Gary on 4/11/23.
//

import UIKit

class CargoService: NSObject {
    func obtenerTamaño() -> Int {
        let lista = obtenerCargos()
        return lista.count
        
    }
    
    func obtenerCargos() -> [Cargo] {
        var arreglo: [Cargo] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = Cargo.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }

}
