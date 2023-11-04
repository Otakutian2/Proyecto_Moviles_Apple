//
//  UsuarioService.swift
//  ProyectoComanda
//
//  Created by Gary on 4/11/23.
//

import UIKit
import CoreData

class UsuarioService: NSObject {
    func obtenerTamano() -> Int {
        let lista = obtenerUsuarios()
        return lista.count
        
    }
    
    func obtenerUsuarios() -> [Usuario] {
        var arreglo: [Usuario] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Usuario> = Usuario.fetchRequest()
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
