//
//  LoginViewController.swift
//  LCDemo
//
//  Created by chuda on 2019/11/20.
//  Copyright © 2019 LeanCloud. All rights reserved.
//

import UIKit
import LeanCloud

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func clickLoginButton(_ sender: Any) {
        
        guard let name = phoneTextField.text else {
            print("请输入用户名")
            return
        }
        
        guard let password = passwordTextField.text else {
            print("请输入密码")
            return
        }
        
        _ = LCUser.logIn(username: name, password: password, completion: { (result) in
            switch result {
            case .success(let object):
                User.current.token = object.sessionToken?.value ?? ""
                User.current.info = object
                print("登录成功")
                let home = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
                let keyWindow = UIApplication.shared.keyWindow
                keyWindow?.rootViewController = home
                keyWindow?.makeKeyAndVisible()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
        
    }
    

}
