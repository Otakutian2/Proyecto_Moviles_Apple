//
//  PlatoAgregarViewController.swift
//  ProyectoComanda
//
//  Created by Rodolfo on 18/10/23.
//

import UIKit
import Toaster
import Foundation
import CoreData
import DropDown

class PlatoAgregarViewController: UIViewController {

    @IBOutlet weak var botonAgregar: UIButton!
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtPrecio: UITextField!
    
    var combo = DropDown()
    var idCat = "Seleccionar"
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func seleccionarCategoria(_ sender: UIButton) {
        let listaCat = CategoriaService().listadoCategorias()
        if(listaCat.count == 0){
            let categoriasStrings : [String] = ["No hay categorías"]
            combo.dataSource = categoriasStrings
            botonAgregar.isEnabled = false
            Toast(text: "No se puede registrar, no hay categorías").show()
        }else{
            botonAgregar.isEnabled = true
            var categoriasStrings : [String] = ["Seleccionar"]
            for categoria in listaCat {
                categoriasStrings.append(categoria.categoria!)
            }
            combo.dataSource = categoriasStrings
           
            combo.dataSource = categoriasStrings
            sender.setTitle(categoriasStrings[0], for: .normal)
        }
        combo.anchorView = sender
        combo.bottomOffset = CGPoint(x: 0, y: (combo.anchorView?.plainView.bounds.height)!)
        combo.show()
        combo.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            idCat = item
        }
    }
    

        
    @IBAction func btnAgregar(_ sender: Any) {
        let nombre = txtNombre.text!
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
        let lista = PlatoService().listadoPlatos()
        for platoValida in lista {
            if(platoValida.nombre!.contains(nombre)){
                Toast(text: "El nombre del plato se repite").show()
                return
            }
        }
        if let precio = txtPrecio.text, precio.isEmpty {
            Toast(text: "Debes ingresar el precio del plato").show()
            return
        }
        if let precio = txtPrecio.text, !(Double(precio) != nil) {
            Toast(text: "Debes ingresar un número en el precio").show()
            return
        }
        
        if idCat == "Seleccionar" {
            Toast(text: "Debes seleccionar una categoría").show()
            return
        }
        let precio = Double(txtPrecio.text!)
        
        let categoriaObtenida = CategoriaService().obtenerCategoriaPorNombre(nombre: idCat)
        
        let plato = PlatoDTO(id: 0, nombre: nombre, precioPlato: precio!, categoria: categoriaObtenida!)
        
        let categoriaRest = CategoriaPlatoDTO(id: Int(categoriaObtenida!.id),categoria: categoriaObtenida!.categoria!)
        
        print(categoriaRest)
        
        var platoRest = PlatoDTOREST(id: 0, nombre: nombre, precioPlato: precio!, categoriaPlato: categoriaRest)
        let idRest = PlatoService().obtenerUltimoID()

        PlatoService().registrarPlato(plato: plato)
        
        
        platoRest.id = idRest
        
        PlatoServiceRest().registrarPlatoRest(platoRest: platoRest)
        
        Toast(text: "Plato registrado").show()
        //hacer que llamemos a la notificación creada para refrescar la lista
        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
        //volver a la pestaña anterior
        self.navigationController?.popViewController(animated: true)

    }
   
    
}
