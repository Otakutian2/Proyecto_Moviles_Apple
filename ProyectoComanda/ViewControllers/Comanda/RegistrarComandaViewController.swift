//
//  RegistrarComandaViewController.swift
//  ProyectoComanda
//
//  Created by Sebastian on 23/11/23.
//

import UIKit
import DropDown
import Toaster

class RegistrarComandaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    
    
    @IBOutlet weak var txtcantAsientos: UITextField!
    
    @IBOutlet weak var txtestadoComanda: UITextField!
    
    @IBOutlet weak var txtpreciototal: UITextField!
    
    @IBOutlet weak var txtempleado: UITextField!
    
    @IBOutlet weak var btnAgregar: UIButton!
    
    @IBOutlet weak var cvDetalleComanda: UITableView!
    
    var combo = DropDown()
    var idMesa = "Seleccionar"
    
    var listarDetalle: [DetalleComandaDTO] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listarDetalle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = cvDetalleComanda.dequeueReusableCell(withIdentifier: "detalle") as! DetalleComandaItem
        data.lblnombrePlato.text = listarDetalle[indexPath.row].plato.nombre
        data.lblprecio.text = String(listarDetalle[indexPath.row].plato.precioPlato)
        data.lblcantidad.text = String(listarDetalle[indexPath.row].cantidadPedido)
        data.lblobservacion.text = listarDetalle[indexPath.row].obsevacion
    
        
        return data
        
    }
    
    
    @objc func didUpdateDetallesComanda() {
            // Método que se llama cuando se actualiza la lista de detalles de la comanda
            listarDetalle = SessionManagerDetalle.shared.detallesComandaTemporales
            cvDetalleComanda.reloadData()
        
            // Accede a la instancia compartida de SessionManagerDetalle
           let sessionManagerDetalle = SessionManagerDetalle.shared
        
           // Obtén el detalle global
           let detalleGlobal = sessionManagerDetalle.obtenerDetallesComandaTemporales()

           // Inicializa la variable total acumulado
           var totalAcumulado: Double = 0.00

           // Itera a través de los detalles
           for detalle in detalleGlobal {
               let precioPlato = detalle.plato.precioPlato
               let cantidadPedido = detalle.cantidadPedido

               // Calcula el total del plato actual
               let totalPlato = precioPlato * Double(cantidadPedido)

               // Suma el total del plato actual al total acumulado
               totalAcumulado += totalPlato
           }


           txtpreciototal.text = String(totalAcumulado)
        
        }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Limpia el detalle de la comanda temporal al navegar hacia atrás
        SessionManagerDetalle.shared.limpiarDetallesComandaTemporales()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let sessionManager = SessionManager.shared

        // Verificar si hay un empleado en sesión
        if let empleadoDTO = sessionManager.currentEmpleado {
            // Asignar el nombre del empleado al texto del UITextField
            txtempleado.text = empleadoDTO.nombre
            print("Nombre del empleado en sesión: \(empleadoDTO.nombre)")
        } else {
            // No hay empleado en sesión
            print("Ningún empleado en sesión.")
        }
        
        // DAR VALORES
        cvDetalleComanda.dataSource = self
        cvDetalleComanda.rowHeight = 90
        cvDetalleComanda.delegate = self
        
    
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateDetallesComanda), name: NSNotification.Name(rawValue: "load"), object: nil)

    }

   
    @IBAction func cargarMesas(_ sender: UIButton) {
        
        let listaMesas = MesaService().listadoMesa()

        var mesasStrings: [String] = ["Seleccionar"]
        for mesa in listaMesas {
            if mesa.estado == "Libre" {
                mesasStrings.append(String(mesa.id))
            }
        }

        combo.dataSource = mesasStrings
        sender.setTitle(mesasStrings[0], for: .normal)

        combo.anchorView = sender
        combo.bottomOffset = CGPoint(x: 0, y: (combo.anchorView?.plainView.bounds.height)!)
        combo.show()

        combo.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            idMesa = item
            print("ID de la mesa seleccionada: \(idMesa)")
        }
    }
    
    
    @IBAction func btnagregarPlato(_ sender: Any) {
        
    }
    
    @IBAction func btnGenerarComanda(_ sender: Any) {
            
        
        let sessionManager = SessionManager.shared

        // Verificar si hay un empleado en sesión
        if let empleadoDTO = sessionManager.currentEmpleado {
            
            
        let fechaActual = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let fechaActualString = dateFormat.string(from: fechaActual)
            
        let asientos = txtcantAsientos.text!
        let precioTotal = txtpreciototal.text!
        
       
        let obtenerMesas = MesaService().obtenerMesa()
        
        
        if let cantidadAsientos = Int(asientos) {
            for m in obtenerMesas {
                if cantidadAsientos > Int(m.cantidadAsientos) {
                    Toast(text: "Excedió en el número de asientos").show()
                    return
                }
            }
        }
            let idEmpleado = empleadoDTO.id
            
            let empleado = EmpleadoService().obtenerEmpleadoPorId(id: Int16(idEmpleado))
            
            let obtenerEstadoComanda = EstadoComandaService().obtenerEstados()
            
            let estadoGenerado = obtenerEstadoComanda.first(where: { $0.estado == "Generado" })
            let mesa = MesaService().obtenerMesaPorId(id: Int16(idMesa)!)
            
        
            let comandaDto = ComandaDTO(id: 0, cantidadAsientos: Int(asientos)!, precioTotal: Double(precioTotal)!, fechaEmision: fechaActualString, mesa: mesa!, estadoComanda: estadoGenerado!, empleado: empleado!)
            
            print(comandaDto)
            
            // Accede a la instancia compartida de SessionManagerDetalle
               let sessionManagerDetalle = SessionManagerDetalle.shared

               // Obtén el detalle global
               let detalleGlobal = sessionManagerDetalle.obtenerDetallesComandaTemporales()
            
            for a in detalleGlobal {
                print("Id del detalle comnada",a.id)
                print("Id de la comanda",a.comanda)
            }
            
                let comandaService = ComandaService()
                comandaService.registrarComandaYDetalles(comanda: comandaDto, detalles: detalleGlobal)
            
                MesaService().actualizarEstadoMesa(id: mesa!.id, nuevoEstado: "ocupado")
                
                SessionManagerDetalle.shared.limpiarDetallesComandaTemporales()

                
                Toast(text: "Comanda registrada").show()
                //hacer que llamemos a la notificación creada para refrescar la lista
                NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
                //volver a la pestaña anterior
                self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
}
   


