//
//  ThumbImageCell.swift
//  DifferentTableviewCells
//
//  Created by Anthony Niroshan Fernandez on 02/09/2020.
//  Copyright © 2020 Al Arabiya. All rights reserved.
//

import UIKit

class ThumbImageCell: UITableViewCell {
    
    @IBOutlet weak var firstArticleImage: UIImageView!
    @IBOutlet weak var firstArticleTitle: UILabel!
    @IBOutlet weak var secondArticleImage: UIImageView!
    @IBOutlet weak var secondArticleTitle: UILabel!
    @IBOutlet weak var thirdArticleImage: UIImageView!
    @IBOutlet weak var thirdArticleTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data: ThumbImageCardModel) {
        
        guard let dataList = data.data else { return }
               
        guard let firstArticle = dataList.first else { return }
        self.firstArticleImage.image = UIImage(named: firstArticle.image)
        self.firstArticleTitle.text = firstArticle.title

        guard dataList.count > 1 else { return }
        let secondArticle = dataList[1]
        self.secondArticleImage.image = UIImage(named: secondArticle.image)
        self.secondArticleTitle.text = secondArticle.title
        
        guard dataList.count > 2 else { return }
        let thirdArticle = dataList[2]
        self.thirdArticleImage.image = UIImage(named: thirdArticle.image)
        self.thirdArticleTitle.text = thirdArticle.title
        
    }
    
}
