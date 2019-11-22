//
//  HomeTableViewCell.swift
//  LCDemo
//
//  Created by chuda on 2019/11/20.
//  Copyright © 2019 LeanCloud. All rights reserved.
//

import UIKit
import LeanCloud

let kCommunityForum = "CommunityForum"

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var collectButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func requestData(){
        
//        let query = LCQuery(className: kCommunityForum)
        
        
        
    }

}
