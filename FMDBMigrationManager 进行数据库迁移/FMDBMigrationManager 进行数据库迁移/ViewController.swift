//
//  ViewController.swift
//  FMDBMigrationManager 进行数据库迁移
//
//  Created by smile on 17/3/8.
//  Copyright © 2017年 itcast. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func userTest(){
        let sql = "INSERT INTO USer (name,age,sex,phoneNum) VALUES (?,?,?,?)"
        let a = arc4random()%100000
        let b = arc4random()%222222
        FFFMDBManager.shared.queue?.inDatabase({ (db) in
            let result = db?.executeUpdate(sql, withArgumentsIn: [a,b,1,"wwwwwwww"])
            if result != nil {
                print("添加数据成功")
            }else{
                print("添加数据失败")
            }
        })
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 升级检测
        FFFMDBManager.shared.fmdbUpgrade()
    }
    
    func testDemo(){
        let sql = "INSERT INTO T_Home (userid,statusid,status) VALUES (?,?,?)"
        
        let a = arc4random()%100000
        let b = arc4random()%222222
        FFFMDBManager.shared.queue?.inDatabase({ (db) in
            let result = db?.executeUpdate(sql, withArgumentsIn: [a,b,"qwwqwwqww"])
            if result != nil {
                print("添加数据成功")
            }else{
                print("添加数据失败")
            }
        })
    }
}

