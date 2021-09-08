//
//  customisedreportvc.swift
//  Timesheet
//
//  Created by hannan parvez on 01/03/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit

class customisedreportvc: apicalls {

    @IBOutlet var searchclientview: UIView!
    @IBOutlet var searchproductview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
               self.navigationController?.navigationBar.titleTextAttributes = textAttributes
               self.navigationItem.title=self.userDefaults.value(forKey: "Resource_Name") as! String
        let borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        searchproductview.layer.borderColor = borderColor.cgColor;
        searchproductview.layer.borderWidth = 2.0;
        searchproductview.layer.cornerRadius = 15.0;
        searchclientview.layer.borderColor = borderColor.cgColor;
        searchclientview.layer.borderWidth = 2.0;
        searchclientview.layer.cornerRadius = 15.0;
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
