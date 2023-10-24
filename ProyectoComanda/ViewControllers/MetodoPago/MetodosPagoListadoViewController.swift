//
//  MetodosPagoListadoViewController.swift
//  ProyectoComanda
//
//  Created by Gary on 30/09/23.
//

import UIKit
//INVOCAMOS ESTOS MÉTODOS
class MetodosPagoListadoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
    @objc func cargarLista(Notification: NSNotification){
        listaMets = MetodoPagoService().listadoMetodos()
        tblMetodoPago.reloadData()

    }
    //AQUÍ ES LA TABLA HEREDADA
    @IBOutlet weak var tblMetodoPago: UITableView!
    var listaMets: [MetodoPago] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaMets = MetodoPagoService().listadoMetodos()
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
        if(segue.identifier == "nuevoMetodo"){
            let pantalla = segue.destination as! MetodosPagoAgregarViewController
        }
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

}
