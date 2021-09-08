//
//  dailyschedulevc.swift
//  Timesheet
//
//  Created by hannan parvez on 29/02/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import WWCalendarTimeSelector
import FloatingSearchTextLabelField
import SQLite3
import  UIFloatLabelTextView
import ChameleonFramework
class dailyschedulevc: apicalls,WWCalendarTimeSelectorProtocol {
    var picker=WWCalendarTimeSelectorDateRange()
       var whichlabelpressed="checkindate"
    
    
    @IBOutlet var titlebox: FloatingSearchTextField!
    @IBOutlet var detailsview: UIStackView!
    @IBOutlet var descriptionbox: UIFloatLabelTextView!
    @IBOutlet var worktype: FloatingSearchTextField!
    @IBOutlet var project: FloatingSearchTextField!
    @IBOutlet var client: FloatingSearchTextField!
    @IBOutlet var checkouttime: SkyFloatingLabelTextField!
       @IBOutlet var checkintime: SkyFloatingLabelTextField!
       @IBOutlet var checkoutdate: SkyFloatingLabelTextField!
       @IBOutlet var checkindate: SkyFloatingLabelTextField!
    override func viewDidAppear(_ animated: Bool) {
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: detailsview.frame.height - 1, width: detailsview.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        detailsview.layer.addSublayer(bottomLine)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionbox.inputAccessoryView=DoneToolBar
        descriptionbox.layer.borderColor=UIColor.gray.cgColor
        
        descriptionbox.placeholder = "DETAILED DESCRIPTION";
        descriptionbox.floatLabelActiveColor = HexColor(hexString: "#278C81")
        descriptionbox.floatLabelPassiveColor = UIColor.lightGray
        descriptionbox.textAlignment = .left
        descriptionbox.layer.borderColor = UIColor.gray.cgColor
        descriptionbox.font = UIFont(name: "System", size: 14.0)
        descriptionbox.floatLabel.font = UIFont(name: "Helvetica", size: 12.0)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        bindclients()
        bindworktype()
        client.itemSelectionHandler={ item,itemPosition in
                   self.client.text=item[itemPosition].title
                   self.bindprojects(client: item[itemPosition].title)
               }
              
        customizesearchfields(withname: client)
        customizesearchfields(withname: worktype)
        customizesearchfields(withname: project)
        client.inputAccessoryView=DoneToolBar
        project.inputAccessoryView=DoneToolBar
        worktype.inputAccessoryView=DoneToolBar
        titlebox.inputAccessoryView=DoneToolBar
        worktype.maxResultsListHeight=200
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
               self.navigationController?.navigationBar.titleTextAttributes = textAttributes
               self.navigationItem.title=self.userDefaults.value(forKey: "Resource_Name") as! String
        let checkindatetap=UITapGestureRecognizer(target: self, action: #selector(checkindatetapped))
               checkindate.addGestureRecognizer(checkindatetap)
        let checkoutdatetap=UITapGestureRecognizer(target: self, action: #selector(checkoutdatetapped))
                      checkoutdate.addGestureRecognizer(checkoutdatetap)
        let checkintimetap=UITapGestureRecognizer(target: self, action: #selector(checkintimetapped))
        checkintime.addGestureRecognizer(checkintimetap)
        let checkouttimetap=UITapGestureRecognizer(target: self, action: #selector(checkouttimetapped))
        checkouttime.addGestureRecognizer(checkouttimetap)
        // Do any additional setup after loading the view.
    }
    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 150
            }
        }
    }
    var worktypedataset=[SearchTextFieldItem]()
    func bindworktype(){
        opendatabase()
               var stmt1: OpaquePointer?
               var q1="Select * from WorkType"
               if sqlite3_prepare_v2(db, q1, -1, &stmt1, nil) != SQLITE_OK{
                          let errmsg = String(cString: sqlite3_errmsg(db)!)
                          print("error preparing get: \(errmsg)")
                          sqlite3_finalize(stmt1)
                          sqlite3_close(db)
                          
                          return
                      }
                      var id:String?
                      var work_ID:String?
                      var work:String?
                      while(sqlite3_step(stmt1) == SQLITE_ROW){
                          id = String(cString: sqlite3_column_text(stmt1, 0))
                         work_ID = String(cString: sqlite3_column_text(stmt1, 1))
                         work = String(cString: sqlite3_column_text(stmt1, 2))
                          
                        worktypedataset.append(SearchTextFieldItem(title: work!))
                          
                      }
                      sqlite3_finalize(stmt1)
                      sqlite3_close(db)
        self.worktype.filterItems(worktypedataset)
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
           self.client.filterItems(clientdataset)
       }
       var projectdataset=[SearchTextFieldItem]()
       func bindprojects(client:String){
           projectdataset.removeAll()
                opendatabase()
                       var stmt1: OpaquePointer?
                       var q1="Select distinct project from AssignTask where client='"+client+"'"
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
                self.project.filterItems(projectdataset)
           
       }
    @objc func checkintimetapped(){
           whichlabelpressed="checkintime"
          showtimepicker(context: self)
       }
       @objc func checkouttimetapped(){
           whichlabelpressed="checkouttime"
          showtimepicker(context: self)
       }
       @objc func checkindatetapped(){
           whichlabelpressed="checkindate"
           showdatepicker(context: self)
       }
       @objc func checkoutdatetapped(){
           whichlabelpressed="checkoutdate"
           showdatepicker(context: self)
       }
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
         var formatarray = Array(selector.timeLabel.text!)
         var deli=formatarray[formatarray.count-2]
         print (deli)
        
         var singleDate = date
            let dateFormatter = DateFormatter()
          
         if  whichlabelpressed=="checkindate"{
             dateFormatter.dateFormat = "dd-MM-yyyy"
             checkindate.text = dateFormatter.string(from: date)
         }
         else if whichlabelpressed=="checkoutdate" {
             dateFormatter.dateFormat = "dd-MM-yyyy"
             checkoutdate.text = dateFormatter.string(from: date)
         }
         else if whichlabelpressed=="checkouttime"{
             if deli=="p"{
                 dateFormatter.dateFormat = "HH:mm:ss"
                 checkouttime.text = dateFormatter.string(from: date)
             }
             else{
                 dateFormatter.dateFormat = "hh:mm:ss"
                 checkouttime.text = dateFormatter.string(from: date)
             }
             
         }
         else{
             if deli=="p"{
                 dateFormatter.dateFormat = "HH:mm:ss"
                 checkintime.text = dateFormatter.string(from: date)
             }
             else{
                 dateFormatter.dateFormat = "hh:mm:ss"
                 checkintime.text = dateFormatter.string(from: date)
             }
         }
           
       }
    @IBAction func goback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
