//
//  ListarComandaViewController.swift
//  ProyectoComanda
//
//  Created by Sebastian on 23/11/23.
//

import UIKit

class ListarComandaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var listaComanda: [Comanda] = []
    
    
    @IBOutlet weak var tbComanda: UITableView!
    
    @IBOutlet weak var lblDatos: UILabel!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaComanda.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let data = tbComanda.dequeueReusableCell(withIdentifier: "item_listComanda") as! ComandaTableViewCell
        data.lblidComanda.text = String(listaComanda[indexPath.row].id)
        data.lblFecha.text = listaComanda[indexPath.row].fechaEmision
        data.lblidMesa.text = String(listaComanda[indexPath.row].fk_comanda_mesa!.id)
        data.lblEstadoComanda.text = listaComanda[indexPath.row].fk_comanda_estado?.estado
        return data
        
        
    }
    @objc func cargarListaComandas(){
        listaComanda = ComandaService().listadoComandaPorEstado(estado: "Generado")
        if listaComanda.count == 0 {
            lblDatos.isHidden = false
        }else {
            lblDatos.isHidden = true
        }
         tbComanda.reloadData()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listaComanda = ComandaService().listadoComandaPorEstado(estado: "Generado")
        
        if listaComanda.count == 0 {
            lblDatos.isHidden = false
        }else {
            lblDatos.isHidden = true
        }
        
        tbComanda.dataSource = self
        tbComanda.rowHeight = 122
        tbComanda.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(cargarListaComandas), name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    
    
    @IBAction func btnAgregarComanda(_ sender: UIButton) {
        performSegue(withIdentifier: "agregar_comanda", sender: self)
     
            }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "actualizar_comanda", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "actualizar_comanda"){
            let pantalla = segue.destination as! EditarComandaViewController
            let indexPath = sender as! IndexPath
            pantalla.comanda = listaComanda[indexPath.row]
            pantalla.idComanda = listaComanda[indexPath.row].id
        }
    
    }
    
    
    
    
}
