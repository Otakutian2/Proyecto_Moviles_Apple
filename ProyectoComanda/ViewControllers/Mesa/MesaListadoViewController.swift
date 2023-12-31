//
//  MesaListadoViewController.swift
//  ProyectoComanda
//
//  Created by Rodolfo on 5/10/23.
//

import UIKit
import Toaster
class MesaListadoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var listaMesas: [Mesa] = []
    
    
    
    @IBOutlet weak var tblMesas: UITableView!
    @IBOutlet weak var lblDatos: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaMesas = MesaService().listadoMesa()
        if listaMesas.count == 0 {
            lblDatos.isHidden = false	
        }else {
            lblDatos.isHidden = true
        }
        tblMesas.dataSource = self
        tblMesas.rowHeight = 90
        tblMesas.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(cargarLista), name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    
    @objc func cargarLista(){
        listaMesas = MesaService().listadoMesa()
      
        if listaMesas.count == 0 {
            lblDatos.isHidden = false
        }else {
            lblDatos.isHidden = true
        }
        tblMesas.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaMesas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tblMesas.dequeueReusableCell(withIdentifier: "item_mesa") as! MesaTableViewCell
        data.lblCodigo.text = String(listaMesas[indexPath.row].id)
        data.lblEstado.text = listaMesas[indexPath.row].estado
        data.lblAsientos.text = String(listaMesas[indexPath.row].cantidadAsientos)
        
        return data
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editar_mesa"){
            let pantalla = segue.destination as! MesaActualizarViewController
            let indexPath = sender as! IndexPath
            //colocar aquí la variable de la vista actualizar
            pantalla.mesa = listaMesas[indexPath.row]
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editar_mesa", sender: indexPath)
    }

       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                    if editingStyle == .delete {
                      let mesaRow = listaMesas[indexPath.row]
                       
                        if(mesaRow.estado == "Ocupado"){
                            Toast(text: "No se puede eliminar una Mesa con estado ocupado").show()
                         return
                        }
                        if(mesaRow.fk_mesa_comanda!.count > 0){
                            Toast(text: "No se puede eliminar una Mesa con comandas registradas").show()
                            return
                        }
                        
                        MesaService().eliminarMesa(mesa: mesaRow)
                        MesaServiceRest().eliminarMesaRest(id: Int(mesaRow.id))
                        cargarLista()
                    }
                }

            func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
                    return.delete
           }
}
