//
//  AppDelegate.swift
//  LCDemo
//
//  Created by chuda on 2019/11/20.
//  Copyright © 2019 LeanCloud. All rights reserved.
//

import UIKit
import LeanCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        do {
            try LCApplication.default.set(id: "osf7vJkLyBsxk3HXM7S5y7ro-gzGzoHsz",
                                          key: "158HIwOQMDDK0m7YOtKDMgzH",
                                          serverURL: "https://osf7vjkl.lc-cn-n1-shared.com")
        }catch{
            print(error)
        }
//        LCApplication.logLevel = .debug
        setRootViewController()
        return true
    }
    
    
    
    func setRootViewController(){
        //主动退出登录
        //LCUser.logOut()
        
        // 验证用户有没有过期
        _ = LCUser.logIn(sessionToken: User.current.token, completion: {[weak self] (result) in
            self?.window = UIWindow.init(frame: UIScreen.main.bounds)
            switch result {
                case .success(object: let user):
                    // 登录成功
                    User.current.info = user
                    let home = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
                    self?.window?.rootViewController = home
                    print(user)
                case .failure(error: let error):
                    let login = UIStoryboard.init(name: "Login", bundle: nil).instantiateInitialViewController()
                    self?.window?.rootViewController = login
                    print(error)
                }
            self?.window?.makeKeyAndVisible()
        })
       

    }


}

