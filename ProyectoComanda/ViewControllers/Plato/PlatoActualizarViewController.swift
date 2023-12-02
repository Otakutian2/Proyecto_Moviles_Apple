//
//  PlatoViewController.swift
//  ProyectoComanda
//
//  Created by Rodolfo on 18/10/23.
//

import UIKit
import Toaster
import Foundation
import CoreData
import DropDown

class PlatoActualizarViewController: UIViewController {
    
    var plato : Plato!
    var combo = DropDown()
    var idCat = "Seleccionar"
    
    @IBOutlet weak var btnCategoria: UIButton!
    @IBOutlet weak var txtPrecio: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idCat = (plato.fk_plato_categoria?.categoria)!
        txtNombre.text = plato.nombre
        txtPrecio.text = String(plato.precioPlato)
        btnCategoria.setTitle(plato.fk_plato_categoria?.categoria, for: .normal)
    }
    
    @IBAction func btnSeleccionarCat(_ sender: UIButton) {
        let listaCat = CategoriaService().listadoCategorias()
        if(listaCat.count == 0){
            let categoriasStrings : [String] = ["No hay categorías"]
            combo.dataSource = categoriasStrings
            Toast(text: "No se puede registrar, no hay categorías").show()
        }else{
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
        sender.setTitle(plato.fk_plato_categoria?.categoria, for: .normal)
        
        combo.show()
        combo.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            idCat = item
            print(idCat)
        }
    }
    
    @IBAction func btnActualizar(_ sender: Any) {
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
            if(platoValida.nombre!.contains(nombre) && platoValida.id != plato.id){
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
        
        plato.nombre = nombre
        plato.precioPlato = precio!
        plato.fk_plato_categoria = categoriaObtenida
        
        print(plato.fk_plato_categoria = categoriaObtenida)
        
        let categoriaRest = CategoriaPlatoDTO(id: Int(plato.fk_plato_categoria!.id), categoria: plato.fk_plato_categoria!.categoria!)
        
        print(categoriaRest)
        
        
        let platoRest = PlatoDTOREST(id: Int(plato.id), nombre: plato.nombre!, precioPlato: plato.precioPlato, categoriaPlato: categoriaRest)
        
        print(platoRest)
        PlatoService().actualizarPlato(plato: plato)
        
        PlatoServiceRest().editarPlatoRest(platoRest: platoRest)
        
        Toast(text: "Plato actualizado").show()
        //hacer que llamemos a la notificación creada para refrescar la lista
        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
        //volver a la pestaña anterior
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func btnEliminar(_ sender: Any) {
        let ventana = UIAlertController(title: "Sistema", message: "¿Seguro de eliminar?", preferredStyle: .alert)
        let botonAceptar = UIAlertAction(title: "Sí", style: .default, handler: { acccion in
            
            let id = Int(self.plato.id)
            
            PlatoService().eliminarPlato(plato: self.plato)
            PlatoServiceRest().eliminarPlatoRest(id: id)
            NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
            Toast(text: "Plato eliminado").show()
            //VOLVER A LA PESTAÑA ANTERIOR
            self.navigationController?.popViewController(animated: true)
            
            
        })
        ventana.addAction(botonAceptar)
        ventana.addAction(UIAlertAction(title: "No", style: .cancel))
        present(ventana, animated: true)
    }
}
