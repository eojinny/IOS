//
//  DBManager.swift
//  DataBaseTest
//
//  Created by CSMAC09 on 2023/07/10.
//

import Foundation
import SQLite3

class DBManager{
    let DB_NAME = "my_db.sqlite"
    let TABLE_NAME = "my_table"
    let COL_ID = "id"
    let COL_NAME = "name"
    
   
    
    var db: OpaquePointer? = nil
    
    func initDatabase(){
        openDatebase()
        createTable()
    }
    
    private func openDatebase(){
        let dbFile = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(DB_NAME)
        
        if sqlite3_open(dbFile.path, &db) == SQLITE_OK {
            print("Successfully Opened")
            print(dbFile)
        }else {
            print("Unable to open DB")
        }
        
    }
    
    private func createTable(){
        let createTableString = """
CREATE TABLE IF NOT EXISTS \(TABLE_NAME) ( \(COL_ID) INTEGER PRIMARY KEY AUTOINCREMENT, \(COL_NAME) TEXT);
"""
        var createTableStmt:OpaquePointer?
        print("Table sql: \(createTableString)")
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStmt, nil) == SQLITE_OK {
            if sqlite3_step(createTableStmt) == SQLITE_DONE {
                print("Successfully created.")
            }
            sqlite3_finalize(createTableStmt)
        }else{
            let error = String(cString: sqlite3_errmsg(db)!)
            print("Table Error : \(error)")
        }
        
    }
    
    func insert(){
        var insertStmt : OpaquePointer?
        
        if sqlite3_prepare_v2(db,"insert into \(TABLE_NAME) values (null, ?)", -1 , &insertStmt, nil) == SQLITE_OK{
            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
            
            if sqlite3_bind_text(insertStmt, 1, "test1", -1, SQLITE_TRANSIENT) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("Text Binding Failure: \(errmsg)")
                return
            }
            if sqlite3_step(insertStmt) == SQLITE_DONE{print("Success inserted")}
            else {print("insert error")}
            sqlite3_finalize(insertStmt)
        }else{print("Insert stmt is not prepare")}
        
    }
    
    func selectAll(){
        let sql = "select * from \(TABLE_NAME)"
        var queryResult: OpaquePointer?
        
        if sqlite3_prepare(db, sql, -1, &queryResult, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Reading Error : \(errmsg)")
            return
        }
        
        while(sqlite3_step(queryResult) == SQLITE_ROW){
            let id = sqlite3_column_int(queryResult,0)
            let name = String(cString: sqlite3_column_text(queryResult, 1))
            print("id: \(id) name: \(name)")
            
        }
        sqlite3_finalize(queryResult)
        
    }
    
    func update(){
        let query = "update \(TABLE_NAME) set \(COL_NAME) = ? where \(COL_ID) = ?"
        
        var updatestmt: OpaquePointer?
        
        if sqlite3_prepare(db, query, -1, &updatestmt, nil) != SQLITE_OK{
            let errmsg = String(cString:  sqlite3_errmsg(db)!)
            print("error preparing update : \(errmsg)")
            return
        }
        bindTextParams(updatestmt!, no: 1, param: "my_id")
        bindIntParams(updatestmt!, no: 2, param: 1)
        
        if sqlite3_step(updatestmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Update failure: \(errmsg)")
            return
        }
        
        sqlite3_finalize(updatestmt)
    }
    
    func delete(){
        let query = "delete from \(TABLE_NAME) where \(COL_ID) = ?"
        var deleteStmt: OpaquePointer?
        
        if sqlite3_prepare(db, query, -1, &deleteStmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing stmt: \(errmsg)")
        }
        bindIntParams(deleteStmt!, no: 1, param: 5)
        
        if sqlite3_step(deleteStmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Delete Failure: \(errmsg)")
            return
        }

        
        sqlite3_finalize(deleteStmt)
        
    }
    
    func closeDatebase(){
        if sqlite3_exec(db, "drop table if exists \(TABLE_NAME)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Drop Failure: \(errmsg)")
            return
        }
        
        if sqlite3_close(db) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Database Close Failure: \(errmsg)")
            return
        }
    }
    
    
    func bindTextParams(_ stmt: OpaquePointer, no: Int, param:String){
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        if sqlite3_bind_text(stmt, Int32(no), param, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Txt Binding Failure: \(errmsg)")
            return
        }
    }
    
    func bindIntParams(_ stmt: OpaquePointer, no: Int, param:Int){
        if sqlite3_bind_int(stmt, Int32(no), Int32(param)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Txt Binding Failure: \(errmsg)")
            return
        }
    }
}
