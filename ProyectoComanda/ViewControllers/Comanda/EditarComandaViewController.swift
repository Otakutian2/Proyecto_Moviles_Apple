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
        NotificationCenter.default.addObserver(self, selector: #selector(disUpdateCore), name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Limpia el detalle de la comanda temporal al navegar hacia atrás
        SessionManagerDetalle.shared.limpiarDetallesComandaTemporales()
    }
    @objc func disUpdateCore(){
            didUpdateDetallesComanda()
            
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
            var precioTotalFinal: Double = 0.00

            for c in comandaDetalle {
                // Asegúrate de que el precio total de la comanda se actualice teniendo en cuenta la cantidad
                let precioUnitario = c.fk_detalle_plato?.precioPlato ?? 0.00
                let cantidad = c.cantidadPedido
                precioTotalFinal += precioUnitario * Double(cantidad)
            }

            // Suma el precio del detalle de la comanda core y el total acumulado de detalles temporales
            precioTotalFinal += totalAcumulado

            // Actualiza el campo de texto con el precio total final
            txtPrecioTotal.text = String(precioTotalFinal)
        }

    
    @objc func cargarDetalleComandas(){
        
        listadoDetalleporComanda = DetaleComandaService().listaDetallePorComanda(idComanda: idComanda)
        tbDetalle.reloadData()
        
    }

    @IBAction func btnAñadirPlato(_ sender: Any) {
        performSegue(withIdentifier: "actualizar_plato", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "cambiarPlato") {
                    let pantalla = segue.destination as! CambiarDetallePlatoViewController
                    let indexPath = sender as! IndexPath
                    // colocar aquí la variable de la vista actualizar
                    pantalla.detalleComanda = listadoDetalleporComanda[indexPath.row]
                  
                }
                if segue.identifier == "facturar" {
                    if let pantalla2 = segue.destination as? FacturarComandaViewController {
                        let ComandaporId = ComandaService().obtenerComandaPorId(id: idComanda)
                        
                        pantalla2.comanda = ComandaporId
                        
                    }
                }
                if segue.identifier == "actualizar_plato" {
                    if let pantalla2 = segue.destination as? An_adirPlatoViewController {
                        pantalla2.idUltimaComanda = Int16(idComanda)
                        
                    }
                }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Accede a la instancia compartida de SessionManagerDetalle
            let sessionManagerDetalle = SessionManagerDetalle.shared

            // Obtén el detalle global
            let detalleGlobal = sessionManagerDetalle.obtenerDetallesComandaTemporales()

            // Verifica si AL MENOS UN detalle es nulo
            let alMenosUnoNulo = detalleGlobal.contains { detalle in
                let detalleComandaporId = DetaleComandaService().obtenerDetalleComandaporId(id: Int16(detalle.id))
                return detalleComandaporId == nil
            }

            if alMenosUnoNulo {
                Toast(text: "Debes guardar el nuevo plato para poder actualizar").show()
            } else {
                // Ningún detalle es nulo, puedes proceder con la acción deseada
                performSegue(withIdentifier: "cambiarPlato", sender: indexPath)
            }
        }
    
    @IBAction func btnActualizarComandaDetalle(_ sender: Any) {
            
            let precioTotal = Double(txtPrecioTotal.text!)
            
            comanda.precioTotal = precioTotal!
            
            //Accede a la instancia compartida de SessionManagerDetalle
            let sessionManagerDetalle = SessionManagerDetalle.shared

            // Obtén el detalle global
            let detalleGlobal = sessionManagerDetalle.obtenerDetallesComandaTemporales()
            
            
            ComandaService().actualizarComandaYDetalles(comanda: comanda, nuevosDetalles: detalleGlobal)
            Toast(text: "Comanda actualizada").show()
            //hacer que llamemos a la notificación creada para refrescar la lista
            NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
            //volver a la pestaña anterior
            self.navigationController?.popViewController(animated: true)
          
        
            
        }
    
    
    @IBAction func btnFacturar(_ sender: Any) {
        
        performSegue(withIdentifier: "facturar", sender: self)
        
        
    }
    
    
    
    
    
}
