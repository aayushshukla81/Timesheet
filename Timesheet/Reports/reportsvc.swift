//
//  reportsvc.swift
//  Timesheet
//
//  Created by hannan parvez on 29/02/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit

class reportsvc: apicalls {
   static var reporttype=""
    @IBOutlet var casemanagementreportcard: CardView!
    @IBOutlet var leaveschedulereportcard: CardView!
    @IBOutlet var dailyschedulereportcard: CardView!
    @IBOutlet var timesheetreportcard: CardView!
    @IBOutlet var attendencereportcard: CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
               self.navigationController?.navigationBar.titleTextAttributes = textAttributes
               self.navigationItem.title=self.userDefaults.value(forKey: "Resource_Name") as! String
        let attendencereportcardtap=UITapGestureRecognizer(target: self, action: #selector(gotoattendencereport))
        attendencereportcard.addGestureRecognizer(attendencereportcardtap)
        let timesheetreporttap=UITapGestureRecognizer(target: self, action: #selector(gototimesheetreport))
        timesheetreportcard.addGestureRecognizer(timesheetreporttap)
        
        let leaveschedulereporttap=UITapGestureRecognizer(target: self, action: #selector(gotoleaveschedulereport))
        leaveschedulereportcard.addGestureRecognizer(leaveschedulereporttap)
        
        let dailyschedulereporttap=UITapGestureRecognizer(target: self, action: #selector(gotodailyschedulereport))
        dailyschedulereportcard.addGestureRecognizer(dailyschedulereporttap)
        
        let casemanagementreporttap=UITapGestureRecognizer(target: self, action: #selector(gotocasemanagementreport))
        casemanagementreportcard.addGestureRecognizer(casemanagementreporttap)
        // Do any additional setup after loading the view.
    }
    @objc func gotoattendencereport(){
        reportsvc.reporttype="attendence"
        self.performSegue(withIdentifier: "gotoidealreport", sender: self)
        
    }
    @objc func gotoleaveschedulereport(){
        reportsvc.reporttype="leaveschedule"
        self.performSegue(withIdentifier: "gotoidealreport", sender: self)
        
    }
    @objc func gototimesheetreport(){
           reportsvc.reporttype="timesheet"
           self.performSegue(withIdentifier: "gotoidealreport", sender: self)
           
       }
    @objc func gotodailyschedulereport(){
        reportsvc.reporttype="dailyschedule"
        self.performSegue(withIdentifier: "gotocustomisedreport", sender: self)
        
    }
    @objc func gotocasemanagementreport(){
        reportsvc.reporttype="casemanagement"
        self.performSegue(withIdentifier: "gotocustomisedreport", sender: self)
        
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
