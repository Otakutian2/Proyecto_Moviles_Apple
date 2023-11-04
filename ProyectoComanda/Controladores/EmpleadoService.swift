//
//  EmpleadoService.swift
//  ProyectoComanda
//
//  Created by Gary on 4/11/23.
//

import UIKit
import CoreData

class EmpleadoService: NSObject {
    func obtenerTamano() -> Int {
        let lista = obtenerEmpleados()
        return lista.count
        
    }
    
    func obtenerEmpleados() -> [Empleado] {
        var arreglo: [Empleado] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Empleado> = Empleado.fetchRequest()
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
