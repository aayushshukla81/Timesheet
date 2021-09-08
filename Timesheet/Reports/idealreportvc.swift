//
//  idealreportvc.swift
//  Timesheet
//
//  Created by hannan parvez on 01/03/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit
import WWCalendarTimeSelector
class idealreportvc: apicalls,UITableViewDataSource,UITableViewDelegate,WWCalendarTimeSelectorProtocol{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if reportsvc.reporttype=="attendence"{
            cell = tableView.dequeueReusableCell(withIdentifier: "attendencereportcell") as! UITableViewCell
        }
        if reportsvc.reporttype=="timesheet"{
            cell = tableView.dequeueReusableCell(withIdentifier: "timesheetreportcell") as! UITableViewCell
        }
        if reportsvc.reporttype=="leaveschedule"{
            cell = tableView.dequeueReusableCell(withIdentifier: "leavereportcell") as! UITableViewCell
        }
        
        return cell
       
    }
    
    var whichdatepickertapped=""

    @IBOutlet var heading: UILabel!
    @IBOutlet var todateview: UIView!
    @IBOutlet var fromdateview: UIView!
    @IBOutlet var todatelabel: UILabel!
    @IBOutlet var fromdatelabel: UILabel!
    @IBOutlet var reporttable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
               self.navigationController?.navigationBar.titleTextAttributes = textAttributes
               self.navigationItem.title=self.userDefaults.value(forKey: "Resource_Name") as! String
        if reportsvc.reporttype=="attendence"{
            heading.text = "Attendence Report"
        }
        if reportsvc.reporttype=="timesheet"{
                   heading.text = "Timesheet Report"
               }
        if reportsvc.reporttype=="leaveschedule"{
            heading.text = "Leave Schedule Report"
        }
        reporttable.delegate=self
        reporttable.dataSource=self
        let fromdateviewtap=UITapGestureRecognizer(target: self, action: #selector(showfromdatepicker))
        fromdateview.addGestureRecognizer(fromdateviewtap)
        let todateviewtap=UITapGestureRecognizer(target: self, action: #selector(showtodatepicker))
        todateview.addGestureRecognizer(todateviewtap)
        // Do any additional setup after loading the view.
    }
    @objc func showfromdatepicker(){
        whichdatepickertapped="fromdatepicker"
        showdatepicker(context: self)
    }
    @objc func showtodatepicker(){
        whichdatepickertapped="todatepicker"
         showdatepicker(context: self)
    }

    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print (date)
        var singleDate = date
         let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "dd-MM-yyyy"
        if whichdatepickertapped=="fromdatepicker"{
            fromdatelabel.text = dateFormatter.string(from: date)
        }
        if whichdatepickertapped=="todatepicker"{
            todatelabel.text = dateFormatter.string(from: date)
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
