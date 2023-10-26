//
//  CategoriaListadoViewController.swift
//  ProyectoComanda
//
//  Created by Rodolfo on 5/10/23.
//
import Toaster
import UIKit

class CategoriaListadoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tblCategorias: UITableView!
    @IBOutlet weak var lblDatos: UILabel!
    @IBOutlet weak var txtFiltro: UITextField!
    
    //variiables
    var listaCats: [CategoriaPlato] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaCats = CategoriaService().listadoCategorias()
        if listaCats.count == 0 {
            lblDatos.isHidden = false
        }else {
            lblDatos.isHidden = true
        }
        tblCategorias.dataSource = self
        tblCategorias.rowHeight = 90
        tblCategorias.delegate = self
        //COLOCAR EVENTO QUE SE VA A EJECUTAR CUANDO LO LLAMAMOS EN EL MÉTODO DE REGISTRAR
        NotificationCenter.default.addObserver(self, selector: #selector(cargarLista), name: NSNotification.Name(rawValue: "load"), object: nil)
        

    }
    @objc func cargarLista(){
        listaCats = CategoriaService().listadoCategorias()
        let nombreBuscar = txtFiltro.text!
        if nombreBuscar.count > 0 {
            listaCats = listaCats.filter{ objeto in
                return objeto.categoria!.contains(nombreBuscar)
            }
        }
        
        if listaCats.count == 0 {
            lblDatos.isHidden = false
        }else {
            lblDatos.isHidden = true
        }
        tblCategorias.reloadData()
    }


    @IBAction func btnAgregarVista(_ sender: Any) {
        performSegue(withIdentifier: "agregarCategoria", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaCats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tblCategorias.dequeueReusableCell(withIdentifier: "item_catPlato") as! CategoriaPlatoTableViewCell
        data.lblCodigo.text = String(listaCats[indexPath.row].id)
        data.lblNombre.text = listaCats[indexPath.row].categoria!
        
        return data
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editarCategoria"){
            let pantalla = segue.destination as! CategoriaModificarViewController
            let indexPath = sender as! IndexPath
            //colocar aquí la variable de la vista actualizar
            pantalla.categoria = listaCats[indexPath.row]
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editarCategoria", sender: indexPath)
    }
    @IBAction func btnFiltrar(_ sender: Any) {
        cargarLista()
    }
    
}
