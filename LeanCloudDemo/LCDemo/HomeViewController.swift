//
//  HomeViewController.swift
//  LCDemo
//
//  Created by chuda on 2019/11/20.
//  Copyright © 2019 LeanCloud. All rights reserved.
//

import UIKit
import LeanCloud
import Kingfisher

class HomeViewController: UITableViewController {

    var datas : [ArticleModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    
        reloadData()
        
        
    }
    

    func reloadData(){
        
        let query = LCQuery(className: "Articles")
        query.whereKey("createdAt", .ascending)
        _ = query.find(completion: {[unowned self] (result) in
            
            switch result {
            case .success(objects: let articles):
                self.datas = articles.map{ArticleModel(obj: $0)}
                self.tableView.reloadData()
            case .failure(error: let error):
                print(error)
            }
        })
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let model = datas[indexPath.row]
        cell.titleLabel.text = model.title
        cell.contentLabel.text = model.content
        cell.coverImageView.kf.setImage(with: URL(string: model.imagePath))
        cell.dateLabel.text = model.date
        cell.avatarImageView.kf.setImage(with: URL(string: model.avatar))
        cell.nameLabel.text = model.name
        return cell
    }
    
    

}
