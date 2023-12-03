//
//  UsuarioService.swift
//  ProyectoComanda
//
//  Created by Gary on 4/11/23.
//

import UIKit
import CoreData
import Toaster

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
    
    func obtenerUsuarioPorCorreo(correo: String)-> Usuario? {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "correo == %@", correo)
        do {
            let usuario = try bd.fetch(fetchRequest)
            return usuario.first
        } catch let ex as NSError{
            print(ex.localizedDescription)
            return nil
        }
    }
    
    func login(correo: String, password: String) -> Bool {
        
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<Usuario>(entityName: "Usuario")
        
        let condicion1 = NSPredicate(format: "correo == %@", correo)
        let condicion2 = NSPredicate(format: "contrasena == %@", password)
        
        let unir = NSCompoundPredicate(andPredicateWithSubpredicates: [condicion1,condicion2])
        
        fetchRequest.predicate = unir
        
        do {
                let usuarios = try bd.fetch(fetchRequest)
                
                guard let usuario = usuarios.first else {
                    return false
                }
                
            if usuario.contrasena == password, let empleado = usuario.fk_usuario_empleado {
                    // Guardar el empleado en la sesión
                    let empleadoDTO = EmpleadoDTO(
                        id: Int(empleado.id),
                        nombre: empleado.nombre ?? "",
                        apellido: empleado.apellido ?? "",
                        telefono: empleado.telefono ?? "",
                        dni: empleado.dni ?? "",
                        fechaRegistro: empleado.fechaRegistro ?? "",
                        Usuario: usuario,
                        Cargo: empleado.fk_empleado_cargo ?? Cargo() // Use ?? to provide a default Cargo if it's nil
                    )
                    
                    SessionManager.shared.currentEmpleado = empleadoDTO
                
                
                    
                    return true
                } else {
                    return false
                }
            } catch {
        
            print("Error al recuperar datos de inicio de sesi∫n: \(error)")
            return false
        }
        
    }
    
    func cambiarContrasena(correo: String, nuevaContraseña: String, confirmarNuevaContraseña: String) -> Bool {
        // Validar que los campos no estén vacíos
        guard !correo.isEmpty, !nuevaContraseña.isEmpty, !confirmarNuevaContraseña.isEmpty else {
            Toast(text: "Todos los campos son obligatorios").show()
            return false
        }

        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Usuario>(entityName: "Usuario")
        fetchRequest.predicate = NSPredicate(format: "correo == %@", correo)

        do {
            let usuarios = try bd.fetch(fetchRequest)

            guard let usuario = usuarios.first else {
                // El correo no existe en la base de datos
                Toast(text: "Correo no encontrado").show()
                return false
            }

            // Verificar que la nueva contraseña coincida con la confirmación
            guard nuevaContraseña == confirmarNuevaContraseña else {
                // La nueva contraseña y la confirmación no coinciden
                Toast(text: "La nueva contraseña y la confirmación no coinciden").show()
                return false
            }

            // Actualizar la contraseña
            usuario.contrasena = nuevaContraseña

            // Guardar los cambios en Core Data
            try bd.save()

            Toast(text: "Contraseña cambiada exitosamente").show()
            return true
        } catch {
            print("Error al cambiar la contraseña: \(error.localizedDescription)")
            return false
        }
    }



}
