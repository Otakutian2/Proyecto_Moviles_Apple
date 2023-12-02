//
//  FacturarComandaViewController.swift
//  ProyectoComanda
//
//  Created by Sebastian on 1/12/23.
//

import UIKit
import DropDown
import Toaster

class FacturarComandaViewController: UIViewController {
    
    
    @IBOutlet weak var txtIdComanda: UITextField!
    
    
    @IBOutlet weak var txtEmpleado: UITextField!
    
    @IBOutlet weak var txtIgv: UITextField!
    
    @IBOutlet weak var txtSubTotal: UITextField!
    
    @IBOutlet weak var txtDescuento: UITextField!
    
    @IBOutlet weak var txtTotal: UITextField!
    
    @IBOutlet weak var txtCliente: UITextField!
    
    var idComprobante = "Seleccione"

    var idCaja = "Seleccione"
    
    var idMetodoPago = "Seleccione"
    
    var comboCaja = DropDown()
    
    var comboComprobante = DropDown()
    
    var comboMetodo = DropDown()
    
    var comanda : Comanda!
    
    var idComanda: Int16 = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtIdComanda.text = String(comanda.id)
        let sessionManager = SessionManager.shared

        // Verificar si hay un empleado en sesión
        if let empleadoDTO = sessionManager.currentEmpleado {
                txtEmpleado.text = empleadoDTO.nombre
                print("Nombre del empleado en sesión: \(empleadoDTO.nombre)")
        
            
        } else {
            // No hay empleado en sesión
            print("Ningún empleado en sesión.")
        }
        CalcularPrecio()

       
    }
    
    func CalcularPrecio(){
        
        let subTotal = comanda.precioTotal
        let igv = subTotal * 0.18
        let total = subTotal + igv

        txtIgv.text = String(igv)
        txtSubTotal.text = String(subTotal)
        txtTotal.text = String(total)
        
        
    }
    
    @IBAction func btnCaja(_ sender: UIButton) {
        
        let listarCaja = CajaService().listadoCaja()

        var cajaString: [String] = ["Seleccionar"]
        
        for caja in listarCaja {
            cajaString.append(String(caja.id))
        }
    
        
        comboCaja.dataSource = cajaString
        sender.setTitle(cajaString[0], for: .normal)

        comboCaja.anchorView = sender
        comboCaja.bottomOffset = CGPoint(x: 0, y: (comboCaja.anchorView?.plainView.bounds.height)!)
        comboCaja.show()

        comboCaja.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            idCaja = item
            print("ID de la caja seleccionada: \(idCaja)")
        }
        
        
    }
    
    @IBAction func btnComprobante(_ sender: UIButton) {
        
        let listaComprobante = TipoComprobanteService().obtenerTipos()

        var tipoComprobanteString: [String] = ["Seleccionar"]
        
        for tipoComprobante in listaComprobante {
            tipoComprobanteString.append(tipoComprobante.tipo!)
        }
    
        
        comboComprobante.dataSource = tipoComprobanteString
        sender.setTitle(tipoComprobanteString[0], for: .normal)

        comboComprobante.anchorView = sender
        comboComprobante.bottomOffset = CGPoint(x: 0, y: (comboComprobante.anchorView?.plainView.bounds.height)!)
        comboComprobante.show()

        comboComprobante.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            idComprobante = item
            print("ID del Comprobante seleccionada: \(idCaja)")
        }
    }
    
    @IBAction func btnMetodoPago(_ sender: UIButton) {
        
        
        let listaMetodoPago = MetodoPagoService().listadoMetodos()

        var metodoPagoString: [String] = ["Seleccionar"]
        
        for metodoPago in listaMetodoPago {
            metodoPagoString.append(metodoPago.nombreMetodoPago!)
        }
    
        comboMetodo.dataSource = metodoPagoString
        sender.setTitle(metodoPagoString[0], for: .normal)

        comboMetodo.anchorView = sender
        comboMetodo.bottomOffset = CGPoint(x: 0, y: (comboMetodo.anchorView?.plainView.bounds.height)!)
        comboMetodo.show()

        comboMetodo.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            idMetodoPago = item
            print("ID del metodo  seleccionada: \(idCaja)")
        }
        
        
    }
    
    @IBAction func btnFacturar(_ sender: Any) {
        
        
        
        let sessionManager = SessionManager.shared

        // Verificar si hay un empleado en sesión
        if let empleadoDTO = sessionManager.currentEmpleado {
        
        
        let caja = CajaService().obtenerCajaporId(id: Int16(idCaja)!)
            
        let comprobante = TipoComprobanteService().obtenerTipo(nombre: idComprobante)
            
        let metodoPago = MetodoPagoService().obtenerMetodoPago(nombre: idMetodoPago)
        
        
        let idEmpleado = empleadoDTO.id
        
        let empleado = EmpleadoService().obtenerEmpleadoPorId(id: Int16(idEmpleado))
            
            let igv = Double(txtIgv.text!)
            let subTotal = Double(txtSubTotal.text!)
                
            
            if let descuentoText = txtDescuento.text,
               let totalText = txtTotal.text,
               let descuento = Double(descuentoText),
               let total = Double(totalText),
               descuento >= 0,
               descuento <= total,
               descuentoText.range(of: #"^\d+$"#, options: .regularExpression) != nil {
                // El descuento es un número positivo y solo contiene dígitos
                // Continuar con el cálculo
            } else {
                Toast(text: "Ingrese un descuento válido").show()
                return
            }

            if let descuento = Double(txtDescuento.text ?? ""),
               let total = Double(txtTotal.text ?? ""),
               descuento > total {
                Toast(text: "El descuento es mayor al total, verifique").show()
                return
            }
            
            
            
            let descuento = Double(txtDescuento.text!)
            let total = Double(txtTotal.text!)
            
            let fechaActual = Date()
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            let fechaActualString = dateFormat.string(from: fechaActual)
            
            let cliente = txtCliente.text!
            
            let comprobanteDto = ComprobanteDTO(id: 0, fechaEmision: fechaActualString, precioTotalPedido: total!, igv: igv!, subTotal: subTotal!, descuento: descuento!, nombreCliente: cliente, fk_CDP_tipocdp: comprobante, fk_cdp_caja: caja, fk_cdp_comanda: comanda, fk_cdp_metodo: metodoPago, fk_cdp_empleado: empleado)
            
            let usuarioDTO = UsuarioDTOREST(id: Int(empleado!.fk_empleado_usuario!.id), correo: empleado!.fk_empleado_usuario!.correo!, contrasena: empleado!.fk_empleado_usuario!.contrasena!)
            
            let cargoDTO = CargoDTO(id: Int(empleado!.fk_empleado_cargo!.id), nombre: empleado!.fk_empleado_cargo!.nombre!)
            
            let empleadoDTO = EmpleadoDTOREST(id: Int(empleado!.id), nombre: empleado!.nombre!, apellido: empleado!.apellido!, telefono: empleado!.telefono!, dni: empleado!.dni!, fechaRegistro: empleado!.fechaRegistro!, usuario: usuarioDTO, cargo: cargoDTO)
            let tipoComprobanteDTO = TipoComprobanteDTO(id: Int(comprobante!.id), tipo: comprobante!.tipo!)
            let metDTO = MetodoPagoDTO(id: Int(metodoPago!.id), nombreMetodoPago: metodoPago!.nombreMetodoPago!)
            
            let establecimientodDTO = EstablecimientoDTO(id: Int(caja!.fk_caja_establecimiento!.id), nomEstablecimiento: caja!.fk_caja_establecimiento!.nomEstablecimiento!, telefonoestablecimiento: caja!.fk_caja_establecimiento!.telefonoEstablecimiento!, direccionestablecimiento: caja!.fk_caja_establecimiento!.direccionestablecimiento!, rucestablecimiento: caja!.fk_caja_establecimiento!.rucestablecimiento!)
            
            let cajaDTO = CajaDTO(id: Int(caja!.id), Establecimiento: establecimientodDTO)
            
    
            let mesaDTO = MesaDTO(id: Int(comanda!.fk_comanda_mesa!.id), estado: comanda!.fk_comanda_mesa!.estado!, cantidadAsientos: Int(comanda!.fk_comanda_mesa!.cantidadAsientos))
            
            let estadoDTO = EstadoComandaDTO(id: Int(comanda!.fk_comanda_estado!.id), estado: comanda!.fk_comanda_estado!.estado!)
            
            let comandaDTO = ComandaDTORest(id: Int(comanda!.id), cantidadAsientos: Int(comanda!.cantidadAsientos), precioTotal: comanda!.precioTotal, fechaEmision: comanda!.fechaEmision!, mesa: mesaDTO, estadoComanda: estadoDTO, empleado: empleadoDTO)
            
            let comprobanteDtoRest = ComprobanteDTORest(id: 0, fechaEmision: fechaActualString, precioTotalPedido: total!, igv: igv!, subTotal: subTotal!, descuento: descuento!, nombreCliente: cliente, metodoPago: metDTO, tipoComprobante: tipoComprobanteDTO, empleado: empleadoDTO, comanda: comandaDTO, caja: cajaDTO)
            
            ComprobanteService().registrarComprobante(comprobante: comprobanteDto)
            ComprobanteService().registrarComprobanteRest(cdp: comprobanteDtoRest)
            ComprobanteService().registrarCDPFirebase(cdp: comprobanteDtoRest)
            
            
            if let obtenerMesaporIdComanda = comanda.fk_comanda_mesa?.id {
                let mesa = MesaService().obtenerMesaPorId(id: Int16(obtenerMesaporIdComanda))
                MesaService().actualizarEstadoMesa(id: mesa!.id, nuevoEstado: "Libre")
            } else {
                // El valor de comanda.fk_comanda_mesa?.id es nil
                print("No se pudo obtener el ID de la mesa asociada a la comanda.")
            }
            
            let comandaId = comanda.id
                 ComandaService().actualizarEstadoComanda(id: comandaId)
            
        
            Toast(text: "Comprobante registrado correctamete").show()
            
            
            
            if let viewControllers = self.navigationController?.viewControllers {
                for viewController in viewControllers {
                    if let miOtroViewController = viewController as? ListarComandaViewController {
                        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
                        self.navigationController?.popToViewController(miOtroViewController, animated: true)
                        break
                    }
                }
            }

            

            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
    }
    
}
