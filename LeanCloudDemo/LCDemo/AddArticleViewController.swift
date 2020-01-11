//
//  AddArticleViewController.swift
//  LCDemo
//
//  Created by chuda on 2019/11/29.
//  Copyright © 2019 LeanCloud. All rights reserved.
//

import UIKit
import Eureka
import LeanCloud


struct AtricleModel {
    var title : String = ""
    var content : String = ""
    var images : [UIImage] = []
    var date : Date = Date()
}


class AddArticleViewController: FormViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form
            +++ TextRow(){
                $0.title = "标题"
                $0.placeholder = "请输入"
                $0.tag = "InputTitleRow"
            }
            +++ Section("内容")
            <<< TextAreaRow(){
                $0.placeholder = "请输入"
                $0.tag = "InputContentRow"
            }
            +++ Section("")
            <<< ImageRow() {
                $0.title = "选择图片"
//                row.value = UIImage(named: "avatar")
                $0.sourceTypes = [.PhotoLibrary, .Camera]
                $0.tag = "ImageRow"
            }
            +++ Section("")
            <<< ButtonRow(){
                $0.title = "保存"
                $0.onCellSelection { [unowned self] (cell, row) in
                    let textRow : TextAreaRow? = self.form.rowBy(tag: "InputContentRow")
                    let titleTow : TextRow? = self.form.rowBy(tag: "InputTitleRow")
                    let imageRow : ImageRow? = self.form.rowBy(tag: "ImageRow")
                    guard let content = textRow?.value , let title = titleTow?.value else {return}
                    self.save(title ,content: content, image: imageRow?.value)
                }
            }
        
    }
    
    func save(_ title : String , content : String , image : UIImage?){
    
        
        
        do {
            let article = LCObject(className: "Articles")
            try article.set("title", value: title)
            try article.set("content", value: content)
            try article.set("date",value: Date())
            try article.set("author", value: User.current.info!)
            
            if let data = image?.jpegData(compressionQuality: 0.1) {
                
                let file = LCFile.init(payload: .data(data: data))
                _ = file.save {[weak self] result in
                    switch result {
                    case .success:
                        print("文件保存完成。objectId：" + (file.objectId?.value ?? ""))
//                        self?.saveInfo(file)
                    case .failure(error: let error):
                        // 保存失败，可能是文件无法被读取，或者上传过程中出现问题
                        print(error)
                    }
                }
                
            }else{
                
            }
            
            
            article.save {[weak article] (result) in
                switch result {
                    
                case .success:
                    print(article?.objectId?.value ?? "没有id")
                case .failure(let error):
                    print(error)
                    
                }
            }
        }catch {
            print(error)
        }
        
    }
}
