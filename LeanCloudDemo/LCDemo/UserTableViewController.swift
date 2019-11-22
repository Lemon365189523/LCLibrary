//
//  UserTableViewController.swift
//  LCDemo
//
//  Created by chuda on 2019/11/20.
//  Copyright © 2019 LeanCloud. All rights reserved.
//

import UIKit
import LeanCloud

let kUpdateUserData = Notification.Name.init(rawValue: "UpdateUserData")

class UserTableViewController: UITableViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        setUserData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setUserData), name: kUpdateUserData, object: nil)
    }
    
    
    @objc func setUserData(){
        guard let user = User.current.info else {
            return
        }
        nameLabel.text = user.username?.value
        descLabel.text = user.get("signature")?.stringValue
        
        
        DispatchQueue.global().async {
            guard let file = user.get("avatar") as? LCFile ,
                let urlPath = file.url?.stringValue ,
                let url = URL(string: urlPath),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)else {
                return
            }
            
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
        
        
        
        
    }


}
