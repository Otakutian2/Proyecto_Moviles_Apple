//
//  AñadirPlatoViewController.swift
//  ProyectoComanda
//
//  Created by Sebastian on 24/11/23.
//

import UIKit

import DropDown
import Toaster

class An_adirPlatoViewController: UIViewController {

    
    @IBOutlet weak var btnPlatos: UIButton!
    
    @IBOutlet weak var txtCantidad: UITextField!
    
    @IBOutlet weak var txtObservacion: UITextView!
    
    var comboCategoria = DropDown()
    var idCat = "Seleccionar"
    var idPlato = "Seleccionar"
    var comboPlato = DropDown()
    
    var preciotoal : Double = 0.0
    var idUltimaComanda: Int16!
    var detalleComanda : DetalleComanda?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func btnCancelar(_ sender: Any) {
        
        dismiss(animated: true,completion: nil)
        
    }
    
    @IBAction func btncargarCategorias(_ sender: UIButton) {
        let listaCat = CategoriaService().listadoCategorias()
            var categoriasStrings : [String] = ["Seleccionar"]
            for categoria in listaCat {
                categoriasStrings.append(categoria.categoria!)
            }
            comboCategoria.dataSource = categoriasStrings
           
            sender.setTitle(categoriasStrings[0], for: .normal)
        
            comboCategoria.anchorView = sender
            comboCategoria.bottomOffset = CGPoint(x: 0, y: (comboCategoria.anchorView?.plainView.bounds.height)!)
            comboCategoria.show()
            comboCategoria.selectionAction = { [unowned self] (index: Int, item: String) in
                sender.setTitle(item, for: .normal)
                idCat = item
                
                cargarPlatos(categoria: item)
        }
        
    }
    
    func cargarPlatos(categoria: String) {
        let listaPlatos = PlatoService().listadoPlatosPorCategoria(categoria: categoria)
        var platosStrings: [String] = ["Seleccionar"]
        
        for plato in listaPlatos {
            platosStrings.append(plato.nombre!)
            print("El plato es ----------",plato.nombre)
        }
        
        comboPlato.dataSource = platosStrings
        btnPlatos.setTitle(platosStrings[0], for: .normal)
        
        // Resto de la configuración del dropdown para platos
        comboPlato.anchorView = btnPlatos
        comboPlato.bottomOffset = CGPoint(x: 0, y: (comboPlato.anchorView?.plainView.bounds.height)!)
        comboPlato.show()
        
        comboPlato.selectionAction = { [unowned self] (index: Int, item: String) in
            btnPlatos.setTitle(item, for: .normal)
             idPlato = item
            print("El plato seleccionado-----D",idPlato)
        }
    }
    @IBAction func btnAgregarPlato(_ sender: UIButton) {
        let cantidadPedido = Int(txtCantidad.text ?? "")
                let observacion = txtObservacion.text!

                // Verificar si el plato ya está en la lista
                if let platoSeleccionado = PlatoService().obtenerPlato(nombre: idPlato),
                    SessionManagerDetalle.shared.detallesComandaTemporales.first(where: { $0.plato.id == platoSeleccionado.id }) != nil {
                    // El plato ya está en la lista
                    let mensaje = "El plato ya se encuentra registrado, edite la cantidad"
                    Toast(text: mensaje).show()
                } else {
                    
                    // Crea la comanda con el próximo ID
                    let comanda = ComandaService().obtenerComandaPorId(id: Int16(idUltimaComanda))
                    print("Obtengo id de la comnada----------",comanda)

                    // El plato no está en la lista, se puede agregar
                    if let platoSeleccionado = PlatoService().obtenerPlato(nombre: idPlato) {
                        let idDetalle = DetaleComandaService().obtenerUltimoID()
                        var nuevoDetalleTemporal = DetalleComandaDTO(
                            id: idDetalle,
                            cantidadPedido: cantidadPedido!,
                            precioUnitario: platoSeleccionado.precioPlato,
                            obsevacion: observacion,
                            plato: platoSeleccionado,
                            comanda: nil
                        )

                        // Agregas el detalle a la sesión temporal
                        SessionManagerDetalle.shared.agregarDetalleComandaTemporal(detalle: nuevoDetalleTemporal)
                        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)

                        // Obtén la comanda válida
                        if let comanda = ComandaService().obtenerComandaPorId(id: Int16(idUltimaComanda)) {
                            nuevoDetalleTemporal.comanda = comanda
                        }

                        // Volvemos a la pestaña anterior solo si no hay plato duplicado
                        dismiss(animated: true, completion: nil)
                    } else {
                        // Manejar el caso en el que no se puede obtener el plato seleccionado
                        let mensaje = "Error al obtener el plato seleccionado"
                        Toast(text: mensaje).show()
                    }


                }
    }
    



    
    
    
    
    
}
