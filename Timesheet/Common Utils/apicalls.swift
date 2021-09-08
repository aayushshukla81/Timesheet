//
//  apicalls.swift
//  Timesheet
//
//  Created by hannan parvez on 03/03/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftEventBus
class apicalls: dbconnections {
let base_url="http://163.47.143.188:3901/api/"
    override func viewDidLoad() {
        super.viewDidLoad()
            SwiftEventBus.onMainThread(self, name:"sync successful") { result in
                // UI thread
                     UserDefaults.standard.set(self.getdate(), forKey: "Last_Sync_date")
                    
                
                self.removeTsloader()
             
            }
        SwiftEventBus.onMainThread(self, name:"sync unsuccessful") { result in
            // UI thread
            self.removeTsloader()
         
        }


        // Do any additional setup after loading the view.
    }
    var authenticated=false
    let userDefaults = UserDefaults.standard
    func validuser(ResourceId:String,password:String,rememberme:Bool,completion: @escaping (Bool) -> Void){
        
        let URL_Validate = "Login?Resource_id="+ResourceId
                          Alamofire.request(self.base_url + URL_Validate,method: .get).validate().responseJSON {
                              response in
                              print(response)
                              switch response.result {
                              case .success(let value): print("success==========> \(value)")
                              do{
                                  let json = try JSON(response.result.value!)
                                  if json.count>0{
                                    if json[0]["password"].exists() {
                                        if json[0]["password"].stringValue == password{
                                            if rememberme{
                                                self.userDefaults.setValue("true", forKey: "rememberme")
                                            }
                                            self.userDefaults.setValue(json[0]["resource Id"].stringValue , forKey: "Resource_Id")
                                            self.userDefaults.setValue(json[0]["resource"].stringValue , forKey: "Resource_Name")
                                            completion(true)
                                        }
                                        else{
                                             completion(false)
                                        }
                                    }
                                    else{
                                       completion(false)
                                    }
                                      
                                      
                                  }
                                  else{
                                    completion(false)
                                }
                                
                                  
                              }
                              catch{
                                completion(false)
                                  print("///URL_Validate execption takeordervc\\\\")
                                  }
            //                  self.subordertype.filterItems(self.subordertypearray)
                              case .failure(_):
                                  print("no network")
                                completion(false)
                                  
                              }
                              
                          }
    }
    func syncdata(){
          createWorkTypeTable()
      let URL_WorkType = "GetWorkType"
                    Alamofire.request(self.base_url + URL_WorkType,method: .get).validate().responseJSON {
                        response in
                        print(response)
                        switch response.result {
                        case .success(let value): print("success==========> \(value)")
                        do{
                            let json = try JSON(response.result.value!)
                            for i in 0 ... json.count-1{
                              let work_Id = json[i]["work Id"].stringValue
                              let work = json[i]["work"].stringValue
                                
                              self.insertintoWorkTypeTable(work_Id: work_Id, work: work)
                                
                            }
                            
                        }
                        catch{
                            print("///GetWorkType execption takeordervc\\\\")
                            }
                        self.getAssignTaskTable(Resource_id: self.userDefaults.value(forKey: "Resource_Id") as! String )
      //                  self.subordertype.filterItems(self.subordertypearray)
                        case .failure(_):
                            print("no network")
                            SwiftEventBus.postToMainThread("sync unsuccessful")
                            
                        }
                        
                    }
      
      }
      
    func getAssignTaskTable(Resource_id:String){
        createAssignTaskTable()
    let URL_AssignTask = "GetTimeSheet?Resource_id="+Resource_id
                  Alamofire.request(self.base_url + URL_AssignTask,method: .get).validate().responseJSON {
                      response in
                      print(response)
                      switch response.result {
                      case .success(let value): print("success==========> \(value)")
                      do{
                          let json = try JSON(response.result.value!)
                          for i in 0 ... json.count-1{
                            let job_Id = json[i]["job Id"].stringValue
                            let task_Id = json[i]["task_Id"].stringValue
                            let activity_Date = json[i]["activity_Date"].stringValue
                            let financial_Year = json[i]["financial_Year"].stringValue
                            let resource_Id = json[i]["resource_Id"].stringValue
                            let resource = json[i]["resource"].stringValue
                            let task = json[i]["task"].stringValue
                            let job = json[i]["job"].stringValue
                            let segment_Id = json[i]["segment_Id"].stringValue
                            let segment = json[i]["segment"].stringValue
                            let product_Id = json[i]["product_Id"].stringValue
                            let product = json[i]["product"].stringValue
                            let client_Id = json[i]["client_Id"].stringValue
                            let client = json[i]["client"].stringValue
                            let project_Id = json[i]["project_Id"].stringValue
                            let project = json[i]["project"].stringValue
                              
                            self.insertintoAssignTaskTable(job_Id: job_Id, task_Id: task_Id, activity_Date: activity_Date , financial_Year: financial_Year , resource_Id: resource_Id , resource: resource , task: task , job: job , segment_Id: segment_Id , segment: segment , product_Id: product_Id , product: product , client_Id: client_Id , client: client , project_Id: project_Id , project: project )
                              
                          }
                          
                      }
                      catch{
                          print("///GetAssigntask execption takeordervc\\\\")
                          }
    //                  self.subordertype.filterItems(self.subordertypearray)
                     SwiftEventBus.postToMainThread("sync successful")
                      case .failure(_):
                          SwiftEventBus.postToMainThread("sync unsuccessful")
                          print("no network")
                          
                      }
                      
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
