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
    func obtenerUltimoID() -> Int {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        do{
            let resultados = try bd.fetch(fetchRequest)
            if let ultimoRegistro = resultados.first as? Usuario {
                return Int(ultimoRegistro.id) + 1
            }
            
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        return 1
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
    
    func registrarUsuario(usuario : UsuarioDTO){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        //POR SI ACASO INSTANCIAR ENTIDAD
        let tabla = Usuario(context: bd)
        do{
            tabla.id = Int16(obtenerUltimoID())
            tabla.contrasena = usuario.contrasena
            tabla.correo = usuario.correo
            try bd.save()
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    func actualizarUsuario(usuario: Usuario){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    func eliminarUsuario(usuario: Usuario){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            bd.delete(usuario)
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    func obtenerUsuarioPorId(id: Int16)-> Usuario? {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let usuario = try bd.fetch(fetchRequest)
            return usuario.first
        } catch let ex as NSError{
            print(ex.localizedDescription)
            return nil
        }
    }

}
