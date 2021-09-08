//
//  splashscreenvc.swift
//  Timesheet
//
//  Created by hannan parvez on 11/02/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit
import SwiftyGif
class splashscreenvc: apicalls {

    @IBOutlet var timesheetgif: UIImageView!
    @IBOutlet var welcomelabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 2.0, animations: {
            self.welcomelabel.center = CGPoint(x: self.welcomelabel.center.x, y: self.welcomelabel.center.y+400)
        }, completion: { done in
        })
        do{
            let tsgif=try UIImage(gifName: "timesheetgif.gif")
            timesheetgif.setGifImage(tsgif)
            
        }
        catch{
            print (error)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
           // Code to push/present new view controller
            if let a = self.userDefaults.value(forKey: "rememberme"){
                if a as! String=="true"{
                    
                
                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)

                //Get the VC you want to push onto the stack
                //You can use storyboard.instantiateViewController(withIdentifier: "yourStoryboardId")
                guard let vc = storyboard.instantiateInitialViewController() else { return }

                //Get the current app delegate
                guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }

                //Set the current root controller and add the animation with a
                //UIView transition
                 UIApplication.shared.windows.first?.rootViewController = vc
                 UIApplication.shared.windows.first?.makeKeyAndVisible()

                UIView.transition(with: UIApplication.shared.windows.first!,
                              duration: 1.0,
                               options: .transitionCrossDissolve,
                            animations: {
                                UIApplication.shared.windows.first?.rootViewController = vc
                },
                            completion: nil)
                }
            }
            else{
                let storyboard = UIStoryboard(name: "Login", bundle: nil)

                               //Get the VC you want to push onto the stack
                               //You can use storyboard.instantiateViewController(withIdentifier: "yourStoryboardId")
                               guard let vc = storyboard.instantiateInitialViewController() else { return }

                               //Get the current app delegate
                               guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }

                               //Set the current root controller and add the animation with a
                               //UIView transition
                                UIApplication.shared.windows.first?.rootViewController = vc
                                UIApplication.shared.windows.first?.makeKeyAndVisible()

                               UIView.transition(with: UIApplication.shared.windows.first!,
                                             duration: 1.0,
                                              options: .transitionCrossDissolve,
                                           animations: {
                                               UIApplication.shared.windows.first?.rootViewController = vc
                               },
                                           completion: nil)
            }
            
//            UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCrossDissolve, animations: {
//                let mainStoryBoard = UIStoryboard(name: "Dashboard", bundle: nil)
//                               let vc = mainStoryBoard.instantiateInitialViewController()
//                               UIApplication.shared.windows.first?.rootViewController = vc
//                               UIApplication.shared.windows.first?.makeKeyAndVisible()
//            }, completion: {
//                done in
//            })
//            UIView.animate(withDuration: 1.0, animations:{
//
//                })
            
           }
        // Do any additional setup after loading the view.
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
