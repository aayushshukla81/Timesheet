//
//  Attendencevc.swift
//  Timesheet
//
//  Created by hannan parvez on 11/02/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import WWCalendarTimeSelector
import ChameleonFramework
class Attendencevc: apicalls,WWCalendarTimeSelectorProtocol {
     var picker=WWCalendarTimeSelectorDateRange()
    var whichlabelpressed="checkindate"
    @IBOutlet var checkouttime: SkyFloatingLabelTextField!
    @IBOutlet var checkintime: SkyFloatingLabelTextField!
    @IBOutlet var checkoutdate: SkyFloatingLabelTextField!
    @IBOutlet var checkindate: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        showdatepicker()
        // Do any additional setup after loading the view.
    }
    @objc func checkintimetapped(){
        whichlabelpressed="checkintime"
        showtimepicker()
    }
    @objc func checkouttimetapped(){
        whichlabelpressed="checkouttime"
        showtimepicker()
    }
    @objc func checkindatetapped(){
        whichlabelpressed="checkindate"
        showdatepicker()
    }
    @objc func checkoutdatetapped(){
        whichlabelpressed="checkoutdate"
        showdatepicker()
    }
    @IBAction func goback(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
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
    func showdatepicker(){
       let selector = WWCalendarTimeSelector.instantiate()
           selector.optionSelectionType = .single
                   // 2. You can then set delegate, and any customization options
           selector.delegate = self
           selector.optionStyles.showTime(false)
           selector.optionTopPanelTitle = "Select Date"
           selector.optionCalendarBackgroundColorTodayHighlight=HexColor(hexString: "#278C81")
           selector.optionCalendarBackgroundColorPastDatesHighlight=HexColor(hexString: "#278C81")
           selector.optionCalendarBackgroundColorFutureDatesHighlight=HexColor(hexString: "#278C81")
           selector.optionCalendarFontColorDays=HexColor(hexString: "#278C81")
           selector.optionSelectorPanelBackgroundColor=HexColor(hexString: "#278C81")
           selector.optionTopPanelBackgroundColor=HexColor(hexString: "#278C81")
           selector.optionButtonFontColorDone=HexColor(hexString: "#278C81")
           selector.optionButtonFontColorCancel=HexColor(hexString: "#278C81")
          

                   // 3. Then you simply present it from your view controller when necessary!
               self.present(selector, animated: true, completion: nil)
       }
    func showtimepicker(){
        let selector = WWCalendarTimeSelector.instantiate()
            selector.optionSelectionType = .single
                // 2. You can then set delegate, and any customization options
            selector.delegate = self
            selector.optionStyles.showDateMonth(false)
            selector.optionStyles.showYear(false)
            selector.optionTopPanelTitle = "Select Date"
            selector.optionCalendarBackgroundColorTodayHighlight=HexColor(hexString: "#278C81")
            selector.optionCalendarBackgroundColorPastDatesHighlight=HexColor(hexString: "#278C81")
            selector.optionCalendarBackgroundColorFutureDatesHighlight=HexColor(hexString: "#278C81")
            selector.optionCalendarFontColorDays=HexColor(hexString: "#278C81")
            selector.optionSelectorPanelBackgroundColor=HexColor(hexString: "#278C81")
            selector.optionTopPanelBackgroundColor=HexColor(hexString: "#278C81")
            selector.optionButtonFontColorDone=HexColor(hexString: "#278C81")
            selector.optionButtonFontColorCancel=HexColor(hexString: "#278C81")
       

                // 3. Then you simply present it from your view controller when necessary!
            self.present(selector, animated: true, completion: nil)
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
