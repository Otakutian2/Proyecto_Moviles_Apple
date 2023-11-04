//
//  UsuarioService.swift
//  ProyectoComanda
//
//  Created by Gary on 4/11/23.
//

import UIKit

class UsuarioService: NSObject {
    func obtenerTamaño() -> Int {
        let lista = obtenerUsuarios()
        return lista.count
        
    }
    
    func obtenerUsuarios() -> [Usuario] {
        var arreglo: [Usuario] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = Usuario.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }

}
