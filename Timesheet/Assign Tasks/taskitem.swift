//
//  taskitem.swift
//  Timesheet
//
//  Created by hannan parvez on 03/03/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import Foundation


class taskitem{
    var client :String
    var task :String
    var project:String
    init(client:String,task:String,project:String) {
        self.client=client
        self.task=task
        self.project=project
        
    }
    
}
