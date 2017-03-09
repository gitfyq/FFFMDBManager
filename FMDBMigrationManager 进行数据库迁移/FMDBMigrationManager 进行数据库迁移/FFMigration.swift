//
//  FFMigration.swift
//  FMDBMigrationManager 进行数据库迁移
//
//  Created by smile on 17/3/8.
//  Copyright © 2017年 itcast. All rights reserved.
//

import UIKit

class FFMigration: NSObject,FMDBMigrating {
    
    var name: String{
        return myName ?? ""
    }
    
    var version: UInt64{
        return myVersion ?? 0
    }
    
    fileprivate var myName: String?
    
    fileprivate var myVersion:UInt64?
    
    fileprivate var updateArray:[Any]?

    /// 重载构造函数
    ///
    /// - Parameters:
    ///   - name: 创建的表名或者修改的表名
    ///   - version: 版本号 递增的形式(1,2,3,4)
    ///   - executeUpdateArray: 执行的sql语句
    init(name: String,version:UInt64, executeUpdateArray:[Any]?) {
        myName = name
        myVersion = version
        updateArray = executeUpdateArray
        super.init()
    }
    // fatal error: use of unimplemented initialize
    override init() {
        super.init()
    }
    // 协议方法执行sql语句
    func migrateDatabase(_ database: FMDatabase!) throws {
        
        for updateStr in updateArray! {
            print(updateStr)
            database.executeStatements(updateStr as! String)
        }
        
    }

}
