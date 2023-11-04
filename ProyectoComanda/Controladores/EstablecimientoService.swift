//
//  EstablecimientoService.swift
//  ProyectoComanda
//
//  Created by Gary on 4/11/23.
//

import UIKit
import CoreData

class EstablecimientoService: NSObject {
    func obtenerEstablecimiento() -> Establecimiento? {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Establecimiento> = Establecimiento.fetchRequest()
        do {
            let resultado = try bd.fetch(fetchRequest)
            if let primer = resultado.first{
                return primer
            }else {
                return nil
            }
        } catch let ex as NSError {
            print(ex.localizedDescription)
            return nil
        }
    }
    
    func obtenerTamano() -> Int {
        var arreglo: [Establecimiento] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = Establecimiento.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo.count
    }
    
    func actualizarEstablecimiento(establecimiento : Establecimiento){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }

}
