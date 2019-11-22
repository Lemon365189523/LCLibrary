//
//  RegisterViewController.swift
//  LCDemo
//
//  Created by chuda on 2019/11/20.
//  Copyright © 2019 LeanCloud. All rights reserved.
//

import UIKit
import LeanCloud

class RegisterViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickRegisterButton(_ sender: Any) {
        guard let name = phoneTextField.text else {
            print("请输入用户名")
            return
        }
        
        guard let password = passwordTextField.text else {
            print("请输入密码")
            return
        }
        
        // 创建实例
        let user = LCUser()

        // 等同于 user.set("username", value: "Tom")
        user.username = LCString(name)
        user.password = LCString(password)
        
        // 可选
        //user.set("email", value: "tom@leancloud.rocks")
        //user.set("mobilePhoneNumber", value: "+8618200008888")
        
        _ = user.signUp { [weak self] (result) in
            switch result {
                
            case .success:
                print("注册成功")
                self?.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
  


}
