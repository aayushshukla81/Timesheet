//
//  timesheetentryvc.swift
//  Timesheet
//
//  Created by hannan parvez on 16/02/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit
import WWCalendarTimeSelector
import FloatingSearchTextLabelField
import ChameleonFramework
import SkyFloatingLabelTextField
import  UIFloatLabelTextView
import SQLite3
class timesheetentryvc: apicalls,WWCalendarTimeSelectorProtocol,UITextViewDelegate,UITextFieldDelegate {

    @IBOutlet var minute: SkyFloatingLabelTextField!
    @IBOutlet var hour: SkyFloatingLabelTextField!
    @IBOutlet var detailsview: UIStackView!
    @IBOutlet var detaileddescription: UIFloatLabelTextView!
    @IBOutlet var descriptiontext: SkyFloatingLabelTextField!
    @IBOutlet var worktype: FloatingSearchTextField!
    @IBOutlet var task: FloatingSearchTextField!
    @IBOutlet var project: FloatingSearchTextField!
    @IBOutlet var client: FloatingSearchTextField!
    @IBOutlet var datelabel: FloatingSearchTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
               self.navigationController?.navigationBar.titleTextAttributes = textAttributes
               self.navigationItem.title=self.userDefaults.value(forKey: "Resource_Name") as! String
            showdatepicker(context: self)
        bindclients()
        bindworktype()
        let datelabeltap=UITapGestureRecognizer(target: self, action: #selector(datelabeltapped))
        datelabel.addGestureRecognizer(datelabeltap)
        customizesearchfields(withname: client)
        customizesearchfields(withname: project)
        customizesearchfields(withname: task)
        customizesearchfields(withname: worktype)
        hour.inputAccessoryView=DoneToolBar
        minute.inputAccessoryView=DoneToolBar
        hour.delegate=self
        minute.delegate=self
        client.itemSelectionHandler={ item,itemPosition in
            self.client.text=item[itemPosition].title
            self.bindprojects(client: item[itemPosition].title)
        }
        project.itemSelectionHandler={ item,itemPosition in
            self.project.text=item[itemPosition].title
            self.bindtasks(project:  item[itemPosition].title)
        }
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        descriptiontext.inputAccessoryView=DoneToolBar
        detaileddescription.inputAccessoryView=DoneToolBar
        detaileddescription.layer.borderColor=UIColor.gray.cgColor
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: detailsview.frame.height - 1, width: detailsview.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        detailsview.layer.addSublayer(bottomLine)
        detaileddescription.placeholder = "DETAILED DESCRIPTION";
        detaileddescription.floatLabelActiveColor = HexColor(hexString: "#278C81")
        detaileddescription.floatLabelPassiveColor = UIColor.lightGray
        detaileddescription.textAlignment = .left
        detaileddescription.layer.borderColor = UIColor.gray.cgColor
        detaileddescription.font = UIFont(name: "System", size: 14.0)
        detaileddescription.floatLabel.font = UIFont(name: "Helvetica", size: 12.0)
        
        // Do any additional setup after loading the view.
    }
   override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 100
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        if textField.tag==1{
            if newString != "" && Int(newString)!>=60{
                return false
            }
        }
        if newString.count > 2 { //restrict input upto 32 characters
            return false
        }
        return true
    }
    @objc func  datelabeltapped(){
        showdatepicker(context: self)
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
    var taskdataset=[SearchTextFieldItem]()
    func bindtasks(project:String){
        taskdataset.removeAll()
             opendatabase()
                    var stmt1: OpaquePointer?
                    var q1="Select distinct task from AssignTask where project='"+project+"'"
                    if sqlite3_prepare_v2(db, q1, -1, &stmt1, nil) != SQLITE_OK{
                               let errmsg = String(cString: sqlite3_errmsg(db)!)
                               print("error preparing get: \(errmsg)")
                               sqlite3_finalize(stmt1)
                               sqlite3_close(db)
                               
                               return
                           }
                           var task:String?
                           
                           while(sqlite3_step(stmt1) == SQLITE_ROW){
                               task = String(cString: sqlite3_column_text(stmt1, 0))
                               
                             taskdataset.append(SearchTextFieldItem(title: task!))
                               
                           }
                           sqlite3_finalize(stmt1)
                           sqlite3_close(db)
             self.task.filterItems(taskdataset)
        
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
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print (date)
        var singleDate = date
         let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "dd-MM-yyyy"
        datelabel.text = dateFormatter.string(from: date)
    }
    @IBAction func backbutton(_ sender: Any) {
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
