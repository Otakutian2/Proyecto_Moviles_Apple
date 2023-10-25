//
//  MetodoPagoService.swift
//  ProyectoComanda
//
//  Created by Gary on 23/10/23.
//

import UIKit
import CoreData

class MetodoPagoService: NSObject {
    func obtenerUltimoID() -> Int {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MetodoPago")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        do{
            let resultados = try bd.fetch(fetchRequest)
            if let ultimoRegistro = resultados.first as? MetodoPago {
                return Int(ultimoRegistro.id) + 1
            }
            
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        return 1
    }
    func listadoMetodos() -> [MetodoPago] {
        var arreglo: [MetodoPago] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = MetodoPago.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }
    
    func registrarMetodoPago(metodo: MetodoPagoDTO){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        //POR SI ACASO INSTANCIAR ENTIDAD
        let tabla = MetodoPago(context: bd)
        do{
            tabla.id = Int16(obtenerUltimoID())
            tabla.nombreMetodoPago = metodo.nombreMetodoPago
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    func actualizarMetodo(metodo: MetodoPago){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    func eliminarMetodo(metodo: MetodoPago){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            bd.delete(metodo)
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }

}
