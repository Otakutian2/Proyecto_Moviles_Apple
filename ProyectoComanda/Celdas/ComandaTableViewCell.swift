//
//  ComandaTableViewCell.swift
//  ProyectoComanda
//
//  Created by Sebastian on 23/11/23.
//

import UIKit

class ComandaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblidComanda: UILabel!
    
    @IBOutlet weak var lblidMesa: UILabel!
    
    @IBOutlet weak var lblFecha: UILabel!
    
    @IBOutlet weak var lblEstadoComanda: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
