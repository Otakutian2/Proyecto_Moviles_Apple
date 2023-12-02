//
//  CambiarDetallePlatoViewController.swift
//  ProyectoComanda
//
//  Created by Sebastian on 30/11/23.
//

import UIKit
import DropDown
import Toaster

class CambiarDetallePlatoViewController: UIViewController {

    @IBOutlet weak var btnCategoria: UIButton!
    
    @IBOutlet weak var btnPlato: UIButton!
    
    @IBOutlet weak var txtCantidad: UITextField!
    
    @IBOutlet weak var txtObservacion: UITextView!
    
    var comboCategoria = DropDown()
    var comboPlato = DropDown()
    var idCat = "Seleccionar"
    var idPlato = "Seleccionar"
    
    var detalleComanda: DetalleComanda!
    var detalleTemporalModificado: DetalleComandaDTO?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtCantidad.text = String((detalleComanda?.cantidadPedido)!)
        txtObservacion.text = detalleComanda?.observacion
        
        btnCategoria.setTitle(String((detalleComanda?.fk_detalle_plato?.fk_plato_categoria?.categoria)!), for: .normal)
        btnPlato.setTitle(String((detalleComanda?.fk_detalle_plato?.nombre)!), for: .normal)

        
        
    }
    
    @IBAction func btnMinimizar(_ sender: Any) {
        
        dismiss(animated: true,completion: nil)
    }
    
    
    @IBAction func btnCambiarDetalle(_ sender: Any) {
    
            let cantidad = txtCantidad.text!
            let observacion = txtObservacion.text!
            let nombrePlato = detalleComanda?.fk_detalle_plato?.nombre
            let comandaDetalleId = detalleComanda?.fk_detalle_comanda?.id
      

        let platoSeleccionado = PlatoService().obtenerPlato(nombre: nombrePlato!)
        let comandaDetalle = ComandaService().obtenerComandaPorId(id: Int16(comandaDetalleId!))
        
        detalleComanda?.cantidadPedido  = Int16(cantidad)!
        detalleComanda?.observacion = observacion
        detalleComanda?.fk_detalle_plato? = platoSeleccionado!
        detalleComanda?.fk_detalle_comanda = comandaDetalle!
       
        DetaleComandaService().actualizarDetalleComanda(detalle: detalleComanda)
        NotificationCenter.default.post(name: Notification.Name("load2"), object: nil)


        // Cierra la vista actual
        dismiss(animated: true, completion: nil)
    }


                                                      
}
