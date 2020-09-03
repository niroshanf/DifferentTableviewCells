//
//  ViewController.swift
//  DifferentTableviewCells
//
//  Created by Anthony Niroshan Fernandez on 02/09/2020.
//  Copyright © 2020 Al Arabiya. All rights reserved.
//

import UIKit

struct APIArticleInfo: Decodable {
    var articleID: String
    var title: String
    var image: String
}

struct APIAuthorInfo: Decodable {
    var authorID: String
    var name: String
    var image: String
}

struct APIComponentInfo: Decodable {
    var componentCode: String
    var articles: [APIArticleInfo]?
    var authors: [APIAuthorInfo]?
}

struct APIInfo: Decodable {
    var components: [APIComponentInfo]?
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    private var dataSource: FeedDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Allow cells to dynamically adjust its height according to the content
        self.tableview.estimatedRowHeight = 100.0
        self.tableview.rowHeight = UITableView.automaticDimension
        
        self.registerCells()
        
        //Read the sample JOSN file
        //You can change this into network call as well
        if let data = self.readLocalFile() {
            
            self.parse(jsonData: data, onSuccess: { [weak self] (parsedData) in
                
                guard let self = self else { return }
                
                self.generateDataSource(data: parsedData)
                
            }, onError: { error in
                print(error)
            })
        }
    }
    
    func registerCells() {
        
        self.registerNib(class: TopImageCell.self)
        self.registerNib(class: ThumbImageCell.self)
        self.registerNib(class: ScrollCell.self)
    }
    
    //convenient method to register cells
    func registerNib<T: UITableViewCell>(class: T.Type) {
        
        let heroOneCellNib = UINib(nibName: String(describing: T.self), bundle: Bundle.main)
        self.tableview.register(heroOneCellNib, forCellReuseIdentifier: String(describing: T.self))
    }
    
    
}

extension ViewController {
    
    private func readLocalFile() -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "API", ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data, onSuccess: @escaping (_ parsedData: APIInfo)->(), onError: @escaping (_ error: Error)->()) {
        
        DispatchQueue.global().async {
            
            do {
                let decodedData = try JSONDecoder().decode(APIInfo.self, from: jsonData)
                
                DispatchQueue.main.async {
                    onSuccess(decodedData)
                }
                
            } catch {
                DispatchQueue.main.async {
                    onError(error)
                }
            }
        }
    }
    
    private func generateDataSource(data: APIInfo) {
        
        guard let fullComponents = data.components else { return }
        
        self.dataSource = FeedDataSource(components: fullComponents)
        self.tableview.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataSource?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = UITableViewCell()
        
        if let item = self.dataSource?.items[indexPath.row] {
        
            switch item.componentCode {
                
                case .TopImageCard:
                    
                    let listData = item as! TopImageCardModel
                    let customCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopImageCell.self), for: indexPath) as! TopImageCell
                    customCell.setData(data: listData)
                    cell = customCell
                
                case .ThumbImageCard:
                    
                    let listData = item as! ThumbImageCardModel
                    let customCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ThumbImageCell.self), for: indexPath) as! ThumbImageCell
                    customCell.setData(data: listData)
                    cell = customCell
                
                case .ScrollCard:
                    
                    let listData = item as! ScrollCardModel
                    
                    let customCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ScrollCell.self), for: indexPath) as! ScrollCell
                    customCell.componentTitle.text = listData.title
                    customCell.setData(data: listData)
                    cell = customCell
                
                default:
                    ()
            }
        }
        
        return cell
        
    }
}

