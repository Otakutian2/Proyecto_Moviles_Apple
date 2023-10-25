//
//  MetodosPagoActualizarViewController.swift
//  ProyectoComanda
//
//  Created by Gary on 30/09/23.
//

import UIKit
import Toaster

class MetodosPagoActualizarViewController: UIViewController {

    @IBOutlet weak var txtNombreMet: UITextField!
    //VARIABLE QUE RECIBIMOS EN EL SUEGUE
    var metodo: MetodoPago!
    override func viewDidLoad() {
        super.viewDidLoad()
        //AQUÍ COLOCAMOS LOS VALORES
        txtNombreMet.text = metodo.nombreMetodoPago

    }
    
    @IBAction func btnActualizarMet(_ sender: Any) {
        let nombre = txtNombreMet.text ?? ""
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
            if(metodoValida.nombreMetodoPago!.contains(nombre) && metodoValida.id != metodo.id){
                Toast(text: "El nombre del método de pago se repite").show()
                return
            }
        }
        metodo.nombreMetodoPago = nombre
        MetodoPagoService().actualizarMetodo(metodo: metodo)
        Toast(text: "Método actualizado").show()
        //Con esto volvemos a la pestaña anterior
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnEliminarMet(_ sender: Any) {
        let ventana = UIAlertController(title: "Sistema", message: "¿Seguro de eliminar?", preferredStyle: .alert)
        let botonAceptar = UIAlertAction(title: "Sí", style: .default, handler: { acccion in
            MetodoPagoService().eliminarMetodo(metodo: self.metodo)
            NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
            Toast(text: "Método eliminado").show()
            //VOLVER A LA PESTAÑA ANTERIOR
            self.navigationController?.popViewController(animated: true)
        })
        ventana.addAction(botonAceptar)
        ventana.addAction(UIAlertAction(title: "No", style: .cancel))
        present(ventana, animated: true)
        
    }
    

}
