//
//  MesaActualizarViewController.swift
//  ProyectoComanda
//
//  Created by Rodolfo on 5/10/23.
//

import UIKit
import Toaster
import Foundation
import CoreData

class MesaActualizarViewController: UIViewController {
    var mesa : Mesa!
    
    
    @IBOutlet weak var txtAsientos: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtAsientos.text = String(mesa.cantidadAsientos)
    }
    

   
    @IBAction func btnActualizar(_ sender: Any) {
        let asientos = txtAsientos.text!
        
        let validaMesa = "[1-9]"
        let esValido2 = asientos.range(of: validaMesa, options: .regularExpression) != nil
        if esValido2 == false{
            Toast(text: "La cantidad de asientos debe ser un número del 1 al 9").show()
            return
        }
        mesa.cantidadAsientos = Int16(asientos)!
        
        let mesaDTO = MesaDTO(id: Int(mesa.id), estado: mesa.estado!, cantidadAsientos: Int(mesa.cantidadAsientos))
        MesaService().actualizarMesa(mesa: mesa)
        MesaServiceRest().editarMesaRest(mesa: mesaDTO)
        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)

        Toast(text: "Mesa actualizada").show()
        //Con esto volvemos a la pestaña anterior
        self.navigationController?.popViewController(animated: true)
        
        
    }
    @IBAction func btnEliminar(_ sender: Any) {
        let ventana = UIAlertController(title: "Sistema", message: "¿Seguro de eliminar?", preferredStyle: .alert)
        let botonAceptar = UIAlertAction(title: "Sí", style: .default, handler: { acccion in
            if self.mesa.fk_mesa_comanda?.count == 0 {
                if(self.mesa.estado == "Libre"){
                    if(self.mesa.fk_mesa_comanda?.count == 0){
                        let id = Int(self.mesa.id)
                        MesaService().eliminarMesa(mesa: self.mesa)
                        MesaServiceRest().eliminarMesaRest(id: id)
                        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
                        Toast(text: "Mesa eliminada eliminado").show()
                        //VOLVER A LA PESTAÑA ANTERIOR
                        self.navigationController?.popViewController(animated: true)
                    }else {
                        Toast(text: "No se puede eliminar una Mesa que tenga comandas registradas").show()
                    }
                    
                }else {
                    Toast(text: "No se puede eliminar una Mesa con estado ocupado").show()

                }
              
            }else {
                Toast(text: "No se puede eliminar una Mesa con comandas registradas").show()

            }
            
        })
        ventana.addAction(botonAceptar)
        ventana.addAction(UIAlertAction(title: "No", style: .cancel))
        present(ventana, animated: true)
    }
    
}
