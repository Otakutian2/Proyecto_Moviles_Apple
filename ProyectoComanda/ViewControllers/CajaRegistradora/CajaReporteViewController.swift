//
//  CajaReporteViewController.swift
//  ProyectoComanda
//
//  Created by Gary on 18/10/23.
//

import UIKit

class CajaReporteViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tb_datos: UITableView!
    
    var listaComprobante : [Comprobante] = []
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaComprobante.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tb_datos.dequeueReusableCell(withIdentifier: "comprobante_caja") as! CajaRegistradoraTableViewCell
        data.lblIdComprobante.text = String(listaComprobante[indexPath.row].id)
        data.lblFechaEmison.text = listaComprobante[indexPath.row].fechaEmision
        data.lblCaja.text = String(listaComprobante[indexPath.row].fk_cdp_caja!.id)
        data.lblMetodoPago.text = listaComprobante[indexPath.row].fk_cdp_metodo?.nombreMetodoPago
        data.lblTotal.text = String(listaComprobante[indexPath.row].precioTotalPedido)
        return data
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaComprobante = ComprobanteService().listarComprobante()
        tb_datos.dataSource = self
        tb_datos.rowHeight = 120
        tb_datos.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(cargarLista), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func cargarLista(){
        
        listaComprobante = ComprobanteService().listarComprobante()
        
        tb_datos.reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "comprobante", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "comprobante"){
            let pantalla = segue.destination as! DatosComprobanteViewController
            let indexPath = sender as! IndexPath
            pantalla.comprobante = listaComprobante[indexPath.row]
           
        }
    
    }
    

 

}
