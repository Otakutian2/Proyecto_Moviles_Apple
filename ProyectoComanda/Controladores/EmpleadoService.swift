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
    
    func obtenerUltimoID() -> Int {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Empleado")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        do{
            let resultados = try bd.fetch(fetchRequest)
            if let ultimoRegistro = resultados.first as? Empleado {
                return Int(ultimoRegistro.id) + 1
            }
            
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        return 1
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
    
    func registrarEmpleado(empleado: EmpleadoDTO){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        //POR SI ACASO INSTANCIAR ENTIDAD
        let tabla = Empleado(context: bd)
        do{
            tabla.id = Int16(obtenerUltimoID())
            tabla.nombre = empleado.nombre
            tabla.telefono = empleado.telefono
            tabla.dni = empleado.dni
            tabla.apellido = empleado.apellido
            tabla.fechaRegistro = empleado.fechaRegistro
            tabla.fk_empleado_usuario = empleado.Usuario
            tabla.fk_empleado_cargo = empleado.Cargo
            try bd.save()
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    func actualizarEmpleado(empleado: Empleado){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    func eliminarEmpleado(empleado: Empleado){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            bd.delete(empleado)
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    
    func validarDNIExistente(dni: String,idEmpleado: Int) -> Bool {
        let empleados = obtenerEmpleados()
        for empleado in empleados {

            if idEmpleado == 0 {
                if empleado.dni == dni {
                    return true
                }

            }else{
                if empleado.dni == dni && Int(empleado.id) != idEmpleado {
                    return true
                }
            }
         
        }
        return false
    }

    func validarCorreoExistente(correo: String,idEmpleado: Int) -> Bool {
        let empleados = obtenerEmpleados()
        for empleado in empleados {
            print( idEmpleado,empleado.id)
                if idEmpleado == 0 {
                    
                    if empleado.fk_empleado_usuario?.correo == correo {
                        
                        return true
                    }
        
                }else{
                
                    if empleado.fk_empleado_usuario?.correo == correo && Int(empleado.id) != idEmpleado {
                       
                        return true
                    }
                    
                }
        }
        return false
    }

}
