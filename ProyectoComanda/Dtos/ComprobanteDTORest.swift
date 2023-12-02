//
//  ComprobanteDTORest.swift
//  ProyectoComanda
//
//  Created by Gary on 2/12/23.
//

import UIKit

struct ComprobanteDTORest: Codable {
    
    
    var id: Int16
    var fechaEmision: String?
    var precioTotalPedido: Double
    var igv: Double
    var subTotal: Double
    var descuento: Double
    var nombreCliente: String?
    var metodoPago: MetodoPagoDTO
    var tipoComprobante: TipoComprobanteDTO
    var empleado: EmpleadoDTOREST
    var comanda : ComandaDTORest
    var caja : CajaDTO
    
    
    

}
