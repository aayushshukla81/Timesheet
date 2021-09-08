//
//  Assigntasksvc.swift
//  Timesheet
//
//  Created by hannan parvez on 16/02/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit
import SearchTextField
import SQLite3
class Assigntasksvc: apicalls,UITableViewDelegate,UITableViewDataSource {
    var dataset=[taskitem]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataset.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! taskcell
        cell.client.text=dataset[indexPath.row].client
        cell.task.text=dataset[indexPath.row].task
        cell.project.text=dataset[indexPath.row].project
        return cell
    }
    
    
    
    @IBOutlet var searchhproduct: SearchTextField!
    @IBOutlet var searchclient: SearchTextField!
    @IBOutlet var tasktable: UITableView!
    @IBOutlet var searchproductview: UIView!
    @IBOutlet var searchclientview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title=self.userDefaults.value(forKey: "Resource_Name") as! String
        gettasktable()
        bindclients()
        bindprojects()
        customizesearchfields(withname: searchhproduct)
        customizesearchfields(withname: searchclient)
        let borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        searchproductview.layer.borderColor = borderColor.cgColor;
        searchproductview.layer.borderWidth = 2.0;
        searchproductview.layer.cornerRadius = 15.0;
        searchclientview.layer.borderColor = borderColor.cgColor;
        searchclientview.layer.borderWidth = 2.0;
        searchclientview.layer.cornerRadius = 15.0;
        tasktable.delegate=self
        tasktable.dataSource=self
        searchclient.inputAccessoryView=DoneToolBar
        searchhproduct.inputAccessoryView=DoneToolBar
        searchclient.itemSelectionHandler={ item,itemPosition in
                   self.searchclient.text=item[itemPosition].title
            self.updatetasktable(whereclause: item[itemPosition].title, from: "clients")
               }
        searchhproduct.itemSelectionHandler={ item,itemPosition in
            self.searchhproduct.text=item[itemPosition].title
            self.updatetasktable(whereclause: item[itemPosition].title, from: "projects")
        }
        // Do any additional setup after loading the view.
    }
    var clientdataset=[SearchTextFieldItem]()
    func bindclients(){
        clientdataset.removeAll()
        opendatabase()
               var stmt1: OpaquePointer?
               var q1="Select distinct client from AssignTask"
               if sqlite3_prepare_v2(db, q1, -1, &stmt1, nil) != SQLITE_OK{
                          let errmsg = String(cString: sqlite3_errmsg(db)!)
                          print("error preparing get: \(errmsg)")
                          sqlite3_finalize(stmt1)
                          sqlite3_close(db)
                          
                          return
                      }
                      var client:String?
                      
                      while(sqlite3_step(stmt1) == SQLITE_ROW){
                          client = String(cString: sqlite3_column_text(stmt1, 0))
                          
                        clientdataset.append(SearchTextFieldItem(title: client!))
                          
                      }
                      sqlite3_finalize(stmt1)
                      sqlite3_close(db)
        self.searchclient.filterItems(clientdataset)
    }
    var projectdataset=[SearchTextFieldItem]()
    func bindprojects(){
        projectdataset.removeAll()
             opendatabase()
                    var stmt1: OpaquePointer?
                    var q1="Select distinct project from AssignTask"
                    if sqlite3_prepare_v2(db, q1, -1, &stmt1, nil) != SQLITE_OK{
                               let errmsg = String(cString: sqlite3_errmsg(db)!)
                               print("error preparing get: \(errmsg)")
                               sqlite3_finalize(stmt1)
                               sqlite3_close(db)
                               
                               return
                           }
                           var project:String?
                           
                           while(sqlite3_step(stmt1) == SQLITE_ROW){
                               project = String(cString: sqlite3_column_text(stmt1, 0))
                               
                             projectdataset.append(SearchTextFieldItem(title: project!))
                               
                           }
                           sqlite3_finalize(stmt1)
                           sqlite3_close(db)
             self.searchhproduct.filterItems(projectdataset)
        
    }
    func  gettasktable(){
        dataset.removeAll()
        opendatabase()
        var stmt1: OpaquePointer?
        var q1="Select client,task,project from AssignTask"
        if sqlite3_prepare_v2(db, q1, -1, &stmt1, nil) != SQLITE_OK{
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("error preparing get: \(errmsg)")
                   sqlite3_finalize(stmt1)
                   sqlite3_close(db)
                   
                   return
               }
               var client:String?
               var task:String?
               var project:String?
               
               while(sqlite3_step(stmt1) == SQLITE_ROW){
                   client = String(cString: sqlite3_column_text(stmt1, 0))
                   task = String(cString: sqlite3_column_text(stmt1, 1))
                   project = String(cString: sqlite3_column_text(stmt1, 2))
                   
                dataset.append(taskitem(client: client!, task: task!, project: project!))
                   
               }
               sqlite3_finalize(stmt1)
               sqlite3_close(db)
        tasktable.reloadData()
    }
    func  updatetasktable(whereclause:String,from:String){
        dataset.removeAll()
        opendatabase()
        var stmt1: OpaquePointer?
        var q1=""
        if from=="projects"{
            q1="Select client,task,project from AssignTask where project='"+whereclause+"'"
        }
        if from=="clients"{
            q1="Select client,task,project from AssignTask where client='"+whereclause+"'"
        }
       
        if sqlite3_prepare_v2(db, q1, -1, &stmt1, nil) != SQLITE_OK{
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("error preparing get: \(errmsg)")
                   sqlite3_finalize(stmt1)
                   sqlite3_close(db)
                   
                   return
               }
               var client:String?
               var task:String?
               var project:String?
               
               while(sqlite3_step(stmt1) == SQLITE_ROW){
                   client = String(cString: sqlite3_column_text(stmt1, 0))
                   task = String(cString: sqlite3_column_text(stmt1, 1))
                   project = String(cString: sqlite3_column_text(stmt1, 2))
                   
                dataset.append(taskitem(client: client!, task: task!, project: project!))
                   
               }
               sqlite3_finalize(stmt1)
               sqlite3_close(db)
        tasktable.reloadData()
    }
    @IBAction func backbutton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearsearch(_ sender: UIButton) {
        gettasktable()
        if sender.tag==0{
            searchclient.text=""
        }
        else{
            searchhproduct.text=""
        }
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
