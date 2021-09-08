//
//  loginvc.swift
//  Timesheet
//
//  Created by hannan parvez on 29/02/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class loginvc: apicalls {

    @IBOutlet var remembermebutton: UIButton!
    @IBOutlet var passwordtogglebtn: UIButton!
    @IBOutlet var username: SkyFloatingLabelTextField!
    @IBOutlet var password: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        username.inputAccessoryView=DoneToolBar
        password.inputAccessoryView=DoneToolBar
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        
        if ( username.text != "" && password.text != "" ){
                showTsloader()
            validuser(ResourceId: username.text!, password: password.text!,rememberme:rememberme){
                (Result) in
                    if Result{
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
                        }, completion: nil)
                    }
                    else{
                        self.removeTsloader()
                        self.showToast(message: "Invalid credentials")
                    }
                
            }
        }
        else{
             self.showToast(message: "Invalid credentials")
        }
        
    }

    var rememberme=false
    var passwordhidden=true
    @IBAction func passwordtoggle(_ sender: Any) {
        if passwordhidden{
            passwordtogglebtn.setImage(UIImage(named: "password.png"), for: .normal)
            password.isSecureTextEntry=false
        }
        else{
            passwordtogglebtn.setImage(UIImage(named: "showpassword.png"), for: .normal)
            password.isSecureTextEntry=true
        }
        passwordhidden.toggle()
        print("passwordhidden is \(passwordhidden)")
    }
    @IBAction func rememberme(_ sender: Any) {
           if !rememberme{
               remembermebutton.setImage(UIImage(named: "checkbox_icon.png"), for: .normal)
           }
               else{
                   remembermebutton.setImage(UIImage(named: "unchecked.png"), for: .normal)
               }
           rememberme.toggle()
           print("rememberme is \(rememberme)")
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
