//
//  DetalleComandaItem.swift
//  ProyectoComanda
//
//  Created by Sebastian on 26/11/23.
//

import UIKit

class DetalleComandaItem: UITableViewCell {

    @IBOutlet weak var lblnombrePlato: UILabel!
    
    @IBOutlet weak var lblprecio: UILabel!
    
    @IBOutlet weak var lblcantidad: UILabel!
    
    @IBOutlet weak var lblobservacion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
