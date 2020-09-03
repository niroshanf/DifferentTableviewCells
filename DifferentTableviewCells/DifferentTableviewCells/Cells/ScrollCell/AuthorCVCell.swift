//
//  AuthorCVCell.swift
//  DifferentTableviewCells
//
//  Created by Anthony Niroshan Fernandez on 03/09/2020.
//  Copyright © 2020 Al Arabiya. All rights reserved.
//

import UIKit

class AuthorCVCell: UICollectionViewCell {
    
    @IBOutlet weak var authourImage: UIImageView!
    @IBOutlet weak var authourName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data: AuthorsInfo) {
        
        self.authourImage.image = UIImage(named: data.image)
        self.authourName.text = data.name
    }
}
