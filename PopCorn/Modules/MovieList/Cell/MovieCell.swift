//
//  MovieCell.swift
//  PopCorn
//
//  Created by Charlotte Der Baghdassarian on 26/04/2021.
//

import UIKit

class MovieCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    
    static let reuseId : String = "MovieCellReuseID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
