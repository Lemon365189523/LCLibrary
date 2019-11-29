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


class AddArticleViewController: FormViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form
            +++ TextRow(){[unowned self] in
                $0.title = "标题"
                $0.placeholder = "请输入"
                $0.tag = "InputTitleRow"
                $0.onChange { (row) in
                   
                }
            }
            +++ Section("内容")
            <<< TextAreaRow(){ [unowned self] in
                $0.placeholder = "请输入"
                $0.tag = "InputContentRow"
                $0.onChange { (row) in
                    let sign = row.value ?? ""
                }
            }
            +++ Section("")
            <<< ButtonRow(){
                $0.title = "保存"
                $0.onCellSelection { [unowned self] (cell, row) in
                    let textRow : TextAreaRow? = self.form.rowBy(tag: "InputContentRow")
                    let titleTow : TextRow? = self.form.rowBy(tag: "InputTitleRow")
                    guard let content = textRow?.value , let title = titleTow?.value else {return}
                    self.save(title ,content: content)
                }
            }
        
    }
    
    func save(_ title : String , content : String){
        
        let article = LCObject(className: "Articles")
        
//        let todo.set()
        
    }
}
