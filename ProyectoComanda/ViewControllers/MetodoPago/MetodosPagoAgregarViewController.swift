//
//  MetodosPagoAgregarViewController.swift
//  ProyectoComanda
//
//  Created by Gary on 30/09/23.
//

import UIKit
import Toaster
import Foundation
import CoreData

class MetodosPagoAgregarViewController: UIViewController {

    @IBOutlet weak var txtNombreMet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func volverListadoMetPago(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnNuevoMet(_ sender: Any) {
        let nombre = txtNombreMet.text ?? ""
        let metodo = MetodoPagoDTO(id: 0, nombreMetodoPago: nombre)
        //VALIDACIONES
        if(nombre.isEmpty){
            Toast(text: "El nombre no debe estar vacío").show()
            return
        }
        if(nombre.count < 3){
            Toast(text: "El nombre debe contener 3 letras como mínimo").show()
            return
        }
        //validar el texto en formato oración -> Yape 
        let validaNombre = "^[A-Z][a-z]*$"
        let predicoNombre = NSPredicate(format: "SELF MATCHES %@", validaNombre)
        if predicoNombre.evaluate(with: nombre) == false {
            Toast(text: "El nombre debe empezar con mayúscula y no debe contener espacios").show()
            return
        }
        //VALIDAR QUE NO SE REPITA EL NOMBRE
        let lista = MetodoPagoService().listadoMetodos()
        for metodoValida in lista {
            if(metodoValida.nombreMetodoPago!.contains(nombre)){
                Toast(text: "El nombre del método de pago se repite").show()
                return
            }
        }
        //registrar 
        MetodoPagoService().registrarMetodoPago(metodo: metodo)
        Toast(text: "Método registrado").show()
        //hacer que llamemos a la notificación creada para refrescar la lista
        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
        //volver a la pestaña anterior
        self.navigationController?.popViewController(animated: true)

        
        
    }
    
}
