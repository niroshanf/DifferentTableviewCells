//
//  ScrollCardModel.swift
//  DifferentTableviewCells
//
//  Created by Anthony Niroshan Fernandez on 02/09/2020.
//  Copyright © 2020 Al Arabiya. All rights reserved.
//

import Foundation

class ScrollCardModel: BaseViewModel {
    
    var componentIndex: Int { self.idx }
    var componentCode: FeedComponentCodes { self.code }
    
    var idx: Int!
    var code: FeedComponentCodes = .Unknown
    var title: String!
    var data: [AuthorsInfo]?
    
    init(componentIndex: Int, code: FeedComponentCodes, title: String, data: [AuthorsInfo]?) {
        self.idx = componentIndex
        self.code = code
        self.title = title
        self.data = data
    }
}
