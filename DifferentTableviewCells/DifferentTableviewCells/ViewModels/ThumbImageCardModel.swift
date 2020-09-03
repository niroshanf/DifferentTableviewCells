//
//  ThumbImageCardModel.swift
//  DifferentTableviewCells
//
//  Created by Anthony Niroshan Fernandez on 02/09/2020.
//  Copyright © 2020 Al Arabiya. All rights reserved.
//

import Foundation

class ThumbImageCardModel: BaseViewModel {
    
    var componentIndex: Int { self.idx }
    var componentCode: FeedComponentCodes { self.code }
    
    var idx: Int!
    var code: FeedComponentCodes = .Unknown
    var data: [ArticleInfo]?
    
    init(componentIndex: Int, code: FeedComponentCodes, data: [ArticleInfo]?) {
        self.idx = componentIndex
        self.code = code
        self.data = data
    }
}
