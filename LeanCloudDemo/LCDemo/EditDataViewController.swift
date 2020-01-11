//
//  OLEditDataViewController.swift
//  Futures
//
//  Created by chuda on 2019/11/18.
//  Copyright © 2019 Outline. All rights reserved.
//

import UIKit
import Eureka
import LeanCloud

struct EditDataInfo {
    var avatarData : Data?
    var birthDay : Date?
    var nickname : String?
    var signature : String?
}

class EditDataViewController: FormViewController {
    
    
    private var info = EditDataInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateData()
        
        tableView.tableFooterView = UIView()
        navigationItem.title = "编辑资料"
        ImageRow.defaultCellUpdate = { cell, row in
           cell.accessoryView?.layer.cornerRadius = 17
           cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
//            cell.height = 100
        }
//        tableView.backgroundColor = .white
        tableView.separatorStyle = .none

    
        form
            +++ ImageRow() {[unowned self] row in
                row.title = "选择头像"
                row.value = User.current.avatar
                if self.info.avatarData != nil {
                    row.value = UIImage(data: self.info.avatarData!)
                }
                row.sourceTypes = [.PhotoLibrary, .Camera]
                row.onChange { (row) in
                    self.info.avatarData = row.value?.jpegData(compressionQuality: 1)
                }
            }
            <<< TextRow(){[unowned self] in
                $0.title = "昵称"
                $0.placeholder = "请输入"
                $0.value = User.current.nickname
                $0.onChange { (row) in
                    let nickname = row.value ?? ""
                    self.info.nickname = nickname
                }
            }
            <<< DateRow(){[unowned self] in
                $0.title = "生日"
                $0.value = User.current.birthDay
                $0.onChange { (row) in
                    self.info.birthDay = row.value
                }
            }
            +++ Section("签名")
            <<< TextAreaRow(){ [unowned self] in
                $0.placeholder = "请输入"
                $0.value = User.current.signature
                $0.onChange { (row) in
                    let sign = row.value ?? ""
                    self.info.signature = sign
                }
            }
            +++ Section("")
            <<< ButtonRow(){
                $0.title = "保存"
                $0.onCellSelection { [unowned self] (cell, row) in
                    self.save()
                }
                
            }
    }


    
    func save(){
        //保存头像
        saveAvatar()
    }
    
    func saveAvatar(){
        if let data = info.avatarData {
            let file = LCFile.init(payload: .data(data: data))
            _ = file.save {[weak self] result in
                switch result {
                case .success:
                    print("文件保存完成。objectId：" + (file.objectId?.value ?? ""))
                    self?.saveInfo(file)
                case .failure(error: let error):
                    // 保存失败，可能是文件无法被读取，或者上传过程中出现问题
                    print(error)
                }
            }
        }
    }
    
    
    func saveInfo(_ file : LCFile){
        
        let user = User.current.info!
        do {
            try user.set("nickname", value: info.nickname)
            try user.set("birthDay", value: info.birthDay)
            try user.set("avatar", value: file)
            try user.set("signature", value: info.signature)
            
            user.save {[weak self] (result) in
                switch result {
                case .success:
                    print("保存成功")
                    //需要更新用户数据
                    NotificationCenter.default.post(name: kUpdateUserData, object: nil)
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        }catch {
            
        }
        
    }
    
    func updateData(){
        let user = User.current.info!
        
        info.signature = user.get("signature")?.stringValue
        
        info.birthDay = user.get("birthDay")?.dateValue
        
        info.nickname = user.get("nickname")?.stringValue
        
        info.avatarData = user.get("avatar")?.dataValue
        
        
        
    }

}
