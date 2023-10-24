//
//  MetodoPagoService.swift
//  ProyectoComanda
//
//  Created by Gary on 23/10/23.
//

import UIKit

class MetodoPagoService: NSObject {
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
            tabla.id = Int16(metodo.id)
            tabla.nombreMetodoPago = metodo.nombreMetodoPago
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }

}
