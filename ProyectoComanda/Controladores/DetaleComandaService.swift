//
//  DetaleComandaService.swift
//  ProyectoComanda
//
//  Created by Sebastian on 26/11/23.
//

import UIKit
import CoreData

class DetaleComandaService: NSObject {
    
    
    func obtenerUltimoID() -> Int {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DetalleComanda")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        do{
            let resultados = try bd.fetch(fetchRequest)
            if let ultimoRegistro = resultados.first as? DetalleComanda {
                return Int(ultimoRegistro.id) + 1
            }
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        return 1
    }
    
    
    func listaDetalle() -> [DetalleComanda] {
        var arreglo: [DetalleComanda] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = DetalleComanda.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }
    
    func listaDetallePorComanda(idComanda: Int16) -> [DetalleComanda] {
        var arreglo: [DetalleComanda] = []
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        
        do {
            let request = DetalleComanda.fetchRequest()
            request.predicate = NSPredicate(format: "fk_detalle_comanda.id == %@", NSNumber(value: idComanda))
            
            arreglo = try bd.fetch(request)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return arreglo
    }
    
    func obtenerDetalleComandaporId(id: Int16)-> DetalleComanda? {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DetalleComanda> = DetalleComanda.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let detalleComanda = try bd.fetch(fetchRequest)
            return detalleComanda.first
        } catch let ex as NSError{
            print(ex.localizedDescription)
            return nil
        }
    }
    
    func actualizarDetalleComanda(detalle: DetalleComanda){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    
    

    

    
    
    
}
