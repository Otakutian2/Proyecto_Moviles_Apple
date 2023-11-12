//
//  MesaAgregarViewController.swift
//  ProyectoComanda
//
//  Created by Rodolfo on 5/10/23.
//

import UIKit
import Toaster
import Foundation
import CoreData

class MesaAgregarViewController: UIViewController {

    @IBOutlet weak var txtCantidad: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAgregar(_ sender: Any) {
        let asientos = txtCantidad.text!
        
        let validaMesa = "[1-9]"
        let esValido2 = asientos.range(of: validaMesa, options: .regularExpression) != nil
        if esValido2 == false{
            Toast(text: "La cantidad de asientos debe ser un número del 1 al 9").show()
            return
        }
            
        var mesa = MesaDTO(id: 0, estado: "Libre", cantidadAsientos: Int(asientos)!)
        let idRest = MesaService().obtenerUltimoID()
        mesa.id = idRest
        MesaService().registrarMesa(mesa: mesa)
        MesaServiceRest().registrarMesaRest(mesa: mesa)
        
        
        Toast(text: "Mesa registrada").show()
        //hacer que llamemos a la notificación creada para refrescar la lista
        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
        //volver a la pestaña anterior
        self.navigationController?.popViewController(animated: true)
    }
    

}
