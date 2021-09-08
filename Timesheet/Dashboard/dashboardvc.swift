//
//  dashboardvc.swift
//  Timesheet
//
//  Created by hannan parvez on 16/02/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit

class dashboardvc: apicalls {

    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var dailyscheduleCard: CardView!
    @IBOutlet var exitCard: CardView!
    @IBOutlet var logoutCard: CardView!
    @IBOutlet var changepasswordCard: CardView!
    @IBOutlet var reportsCard: CardView!
    @IBOutlet var casemanagementCard: CardView!
    @IBOutlet var leavescheduleCard: CardView!
    @IBOutlet var timesheetCard: CardView!
    @IBOutlet var attendenceCard: CardView!
    @IBOutlet var assigntasksCard: CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollview.refreshControl=UIRefreshControl()
        scrollview.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title=self.userDefaults.value(forKey: "Resource_Name") as! String
        let assigntaskscardtap=UITapGestureRecognizer(target: self, action: #selector(assigntaskstapped))
        assigntasksCard.addGestureRecognizer(assigntaskscardtap)
        let attendencecardtap=UITapGestureRecognizer(target: self, action: #selector(attendencecardtapped))
        attendenceCard.addGestureRecognizer(attendencecardtap)
        let timesheetcardtap=UITapGestureRecognizer(target: self, action: #selector(timesheetcardtapped))
        timesheetCard.addGestureRecognizer(timesheetcardtap)
        let leaveschedulecardtap=UITapGestureRecognizer(target: self, action: #selector(leaveschedulecardtapped))
        leavescheduleCard.addGestureRecognizer(leaveschedulecardtap)
        let casemanagementcardtap=UITapGestureRecognizer(target: self, action: #selector(casemanagementcardtapped))
        casemanagementCard.addGestureRecognizer(casemanagementcardtap)
        let reportscardtap=UITapGestureRecognizer(target: self, action: #selector(reportscardtapped))
        reportsCard.addGestureRecognizer(reportscardtap)
        let changepasswordcardtap=UITapGestureRecognizer(target: self, action: #selector(changepasswordcardtapped))
        changepasswordCard.addGestureRecognizer(changepasswordcardtap)
        let logoutcardtap=UITapGestureRecognizer(target: self, action: #selector(logoutcardtapped))
        logoutCard.addGestureRecognizer(logoutcardtap)
        let exitcardtap=UITapGestureRecognizer(target: self, action: #selector(exitcardtapped))
        exitCard.addGestureRecognizer(exitcardtap)
        
        let dailyschedulecardtap=UITapGestureRecognizer(target: self, action: #selector(dailyscheduletapped))
        dailyscheduleCard.addGestureRecognizer(dailyschedulecardtap)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        

        if let lastsyncdate=UserDefaults.standard.string(forKey: "Last_Sync_date") {
            if lastsyncdate != self.getdate(){
                showTsloader()
                syncdata()
            }
        }
            else{
            showTsloader()
                 syncdata()
            }
      
    }
    @objc func didPullToRefresh() {

     print("Refersh")

    // For End refrshing
    DispatchQueue.main.async {
       self.scrollview.refreshControl?.endRefreshing()
       self.showTsloader()
       self.syncdata()
       
    }
    }
    @objc func dailyscheduletapped(){
        self.push(storybId: "Dailyschedule", vcId: "dailyschedulenc", vc: self)
    }
    @objc func assigntaskstapped(){
        self.push(storybId: "Assigntasks", vcId: "Assigntasksnc", vc: self)
    }
    @objc func attendencecardtapped(){
         self.push(storybId: "Attendence", vcId: "attendencenc", vc: self)
        
    }
    @objc func timesheetcardtapped(){
        self.push(storybId: "Timesheetentry", vcId: "Timesheetentrync", vc: self)
        
    }
    @objc func leaveschedulecardtapped(){
        self.push(storybId: "Leaveschedule", vcId: "leaveschedulenc", vc: self)
           
    }
    @objc func casemanagementcardtapped(){
        self.push(storybId: "Casemanagement", vcId: "casemanagementnc", vc: self)
              
    }
    @objc func reportscardtapped(){
        self.push(storybId: "Reports", vcId: "reportsnc", vc: self)
        
                 
    }
    @objc func changepasswordcardtapped(){
        
    }
    @objc func logoutcardtapped(){
        
    }
    @objc func exitcardtapped(){
        
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
