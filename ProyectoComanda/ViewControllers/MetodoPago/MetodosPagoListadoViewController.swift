//
//  MetodosPagoListadoViewController.swift
//  ProyectoComanda
//
//  Created by Gary on 30/09/23.
//

import UIKit
import Alamofire
//INVOCAMOS ESTOS MÉTODOS
class MetodosPagoListadoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //txt filtrado
    
    @IBOutlet weak var lblDatosRegistrados: UILabel!
    @IBOutlet weak var txtFiltrado: UITextField!
    var listaMets: [MetodoPago] = []
    
    var listaMedicamento: Array<MetodoPagoDTO> = []
    	
    //AQUÍ ES LA TABLA HEREDADA
    @IBOutlet weak var tblMetodoPago: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaMets.count
    }
    //ESTE MÉTODO SE EJECUTA DEPENDIENDO DE LA CANTIDAD DE OBJETOS EN LA LISTA
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tblMetodoPago.dequeueReusableCell(withIdentifier: "item_MetPago") as! MetodoPagoTableViewCell
        data.lblCodigo.text = String(listaMets[indexPath.row].id)
        data.lblNombre.text = listaMets[indexPath.row].nombreMetodoPago!
        return data
    }
    
    //METODO PARA RECARGAR LA TABLA
    @objc func cargarLista(){
        listaMets = MetodoPagoService().listadoMetodos()
        let nombreBuscar = txtFiltrado.text!
        if nombreBuscar.count > 0 {
            listaMets = listaMets.filter{ objeto in
                return objeto.nombreMetodoPago!.contains(nombreBuscar)
            }
        }
        if listaMets.count == 0 {
            lblDatosRegistrados.isHidden = false
        }else {
            lblDatosRegistrados.isHidden = true
        }
        tblMetodoPago.reloadData()

    }
    
    func cargarListadoRest(){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/metodo-pago")
            .responseDecodable(of: Array<MetodoPagoDTO>.self){
                respuesta in
                guard let datos = respuesta.value else { return}
                
                self.listaMedicamento = datos
                self.tblMetodoPago.reloadData()
            }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaMets = MetodoPagoService().listadoMetodos()
        
        if listaMets.count == 0 {
            lblDatosRegistrados.isHidden = false
        }else {
            lblDatosRegistrados.isHidden = true
        }
        tblMetodoPago.dataSource = self
        tblMetodoPago.rowHeight = 90
        tblMetodoPago.delegate = self
        //COLOCAR EVENTO QUE SE VA A EJECUTAR CUANDO LO LLAMAMOS EN EL MÉTODO DE REGISTRAR
        NotificationCenter.default.addObserver(self, selector: #selector(cargarLista), name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    //BOTÓN PARA AGREGAR NUEVO MÉTODO - ESTO ES MEDIANTE LAS FLECHAS DEL MISMO VIEWCONTROLLER
    @IBAction func btnAgregarVista(_ sender: Any) {
        performSegue(withIdentifier: "nuevoMetodo", sender: self)
    }
    //MÉTODO QUE SE DISPARA AL LLAMAR A LAS FLECHAS SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MÉTODO QUE SE DISPARAR AL MOVERSE DE PESTAÑA CON LA FLECHA
       
        if(segue.identifier == "editarMetodo"){
            let pantalla = segue.destination as! MetodosPagoActualizarViewController
            let indexPath = sender as! IndexPath
            //colocar aquí la variable de la vista actualizar
            pantalla.metodo = listaMets[indexPath.row]
        }
        
    }
    
    //MÉTODO QUE SE DISPARA AL DARLE CLICK A UNA CELDA
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //EN ESTE LLAMADO LE PASAMOS LA VARIABLE indexPath
        performSegue(withIdentifier: "editarMetodo", sender: indexPath)
    }

    @IBAction func btnFiltrado(_ sender: Any) {
        cargarLista()
    }
   
}
