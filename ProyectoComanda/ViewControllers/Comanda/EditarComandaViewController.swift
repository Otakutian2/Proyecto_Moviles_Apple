//
//  EditarComandaViewController.swift
//  ProyectoComanda
//
//  Created by Sebastian on 29/11/23.
//

import UIKit
import DropDown
import Toaster

class EditarComandaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
 
    @IBOutlet weak var tbDetalle: UITableView!
    
    @IBOutlet weak var btnMesas: UIButton!
    
    
    @IBOutlet weak var txtCantidadAsientos: UITextField!
    
    @IBOutlet weak var txtEstadoMesa: UITextField!
    
    @IBOutlet weak var txtPrecioTotal: UITextField!
    
    @IBOutlet weak var txtEmpleado: UITextField!
    @IBOutlet weak var btnFacturar: UIButton!
    
    var comanda : Comanda!
    var combo = DropDown()
    var idMesa = "Seleccionar"
    
    var precioDelDetalleCore = 0.00
    
    var idComanda: Int16 = 0
    
    var idDetalleComanda : Int16 = 0
    
    var listarDetalleporId : DetalleComanda?
    
    var listaComanda: [Comanda] = []
    
    var listadoDetalleporComanda: [DetalleComanda] = []
    
    var listarDetalle: [DetalleComandaDTO] = []
    
    var seRealizaronCambios = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        idMesa = String((comanda.fk_comanda_mesa?.id)!)
        txtCantidadAsientos.text = String((comanda.fk_comanda_mesa?.cantidadAsientos)!)
        txtEstadoMesa.text = comanda.fk_comanda_estado?.estado
        txtPrecioTotal.text = String(comanda.precioTotal)
        txtEmpleado.text = comanda.fk_comanda_empleado?.nombre
        btnMesas.setTitle(String((comanda.fk_comanda_mesa?.id)!), for: .normal)
        
        let sessionManager = SessionManager.shared

        // Verificar si hay un empleado en sesión
        if let empleadoDTO = sessionManager.currentEmpleado {
            if empleadoDTO.Cargo.nombre == "CAJERO" || empleadoDTO.Cargo.nombre == "ADMINISTRADOR" {
                btnFacturar.isEnabled = true
            } else {
                btnFacturar.isEnabled = false
            }
        } else {
            // No hay empleado en sesión
            print("Ningún empleado en sesión.")
        }


        listadoDetalleporComanda = DetaleComandaService().listaDetallePorComanda(idComanda: idComanda)
        tbDetalle.dataSource = self
        tbDetalle.rowHeight = 122
        tbDetalle.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(cargarDetalleComandas), name: NSNotification.Name(rawValue: "load2"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateDetallesComanda), name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Limpia el detalle de la comanda temporal al navegar hacia atrás
        SessionManagerDetalle.shared.limpiarDetallesComandaTemporales()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listadoDetalleporComanda.count + listarDetalle.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let data = tbDetalle.dequeueReusableCell(withIdentifier: "detalle") as! DetalleComandaEditarTableViewCell
            
            if indexPath.row < listadoDetalleporComanda.count {
                // Estás en el rango de los detalles obtenidos del CoreData
                let detalleComanda = listadoDetalleporComanda[indexPath.row]
                data.lblNombrePlato.text = detalleComanda.fk_detalle_plato?.nombre
                data.lblPrecioPlato.text = String(detalleComanda.fk_detalle_plato?.precioPlato ?? 0)
                data.lblCantidad.text = String(detalleComanda.cantidadPedido)
                data.lblObservacion.text = detalleComanda.observacion ?? ""
            } else {
                // Estás en el rango de los detalles temporales
                let detalleTemporal = listarDetalle[indexPath.row - listadoDetalleporComanda.count]
                data.lblNombrePlato.text = detalleTemporal.plato.nombre
                data.lblPrecioPlato.text = String(detalleTemporal.plato.precioPlato)
                data.lblCantidad.text = String(detalleTemporal.cantidadPedido)
                data.lblObservacion.text = detalleTemporal.obsevacion
            }

            return data
    }
    
  
    
    
    
    @objc func didUpdateDetallesComanda() {
        // Método que se llama cuando se actualiza la lista de detalles de la comanda
        listarDetalle = SessionManagerDetalle.shared.detallesComandaTemporales
        tbDetalle.reloadData()
        
        // Accede a la instancia compartida de SessionManagerDetalle
        let sessionManagerDetalle = SessionManagerDetalle.shared
        
        // Obtén el detalle global
        let detalleGlobal = sessionManagerDetalle.obtenerDetallesComandaTemporales()
        
        // Inicializa la variable total acumulado para detalles temporales
        var totalAcumulado: Double = 0.00
        
        // Itera a través de los detalles temporales
        for detalle in detalleGlobal {
            let precioPlato = detalle.plato.precioPlato
            let cantidadPedido = detalle.cantidadPedido
            
            // Calcula el total del plato actual
            let totalPlato = precioPlato * Double(cantidadPedido)
            
            // Suma el total del plato actual al total acumulado para detalles temporales
            totalAcumulado += totalPlato
        }
        
        // Obtén el precio total del detalle de la comanda core
        let comandaDetalle = DetaleComandaService().listaDetallePorComanda(idComanda: idComanda)
        var precioDelDetalleCore: Double = 0.00
        
        for c in comandaDetalle {
            precioDelDetalleCore = c.fk_detalle_comanda!.precioTotal
        }
        
        // Suma el precio del detalle de la comanda core y el total acumulado de detalles temporales
        let precioTotalFinal = precioDelDetalleCore + totalAcumulado
        
        // Actualiza el campo de texto con el precio total final
        txtPrecioTotal.text = String(precioTotalFinal)
    }

    
    @objc func cargarDetalleComandas(){
        
        listadoDetalleporComanda = DetaleComandaService().listaDetallePorComanda(idComanda: idComanda)
        tbDetalle.reloadData()
        
    }

    @IBAction func btnAñadirPlato(_ sender: Any) {
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "cambiarPlato") {
            let pantalla = segue.destination as! CambiarDetallePlatoViewController
            let indexPath = sender as! IndexPath
            // colocar aquí la variable de la vista actualizar
            pantalla.detalleComanda = listadoDetalleporComanda[indexPath.row]
          
        }else if segue.identifier == "facturar" {
            if let pantalla2 = segue.destination as? FacturarComandaViewController {
                let ComandaporId = ComandaService().obtenerComandaPorId(id: idComanda)
                
                pantalla2.comanda = ComandaporId
                
                
               
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cambiarPlato", sender: indexPath)
    }
    
    @IBAction func btnActualizarComandaDetalle(_ sender: Any) {
        
    }
    
    
    @IBAction func btnFacturar(_ sender: Any) {
        
        performSegue(withIdentifier: "facturar", sender: self)
        
        
    }
    
    
    
    
    
}
