//
//  dbconnections.swift
//  Timesheet
//
//  Created by hannan parvez on 03/03/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit
import SQLite3
class dbconnections: BaseActivity {
    var db: OpaquePointer?
    let fileURL = try! FileManager.default
        .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        .appendingPathComponent("timesheet.sqlite")
    
    func opendatabase(){
        print(fileURL)
        guard sqlite3_open(self.fileURL.path, &db) == SQLITE_OK else {
            print("dbconnectionfileerror opening database")
            sqlite3_close(db)
           
            db = nil
            return
        }
    }
    
     func createAssignTaskTable(){
            opendatabase()
        if sqlite3_exec(db, "create table if not exists AssignTask(id integer primary key autoincrement,job_Id text unique,task_Id text,activity_Date text,financial_Year text,resource_Id text,resource text,task text,job text,segment_Id text,segment text,product_Id text,product text,client_Id text,client text,project_Id text,project text)", nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("dbconnectionfileerror AssignTask  table: \(errmsg)")
            }
            sqlite3_close(db)
           
        
            
        }
    func insertintoAssignTaskTable(job_Id:String,task_Id:String,activity_Date:String,financial_Year:String,resource_Id:String,resource:String,task:String,job:String,segment_Id:String,segment:String,product_Id:String,product:String,client_Id:String,client:String,project_Id:String,project:String){
           
           opendatabase()
           let query  = "INSERT INTO AssignTask(job_Id,task_Id,activity_Date,financial_Year,resource_Id,resource,task,job,segment_Id,segment,product_Id,product,client_Id,client,project_Id,project) VALUES ('\(job_Id)','\(task_Id)','\(activity_Date)','\(financial_Year)','\(resource_Id)','\(resource)','\(task)','\(job)','\(segment_Id)','\(segment)','\(product_Id)','\(product)','\(client_Id)','\(client)','\(project_Id)','\(project)') ON CONFLICT(job_Id) DO UPDATE SET  resource='" + resource + "'  where job_Id='" + job_Id + "'"
           
           if sqlite3_exec(db, query, nil, nil, nil) != SQLITE_OK{
               print("dbconnectionfileerror inserting in AssignTask table \(SQLITE_ERROR)")
               return
           }
           else{
               print("data inserted into AssignTask table")
           }
           sqlite3_close(db)
          
           
           
       }
        func createWorkTypeTable(){
                   opendatabase()
               if sqlite3_exec(db, "create table if not exists WorkType(id integer primary key autoincrement,work_Id text unique,work text)", nil, nil, nil) != SQLITE_OK {
                       let errmsg = String(cString: sqlite3_errmsg(db)!)
                       print("dbconnectionfileerror WorkType  table: \(errmsg)")
                   }
                   sqlite3_close(db)
                  
               
                   
               }
           func insertintoWorkTypeTable(work_Id:String,work:String){
                  
                  opendatabase()
                  let query  = "INSERT INTO WorkType(work_Id,work) VALUES ('\(work_Id)','\(work)') ON CONFLICT(work_Id) DO UPDATE SET  work='" + work + "'  where work_Id='" + work_Id + "'"
                  
                  if sqlite3_exec(db, query, nil, nil, nil) != SQLITE_OK{
                      print("dbconnectionfileerror inserting in WorkType table \(SQLITE_ERROR)")
                      return
                  }
                  else{
                      print("data inserted into WorkType table")
                  }
                  sqlite3_close(db)
                 
                  
                  
              }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
