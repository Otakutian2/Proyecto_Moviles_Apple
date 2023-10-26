//
//  PlatoListadoViewController.swift
//  ProyectoComanda
//
//  Created by Rodolfo on 18/10/23.
//

import UIKit
import DropDown

class PlatoListadoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lblDatos: UILabel!
    @IBOutlet weak var txtFiltroNombre: UITextField!
    
    @IBOutlet weak var tblPlatos: UITableView!
    @IBOutlet weak var spnCategoriaFiltro: UIButton!
    
    //variable
    var listaPlato: [Plato] = []
    var combo = DropDown()
    var categoriaFiltro: String = "Categoría"
    override func viewDidLoad() {
        super.viewDidLoad()
        listaPlato = PlatoService().listadoPlatos()
        if listaPlato.count == 0 {
            lblDatos.isHidden = false
        }else {
            lblDatos.isHidden = true
        }
        //DAR VALORES
        tblPlatos.dataSource = self
        tblPlatos.rowHeight = 90
        tblPlatos.delegate = self
        //COLOCAR EVENTO QUE SE VA A EJECUTAR CUANDO LO LLAMAMOS EN EL MÉTODO DE REGISTRAR
        NotificationCenter.default.addObserver(self, selector: #selector(cargarLista), name: NSNotification.Name(rawValue: "load"), object: nil)
        //cargar combo
        
    }
    @objc func cargarLista(){
        listaPlato = PlatoService().listadoPlatos()
        let nombreBuscar = txtFiltroNombre.text!
        if nombreBuscar.count > 0 {
            listaPlato = listaPlato.filter{ objeto in
                return objeto.nombre!.contains(nombreBuscar)
            }
        }
        if categoriaFiltro != "Categoría"{
            listaPlato = listaPlato.filter{objeto in
                return objeto.fk_plato_categoria!.categoria!.contains(categoriaFiltro)
            }
        }
        
        if listaPlato.count == 0 {
            lblDatos.isHidden = false
        }else {
            lblDatos.isHidden = true
        }
        tblPlatos.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaPlato.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tblPlatos.dequeueReusableCell(withIdentifier: "item_Plato") as! PlatoTableViewCell
        data.lblCodigo.text = String(listaPlato[indexPath.row].id)
        data.lblNombre.text = listaPlato[indexPath.row].nombre!
        data.lblPrecio.text = String(listaPlato[indexPath.row].precioPlato)
        data.lblCategoria.text = listaPlato[indexPath.row].fk_plato_categoria?.categoria!
        return data
    }
    
    

    @IBAction func SeleccionarCategoria(_ sender: UIButton) {
        let listaCat = CategoriaService().listadoCategorias()
        var categoriasStrings : [String] = ["Categoría"]
        for categoria in listaCat {
            categoriasStrings.append(categoria.categoria!)
        }
        combo.dataSource = categoriasStrings
        combo.anchorView = sender
        combo.bottomOffset = CGPoint(x: 0, y: (combo.anchorView?.plainView.bounds.height)!)
        combo.show()
        
        combo.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            categoriaFiltro = item
           
            
        }
        
        
    }
    @IBAction func btnAgregar(_ sender: Any) {
        performSegue(withIdentifier: "agregarPlato", sender: self)
        
    }
    
    @IBAction func btnBuscar(_ sender: Any) {
        cargarLista()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editarPlato", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editarPlato"){
            let pantalla = segue.destination as! PlatoActualizarViewController
            let indexPath = sender as! IndexPath
            //colocar aquí la variable de la vista actualizar
            pantalla.plato = listaPlato[indexPath.row]
        }
    }
    
}
