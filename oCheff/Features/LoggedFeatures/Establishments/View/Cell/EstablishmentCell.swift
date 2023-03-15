//
//  EstablishmentCell.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 19/02/23.
//

import UIKit

class EstablishmentCell: UITableViewCell {
    static let cellID = "EstablishmentCell"
    
    @IBOutlet weak var logoImage: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?
    @IBOutlet weak var distanceLabel: UILabel?
    @IBOutlet weak var ratingLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(establishment: EstablishmentResponse) {
        self.nameLabel?.text = establishment.name
//        self.detailLabel.text = establishment.name
//        self.distanceLabel?.text = establishment.distance
//        self.ratingLabel?.text = establishment.avaliation
    }
    
}
