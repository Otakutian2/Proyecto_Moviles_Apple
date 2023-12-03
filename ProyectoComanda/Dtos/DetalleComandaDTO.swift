//
//  DetalleComandaDTO.swift
//  ProyectoComanda
//
//  Created by Sebastian on 23/11/23.
//

import UIKit

struct DetalleComandaDTO {
    
    var id:Int
    var cantidadPedido:Int
    var precioUnitario:Double
    var obsevacion:String
    
    var plato:Plato
    var comanda:Comanda?

    
}

protocol DetalleComandaDelegate: AnyObject {
    func didUpdateDetallesComanda()
}

class SessionManagerDetalle {
    static let shared = SessionManagerDetalle()

    var detallesComandaTemporales: [DetalleComandaDTO] = []
    var comandaActual: Comanda?

    private init() {}
    
    func agregarDetalleComandaTemporal(detalle: DetalleComandaDTO) {
        detallesComandaTemporales.append(detalle)
    }

    func obtenerDetallesComandaTemporales() -> [DetalleComandaDTO] {
        return detallesComandaTemporales
    }
    
    func actualizarDetallesComandaTemporales(nuevosDetalles: [DetalleComandaDTO]) {
            detallesComandaTemporales = nuevosDetalles
        }

    func limpiarDetallesComandaTemporales() {
           detallesComandaTemporales.removeAll()
       }
}
