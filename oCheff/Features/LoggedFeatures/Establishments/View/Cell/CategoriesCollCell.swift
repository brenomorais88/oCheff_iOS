//
//  CategoriesCollCell.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 19/02/23.
//

import UIKit

class CategoriesCollCell: UICollectionViewCell {
    static let cellID = "CategoriesCollCell"
    
    @IBOutlet weak var categorieName: UILabel?
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setupSelectedCell()
            } else {
                setupNotSelectedCell()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(name: String) {
        self.categorieName?.text = name
    }
    
    private func setupSelectedCell() {
        self.categorieName?.font = UIFont.boldSystemFont(ofSize: 16)
        self.categorieName?.textColor = UIColor.primaryColor
    }
    
    private func setupNotSelectedCell() {
        self.categorieName?.font = UIFont.systemFont(ofSize: 16)
        self.categorieName?.textColor = UIColor.black
    }
}
