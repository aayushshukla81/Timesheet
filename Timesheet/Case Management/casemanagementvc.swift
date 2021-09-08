//
//  casemanagementvc.swift
//  Timesheet
//
//  Created by hannan parvez on 29/02/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit

class casemanagementvc: apicalls {

    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
               self.navigationController?.navigationBar.titleTextAttributes = textAttributes
               self.navigationItem.title=self.userDefaults.value(forKey: "Resource_Name") as! String
        // Do any additional setup after loading the view.
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
