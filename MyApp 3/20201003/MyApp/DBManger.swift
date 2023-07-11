//
//  DBManager.swift
//  MyApp
//
//  Created by cs_mac on 2020/07/22.
//  Copyright © 2020 cs_mac. All rights reserved.
//

import Foundation
import SQLite3
class DBManager {
    
    var db : OpaquePointer?
    let DB_NAME = "app_db.sqlite"
    let TABLE_NAME = "app_table"
    var dto: TaskDto!
    
//    앱을 실행할 때 수행
    func initDatabase() {
        openDatabase()
        createTable()
        closeDatabase()
    }
    
//    DB 사용 전에 호출
    private func openDatabase() {
        let dbFile = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(DB_NAME)
        if sqlite3_open(dbFile.path, &db) == SQLITE_OK{
            print("Successfully Opened")
            print(dbFile)
        } else {
            print("Unable to open DB")
        }
        
    }
    
//    테이블 생성
    private func createTable() {
        let createTableString = """
 CREATE TABLE IF NOT EXISTS \(TABLE_NAME) ( id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date INTEGER, detail TEXT, icon TEXT);
 """
        
        var createTableStmt: OpaquePointer?
        
        print("TABLE SQL: \(createTableString)")
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStmt, nil) == SQLITE_OK{
            if sqlite3_step(createTableStmt) == SQLITE_DONE{
                print("Successfully created.")
            }
            sqlite3_finalize(createTableStmt)
        } else {
            let error = String(cString: sqlite3_errmsg(db)!)
            print("Table Error: \(error)")
        }
        
    }
    
//    DB 완료 후 호출
    private func closeDatabase() {
        if sqlite3_close(db) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Database Close Error: \(errmsg)")
            return
        }
        
    }
    
//    items 배열에 DB의 내용 전체를 추가
    func readAllData() {
//        샘플이므로 DB 구현 시 주석 처리
        openDatabase()
//        샘플이므로 DB 구현 시 주석 처리
        //items.append(TaskDto(id: 1, title: "hello", date: 1625728889, detail: "hi", icon: "clock.png"))
        //items.append(TaskDto(id: 2, title: "안녕하세요", date: 1625728889, detail: "안녕", icon: "cart.png"))
       
        let sql = "select * from \(TABLE_NAME)"
        var queryStmt: OpaquePointer?
        
        if sqlite3_prepare(db, sql, -1, &queryStmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Reading Error: \(errmsg)")
            return
        }
        
        while(sqlite3_step(queryStmt) == SQLITE_ROW){
            let id = sqlite3_column_int(queryStmt, 0)   //0번쩨 컬럼을 읽어오겠다(즉, id를 읽어오겠다)
            let title = String(cString: sqlite3_column_text(queryStmt, 1))
            let date = sqlite3_column_int(queryStmt, 2)
            let detail = String(cString: sqlite3_column_text(queryStmt, 3))
            let icon = String(cString: sqlite3_column_text(queryStmt, 4))
            dto = TaskDto(id: Int(id), title: title, date: date, detail: detail, icon: icon)
            items.append(dto)
            
        }
        sqlite3_finalize(queryStmt)
        closeDatabase()
    }

//    항목 추가
    func insertData(title: String, date: Int32, detail: String, icon: String){
        openDatabase()
        var insertStmt: OpaquePointer?

        let sql = "INSERT INTO \(TABLE_NAME) Values (null, ?, ?, ?, ?)"
        let t = title
        let d = detail
        
        if sqlite3_prepare_v2(db, sql, -1,  &insertStmt, nil) == SQLITE_OK{
            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

            if sqlite3_bind_text(insertStmt, 1, t, -1, SQLITE_TRANSIENT) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("Text Binding Failure: \(errmsg)")
                return
            }
            if sqlite3_bind_int(insertStmt, 2, date) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("Text Binding Failure: \(errmsg)")
                return
            }
            if sqlite3_bind_text(insertStmt, 3, d, -1, SQLITE_TRANSIENT) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("Text Binding Failure: \(errmsg)")
                return
            }
            if sqlite3_bind_text(insertStmt, 4, icon , -1, SQLITE_TRANSIENT) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("Text Binding Failure: \(errmsg)")
                return
            }
            if sqlite3_step(insertStmt) == SQLITE_DONE{
                print("Successfully inserted.")
            } else {
                print("insert error")
            }
            sqlite3_finalize(insertStmt)
        
        } else {
           print("Insert statment is not prepared.")
        }
        closeDatabase()
    }


    
//    항목 수정
    func updateData(id: Int32, title: String, detail: String){
        openDatabase()
        let query = "update \(TABLE_NAME) set title = ?, detail = ? where id = ?"
        
        var updateStmt: OpaquePointer?
        
        if sqlite3_prepare(db, query, -1, &updateStmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing update: \(errmsg)")
            return
        }
        
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
      
        if sqlite3_bind_text(updateStmt, 1, title, -1, SQLITE_TRANSIENT) != SQLITE_OK{ let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing Failure: \(errmsg)")
            return
        }
        if sqlite3_bind_text(updateStmt, 2, detail, -1, SQLITE_TRANSIENT) != SQLITE_OK{ let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing Failure: \(errmsg)")
            return
        }

        if sqlite3_bind_int(updateStmt, 3, id) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Integer Binding Failure: \(errmsg)")
            return
        }
        
        if sqlite3_step(updateStmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Update Failure: \(errmsg)")
            return
        } else{
            print("Updated Successfully")
        }
        
        sqlite3_finalize(updateStmt)
        closeDatabase()
    }
    
//    항목 삭제
    func deleteData(id: Int32){
        openDatabase()
        let query = "delete from \(TABLE_NAME) where id = ?"
        var deleteStmt: OpaquePointer?
        
        if sqlite3_prepare(db, query, -1, &deleteStmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing stmt: \(errmsg)")
            return
        }
        
        if sqlite3_bind_int(deleteStmt, 1, id) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Integer Binding Failure: \(errmsg)")
            return
        }
        
        if sqlite3_step(deleteStmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Delete Failure: \(errmsg)")
            return
        }
        
        sqlite3_finalize(deleteStmt)
        closeDatabase()
    }
}
