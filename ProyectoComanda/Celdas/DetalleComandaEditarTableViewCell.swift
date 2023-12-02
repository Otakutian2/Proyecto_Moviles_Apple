//
//  DetalleComandaEditarTableViewCell.swift
//  ProyectoComanda
//
//  Created by Sebastian on 29/11/23.
//

import UIKit

class DetalleComandaEditarTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNombrePlato: UILabel!
    
    @IBOutlet weak var lblPrecioPlato: UILabel!
    
    @IBOutlet weak var lblCantidad: UILabel!
    
    
    @IBOutlet weak var lblObservacion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
