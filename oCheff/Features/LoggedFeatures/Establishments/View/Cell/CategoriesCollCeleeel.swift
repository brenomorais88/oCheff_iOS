//
//  CategoriesCollCell.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 19/02/23.
//

import UIKit

class CategoriesCollCell: UITableViewCell {
    static let cellID = "CategoriesCollCell"
    
    @IBOutlet weak var categorieName: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(name: String) {
        self.categorieName?.text = name
    }
}
