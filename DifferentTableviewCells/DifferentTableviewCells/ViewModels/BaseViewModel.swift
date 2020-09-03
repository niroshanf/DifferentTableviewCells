//
//  BaseViewModel.swift
//  DifferentTableviewCells
//
//  Created by Anthony Niroshan Fernandez on 02/09/2020.
//  Copyright © 2020 Al Arabiya. All rights reserved.
//

import Foundation

enum FeedComponentCodes: String {
    case TopImageCard
    case ThumbImageCard
    case ScrollCard
    case Unknown
}

protocol BaseViewModel {
    
    var componentIndex: Int { get }
    var componentCode: FeedComponentCodes { get }
}
