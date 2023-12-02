//
//  DatosComprobanteViewController.swift
//  ProyectoComanda
//
//  Created by Sebastian on 1/12/23.
//

import UIKit

class DatosComprobanteViewController: UIViewController {
    
    
    @IBOutlet weak var lblIdComprobante: UILabel!
    
    @IBOutlet weak var lblCliente: UILabel!
    
    @IBOutlet weak var lblFecha: UILabel!
    
    @IBOutlet weak var lblTotalPedido: UILabel!
    
    @IBOutlet weak var lblIdCaja: UILabel!
    
    @IBOutlet weak var lblTipoComprobante: UILabel!
    
    @IBOutlet weak var lblEmpleado: UILabel!
    
    @IBOutlet weak var lblIdComanda: UILabel!
    
    @IBOutlet weak var lblMetodoPAgo: UILabel!
    
    @IBOutlet weak var lblIgv: UILabel!
    
    
    @IBOutlet weak var lblSubtotal: UILabel!
    
    
    @IBOutlet weak var lblDescuento: UILabel!
    
    var comprobante : Comprobante!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cargarDatos()
    }
    
    func cargarDatos(){
        guard let comprobante = comprobante else {
                // Manejar el caso en que comprobante sea nulo
                return
            }

            let idComprobante = comprobante.id
            let nomCliente = comprobante.nombreCliente ?? ""
            let fechaEmision = comprobante.fechaEmision ?? ""
            let precioTotalPedido = String(comprobante.precioTotalPedido)
            let idCaja = String(comprobante.fk_cdp_caja?.id ?? 0)
            let tipoComprobante = comprobante.fk_CDP_tipocdp?.tipo ?? ""
            let empleado = comprobante.fk_cdp_empleado?.nombre ?? ""
            let idComanda = String(comprobante.fk_cdp_comanda?.id ?? 0)
            let metodoPago = comprobante.fk_cdp_metodo?.nombreMetodoPago ?? ""
            let igv = String(comprobante.igv)
            let subTotal = String(comprobante.subTotal)
            let descuento = String(comprobante.descuento)

            lblIdComprobante.text = String(idComprobante)
            lblCliente.text = nomCliente
            lblFecha.text = fechaEmision
            lblTotalPedido.text = precioTotalPedido
            lblIdCaja.text = idCaja
            lblTipoComprobante.text = tipoComprobante
            lblEmpleado.text = empleado
            lblIdComanda.text = idComanda
            lblMetodoPAgo.text = metodoPago
            lblIgv.text = igv
            lblSubtotal.text = subTotal
            lblDescuento.text = descuento
        

        
    }
    


}
