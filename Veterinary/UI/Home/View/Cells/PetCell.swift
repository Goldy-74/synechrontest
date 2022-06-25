//
//  PetCell.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import UIKit

class PetCell: UITableViewCell {
    
    //MARK: - IBOutlet(s)
    @IBOutlet weak var imgPetProfilePic: CustomImage?
    @IBOutlet weak var lblPetName: UILabel?
    
    //MARK: - Var(s)
    var data: Pet?{
        didSet{
            self.lblPetName?.text = data?.title
            self.imgPetProfilePic?.loadImageWithUrl(data?.imageURL ?? "")
        }
    }

    //MARK: - Life Cycle Method(s)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
