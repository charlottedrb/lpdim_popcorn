//
//  CategoryCell.swift
//  PopCorn
//
//  Created by Charlotte Der Baghdassarian on 27/04/2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet var categoryLabel: UILabel!
    
    static let reuseId : String = "categoryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with label: String){
        categoryLabel.text = label
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CategoryCell", bundle: nil)
    }

}
