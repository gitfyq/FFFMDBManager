//
//  FFFMDBManager.swift
//  FMDBMigrationManager 进行数据库迁移
//
//  Created by smile on 17/3/8.
//  Copyright © 2017年 itcast. All rights reserved.
//

import UIKit
// 数据库名称
private let dbName = "test.db"
class FFFMDBManager {
    // 全局访问点
    static let shared:FFFMDBManager = FFFMDBManager()
    let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent(dbName)
    // 以串行队列方式调度数据库 (代表打开数据库,已经打开 不在关闭)
    var queue: FMDatabaseQueue?
    
    // 实现init
    init() {
        // 路径
        
        print(path)
        queue = FMDatabaseQueue(path: path)
        createTable()
    }
    
    // 创建数据库的表
    private func createTable(){
        // 得到文件
        let file = Bundle.main.path(forResource: "db.sql", ofType: nil)!
        
        // 准确sql
        let sql = try! String(contentsOfFile: file)
        // 执行sql
        queue?.inDatabase({ (db) in
            let result = db?.executeStatements(sql)
            if result == false{
                print("创建表失败")
            }else{
                print("创建表成功")
            }
        })
        
    }
}

extension FFFMDBManager{
    func fmdbUpgrade(){
        let manager = FMDBMigrationManager(databaseAtPath: path, migrationsBundle: Bundle.main)
        
        // 创建新表
        let migration1:FFMigration = FFMigration(name: "USer", version: 1, executeUpdateArray: ["create table User(name text,age integer,sex text,phoneNum text)"])
        
        manager?.addMigration(migration1)
        // 创建新表
        let migration2:FFMigration = FFMigration(name: "HUSer", version: 2, executeUpdateArray: ["create table HUSer(name text,age integer,sex text,phoneNum text)"])
        
        manager?.addMigration(migration2)
        
        // 原表加字段
        let migration3:FFMigration = FFMigration(name: "USer", version: 3, executeUpdateArray: ["alter table USer add email text"])
        
        manager?.addMigration(migration3)
        
        // 原表加字段
        let migration4:FFMigration = FFMigration(name: "USer", version: 4, executeUpdateArray: ["alter table USer add xxx text"])
        
        manager?.addMigration(migration4)
        // 原表加字段
        let migration5: FFMigration = FFMigration(name: "USer", version: 5, executeUpdateArray: ["alter table USer add yyyy text"])
        manager?.addMigration(migration5)
        
        var resultState = false
        
        if  manager?.hasMigrationsTable != true {
            resultState = ((try! manager?.createMigrationsTable()) != nil)
            
            
        }
        
        resultState = ((try! manager?.migrateDatabase(toVersion: UINT64_MAX, progress: nil)) != nil)
        print("执行是否成功",resultState)
    }
}
