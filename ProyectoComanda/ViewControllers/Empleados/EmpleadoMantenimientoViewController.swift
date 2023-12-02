//
//  EmpleadoMantenimientoViewController.swift
//  ProyectoComanda
//
//  Created by Yajhura on 4/10/23.
//

import UIKit
import DropDown

class EmpleadoMantenimientoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tblEmpleados: UITableView!
    
    var listaEmpleados: [Empleado] = []
    var combo = DropDown()
    var cargoFiltro: String = "Cargo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaEmpleados = EmpleadoService().obtenerEmpleados()
        tblEmpleados.dataSource = self
        tblEmpleados.rowHeight = 130
        tblEmpleados.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(cargarLista), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func cargarLista(){
        listaEmpleados = EmpleadoService().obtenerEmpleados()
        if cargoFiltro != "Cargo"{
            listaEmpleados = listaEmpleados.filter{ objeto in
                return objeto.fk_empleado_cargo!.nombre!.contains(cargoFiltro)
            }
        }
        
        tblEmpleados.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaEmpleados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tblEmpleados.dequeueReusableCell(withIdentifier: "item_empleado") as! EmpleadoTableViewCell
        data.lblDNI.text = listaEmpleados[indexPath.row].dni
        data.lblCargo.text = listaEmpleados[indexPath.row].fk_empleado_cargo?.nombre
        data.lblFecha.text = listaEmpleados[indexPath.row].fechaRegistro
        data.lblNombre.text = listaEmpleados[indexPath.row].nombre
        data.lblTelefono.text = listaEmpleados[indexPath.row].telefono

        return data

    }
    
    
    @IBAction func comboCargos(_ sender: UIButton) {
        let listaCargos = CargoService().obtenerCargos()
        var cargosString : [String] = ["Cargo"]
        for cargo in listaCargos {
            cargosString.append(cargo.nombre!)
        }
        combo.dataSource = cargosString
        combo.anchorView = sender
        combo.bottomOffset = CGPoint(x: 0, y: (combo.anchorView?.plainView.bounds.height)!)
        combo.show()
        combo.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            cargoFiltro = item
        }
        
    }
    
    @IBAction func btnBuscar(_ sender: Any) {
        cargarLista()
    }
    
    @IBAction func vistaCrearEmpleado(_ sender: Any) {
        performSegue(withIdentifier: "nuevoEmpleado", sender: self)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editarEmpleado", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editarEmpleado"){
            let pantalla = segue.destination as! EmpleadoActualizarViewController
            let indexPath = sender as! IndexPath
            //colocar aquí la variable de la vista actualizar
            pantalla.empleado = listaEmpleados[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete {
                    EmpleadoService().eliminarEmpleado(empleado: listaEmpleados[indexPath.row])
                    EmpleadosServiceRest().eliminarEmpleadoRest(id: Int(listaEmpleados[indexPath.row].id))
                    cargarLista()
                }
            }

        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
                return.delete
       }
    
}

