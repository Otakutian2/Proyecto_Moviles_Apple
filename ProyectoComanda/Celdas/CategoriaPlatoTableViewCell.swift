//
//  CategoriaPlatoTableViewCell.swift
//  ProyectoComanda
//
//  Created by Gary on 25/10/23.
//

import UIKit

class CategoriaPlatoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblCodigo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
