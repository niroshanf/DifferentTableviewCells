//
//  ScrollCell.swift
//  DifferentTableviewCells
//
//  Created by Anthony Niroshan Fernandez on 02/09/2020.
//  Copyright © 2020 Al Arabiya. All rights reserved.
//

import UIKit

class ScrollCell: UITableViewCell {
    
    @IBOutlet weak var componentTitle: UILabel!
    @IBOutlet weak var container: UICollectionView!
    
    var authors: [AuthorsInfo]?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib:UINib = UINib(nibName: String(describing: AuthorCVCell.self), bundle: Bundle.main)
        container.register(nib, forCellWithReuseIdentifier: String(describing: AuthorCVCell.self))
    }

    func setData(data: ScrollCardModel) {
        
        if let authorsArr = data.data {
            self.authors = authorsArr
            
            self.container.reloadData()
        }
    }
}

extension ScrollCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.authors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: AuthorCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AuthorCVCell.self), for: indexPath) as! AuthorCVCell
        
        if let authorData = self.authors?[indexPath.row] {
            cell.setData(data: authorData)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var padding: UIEdgeInsets = UIEdgeInsets.zero
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            padding = flowLayout.sectionInset
        }
        
        let height: CGFloat = collectionView.frame.height - (padding.top + padding.bottom)
        
        return CGSize(width: 250, height: height)
    }
}

