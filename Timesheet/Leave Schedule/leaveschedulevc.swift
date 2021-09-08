//
//  leaveschedulevc.swift
//  Timesheet
//
//  Created by hannan parvez on 29/02/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import WWCalendarTimeSelector
class leaveschedulevc: apicalls ,WWCalendarTimeSelectorProtocol{

    @IBOutlet var fromdate: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
               self.navigationController?.navigationBar.titleTextAttributes = textAttributes
               self.navigationItem.title=self.userDefaults.value(forKey: "Resource_Name") as! String
        let fromdatetap=UITapGestureRecognizer(target: self, action: #selector(fromdatetapped))
        fromdate.addGestureRecognizer(fromdatetap)
        // Do any additional setup after loading the view.
    }
    @objc func fromdatetapped(){
        self.showdatepicker(context: self)
    }
    
    
    @IBAction func goback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
              let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "dd-MM-yyyy"
               fromdate.text = dateFormatter.string(from: date)
           
             
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
