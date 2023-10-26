//
//  CategoriaAgregarViewController.swift
//  ProyectoComanda
//
//  Created by Rodolfo on 5/10/23.
//

import UIKit
import Toaster
import Foundation
import CoreData

class CategoriaAgregarViewController: UIViewController {
    
    
    @IBOutlet weak var txtNombre: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


    @IBAction func btnAgregar(_ sender: Any) {
        let nombre = txtNombre.text ?? ""
        let cat = CategoriaPlatoDTO(id: 0, categoria: nombre)
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
        let lista = CategoriaService().listadoCategorias()
        for catValida in lista {
            if(catValida.categoria!.contains(nombre)){
                Toast(text: "El nombre de la categoría se repite").show()
                return
            }
        }
        //registrar
        CategoriaService().registrarCategoria(cat: cat)
        Toast(text: "Categoría registrada").show()
        //hacer que llamemos a la notificación creada para refrescar la lista
        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
        //volver a la pestaña anterior
        self.navigationController?.popViewController(animated: true)

        
    }
}
