//
//  FeedDataSource.swift
//  DifferentTableviewCells
//
//  Created by Anthony Niroshan Fernandez on 02/09/2020.
//  Copyright © 2020 Al Arabiya. All rights reserved.
//

import Foundation


class FeedDataSource: NSObject {
    
    var items = [BaseViewModel]()
    
    init(components: [APIComponentInfo]) {
        
        for (i, singleComponent) in components.enumerated() {
            
            let code = singleComponent.componentCode
            guard let componentCode = FeedDataSource.getComponentEnum(code: code) else { continue }

            switch componentCode {
                
                case .TopImageCard:

                    guard let topArticlesArr = singleComponent.articles else { continue }
                
                    var finalArticlesArr: [ArticleInfo] = [ArticleInfo]()
                    
                    for singleArticle in topArticlesArr {
                        
                        finalArticlesArr.append(
                            ArticleInfo(articleID: singleArticle.articleID, title: singleArticle.title, image: singleArticle.image)
                        )
                    }
                
                    if finalArticlesArr.count > 0 {
                        let viewModelObject = TopImageCardModel(componentIndex: i, code: .TopImageCard, data: finalArticlesArr)
                        self.items.append(viewModelObject)
                    }
                
                case .ThumbImageCard:
                    
                    guard let thumbArticlesArr = singleComponent.articles else { continue }
                    
                    var finalArticlesArr: [ArticleInfo] = [ArticleInfo]()
                    
                    for singleArticle in thumbArticlesArr {
                        
                        finalArticlesArr.append(
                            ArticleInfo(articleID: singleArticle.articleID, title: singleArticle.title, image: singleArticle.image)
                        )
                    }
                
                    if finalArticlesArr.count > 0 {
                        let viewModelObject = ThumbImageCardModel(componentIndex: i, code: .ThumbImageCard, data: finalArticlesArr)
                        self.items.append(viewModelObject)
                    }
                
                case .ScrollCard:
                
                    guard let authorsArr = singleComponent.authors else { continue }
                        
                    var finalAuthorsArr: [AuthorsInfo] = [AuthorsInfo]()
                    
                    for singleAuthor in authorsArr {
                        
                        finalAuthorsArr.append(
                            AuthorsInfo(userID: singleAuthor.authorID, name: singleAuthor.name, image: singleAuthor.image)
                        )
                    }
                
                    if finalAuthorsArr.count > 0 {
                        let viewModelObject = ScrollCardModel(componentIndex: i, code: .ScrollCard, title: "List of Authors", data: finalAuthorsArr)
                        self.items.append(viewModelObject)
                    }
                default:
                    ()
            }
        }
    }
    
    private static func getComponentEnum(code: String) -> FeedComponentCodes? {
        
        let compCode = code.trimmingCharacters(in: .whitespacesAndNewlines)
        return FeedComponentCodes(rawValue: compCode)
    }
}
