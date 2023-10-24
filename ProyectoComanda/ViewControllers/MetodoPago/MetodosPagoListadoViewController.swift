//
//  MetodosPagoListadoViewController.swift
//  ProyectoComanda
//
//  Created by Gary on 30/09/23.
//

import UIKit

class MetodosPagoListadoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaMets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tblMetodoPago.dequeueReusableCell(withIdentifier: "item_MetPago") as! MetodoPagoTableViewCell
        data.lblCodigo.text = String(listaMets[indexPath.row].id)
        data.lblNombre.text = listaMets[indexPath.row].nombreMetodoPago!
        return data
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
        
        
    }
    
    @IBAction func btnAgregarVista(_ sender: Any) {
        /*
        let metodo = MetodoPagoDTO(id: 1, nombreMetodoPago: "RODOLFO")
        MetodoPagoService().registrarMetodoPago(metodo: metodo)
        print("PRUEBA LOCA")*/
    }
    

}
