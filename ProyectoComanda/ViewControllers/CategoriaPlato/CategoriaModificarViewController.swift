//
//  CategoriaModificarViewController.swift
//  ProyectoComanda
//
//  Created by Rodolfo on 5/10/23.
//

import UIKit
import Toaster


class CategoriaModificarViewController: UIViewController {
    
    var categoria : CategoriaPlato!
    
    @IBOutlet weak var txtCategoria: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCategoria.text = categoria.categoria
    }
    
    @IBAction func btnActualizar(_ sender: Any) {
        let nombre = txtCategoria.text ?? ""
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
            if(catValida.categoria!.contains(nombre) && catValida.id != categoria.id){
                Toast(text: "El nombre de la categoría se repite").show()
                return
            }
        }
        
       
        
        categoria.categoria = nombre
        
        let categoriaDTO = CategoriaPlatoDTO(id: Int(categoria.id), categoria: categoria.categoria! )
        
        CategoriaService().actualizarCategoria(cat: categoria)
        CategoriaServiceRest().editarMetodoPagoRest(categoriaRest:  categoriaDTO)
        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)

        Toast(text: "Categoría actualizada").show()
        //Con esto volvemos a la pestaña anterior
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnEliminar(_ sender: Any) {
        let ventana = UIAlertController(title: "Sistema", message: "¿Seguro de eliminar?", preferredStyle: .alert)
        let botonAceptar = UIAlertAction(title: "Sí", style: .default, handler: { acccion in
            if self.categoria.fk_categoria_plato?.count == 0 {
                let id = Int(self.categoria.id)
                
                
                CategoriaService().eliminarCategoria(cat: self.categoria)
                CategoriaServiceRest().eliminarCategoriaRest(id: id)
                NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
                Toast(text: "Categoría eliminada eliminado").show()
                //VOLVER A LA PESTAÑA ANTERIOR
                self.navigationController?.popViewController(animated: true)
            }else {
                Toast(text: "No se puede eliminar una categoría con platos registrados").show()

            }
            
        })
        ventana.addAction(botonAceptar)
        ventana.addAction(UIAlertAction(title: "No", style: .cancel))
        present(ventana, animated: true)
    }
    

}
