//
//  ActorCell.swift
//  PopCorn
//
//  Created by Charlotte Der Baghdassarian on 04/06/2021.
//

import UIKit

class ActorCell: UICollectionViewCell {

    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorPicture: UIImageView!
    
    let reuseId: String = "actorCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func nib() -> UINib {
        return UINib(nibName: "ActorCell", bundle: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.actorPicture.image = nil
    }

}
