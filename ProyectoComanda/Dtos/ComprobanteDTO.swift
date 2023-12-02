//
//  ComprobanteDTO.swift
//  ProyectoComanda
//
//  Created by Sebastian on 23/11/23.
//

import UIKit

struct ComprobanteDTO  {
    
        var id: Int16
       var fechaEmision: String?
       var precioTotalPedido: Double
       var igv: Double
       var subTotal: Double
       var descuento: Double
       var nombreCliente: String?
       var fk_CDP_tipocdp: TipoComprobante?
       var fk_cdp_caja: Caja?
       var fk_cdp_comanda: Comanda?
       var fk_cdp_metodo: MetodoPago?
       var fk_cdp_empleado: Empleado?
}
