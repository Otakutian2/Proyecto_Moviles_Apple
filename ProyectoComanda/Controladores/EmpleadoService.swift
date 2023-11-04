//
//  EmpleadoService.swift
//  ProyectoComanda
//
//  Created by Gary on 4/11/23.
//

import UIKit

class EmpleadoService: NSObject {
    func obtenerTamaño() -> Int {
        let lista = obtenerEmpleados()
        return lista.count
        
    }
    
    func obtenerEmpleados() -> [Empleado] {
        var arreglo: [Empleado] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = Empleado.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }

}
