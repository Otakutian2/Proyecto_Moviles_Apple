//
//  TipoComprobanteService.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//

import UIKit

class TipoComprobanteService: NSObject {
    func obtenerTamaño() -> Int {
        let lista = obtenerTipos()
        return lista.count
        
    }
    
    func obtenerTipos() -> [TipoComprobante] {
        var arreglo: [TipoComprobante] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = TipoComprobante.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }

}
