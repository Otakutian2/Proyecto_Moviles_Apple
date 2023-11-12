//
//  MesaService.swift
//  ProyectoComanda
//
//  Created by Gary on 11/11/23.
//

import UIKit
import CoreData

class MesaService: NSObject {
    func obtenerUltimoID() -> Int {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Mesa")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        do{
            let resultados = try bd.fetch(fetchRequest)
            if let ultimoRegistro = resultados.first as? Mesa {
                return Int(ultimoRegistro.id) + 1
            }
            
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        return 1
    }
    func listadoMesa() -> [Mesa] {
        var arreglo: [Mesa] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = Mesa.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }
    
    func registrarMesa(mesa: MesaDTO){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        //POR SI ACASO INSTANCIAR ENTIDAD
        let tabla = Mesa(context: bd)
        do{
            tabla.id = Int16(obtenerUltimoID())
            tabla.cantidadAsientos = Int16(mesa.cantidadAsientos)
            tabla.estado = mesa.estado
            try bd.save()
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    func actualizarMesa(mesa: Mesa){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    func eliminarMesa(mesa: Mesa){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            bd.delete(mesa)
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }


}
