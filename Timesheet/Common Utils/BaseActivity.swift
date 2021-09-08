//
//  BaseActivity.swift
//  Timesheet
//
//  Created by hannan parvez on 16/02/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar
import FloatingSearchTextLabelField
import WWCalendarTimeSelector
import SearchTextField
import ChameleonFramework
class BaseActivity: UIViewController {
       var loadinggifview=UIView()
       let DoneToolBar = UIToolbar().ToolbarPiker(mySelect: #selector(dismissPicker))
        public func push(storybId: String, vcId: String, vc: BaseActivity ){
            let storyboard = UIStoryboard(name: storybId, bundle: nil)
            let registrationVC = storyboard.instantiateViewController(withIdentifier: vcId) as! UINavigationController
    //        let registrationVC = storyboard.instantiateViewController(withIdentifier: vcId) as! BaseActivity
    //        UIApplication.shared.delegate?.window?!.rootViewController = registrationVC
            navigationController?.pushViewController(registrationVC.topViewController!, animated: true)
        }
    @objc func dismissPicker() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        view.endEditing(true)
        
    }
        public func showtoast(controller: UIViewController, message: String, seconds: Double){
           
            let alert = UIAlertController(title: nil, message: message,  preferredStyle: .alert)
            alert.view.backgroundColor = UIColor.black
            alert.view.alpha = 1
            alert.view.layer.cornerRadius = 15

            controller.present(alert, animated: false)

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
                alert.dismiss(animated : false)
            }
        }
    func showdatepicker(context:WWCalendarTimeSelectorProtocol){
        let selector = WWCalendarTimeSelector.instantiate()
            selector.optionSelectionType = .single
                // 2. You can then set delegate, and any customization options
                selector.delegate = context
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
    func showtimepicker(context:WWCalendarTimeSelectorProtocol){
        let selector = WWCalendarTimeSelector.instantiate()
            selector.optionSelectionType = .single
                // 2. You can then set delegate, and any customization options
            selector.delegate = context
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
    func removeTsloader(){
    let window = UIApplication.shared.keyWindow!
    loadinggifview.removeFromSuperview()
        
    }
        func showTsloader(){
            let window = UIApplication.shared.keyWindow!
            loadinggifview = UIView(frame: window.bounds)
                    //        let khadimGif = UIImage.gif(url: "kgif")
                    do {
                        let backgif=UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
                         backgif.backgroundColor=UIColor.white
                        let gif = try UIImage(gifName: "loading.gif")
                        let imageview = UIImageView(gifImage: gif, loopCount: -1) // Use -1 for infinite loop
                        imageview.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
                        imageview.contentMode = .scaleAspectFit
                        backgif.center=window.center
                        backgif.layer.cornerRadius = 10
            //            backgif.addSubview(imageview)
                        imageview.center=window.center
                        window.addSubview(loadinggifview)
                        loadinggifview.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
                        loadinggifview.addSubview(backgif)
                        loadinggifview.addSubview(imageview)
                        let w = window.bounds.width
                        let h = window.bounds.height

                       let label = UILabel(frame: CGRect(x: w / 2, y: h / 2, width: 200, height: 30))
                        label.text = "Sync in Progress ..."
                        label.center = CGPoint(x: w / 2 , y: h / 2 + 100)
                        label.textAlignment = .center
                        label.textColor = UIColor.white
                        label.font = UIFont(name:"Gill Sans", size: 20.0)
                       loadinggifview.addSubview(label)
                        
                        
                       
                    } catch {
                        print(error)
                    }
        }
    func customizesearchfields(withname searchfield:FloatingSearchTextField){
           searchfield.inputAccessoryView=self.DoneToolBar
           searchfield.theme = FloatingSearchTextFieldTheme.lightTheme()
           searchfield.theme.font = UIFont.systemFont(ofSize: 12)
           searchfield.theme.bgColor = UIColor.white.withAlphaComponent(1)
           searchfield.theme.borderColor = UIColor.lightGray.withAlphaComponent(1)
           searchfield.theme.separatorColor = UIColor.lightGray.withAlphaComponent(1)
           searchfield.theme.cellHeight = 30
           searchfield.theme.placeholderColor = UIColor.gray
           searchfield.theme.subtitleFontColor=UIColor.white
           searchfield.maxResultsListHeight=200
           searchfield.startVisible=true
       }
    func customizesearchfields(withname searchfield:SearchTextField){
             searchfield.inputAccessoryView=self.DoneToolBar
             searchfield.theme = SearchTextFieldTheme.lightTheme()
            searchfield.maxResultsListHeight=200
             searchfield.theme.font = UIFont.systemFont(ofSize: 12)
             searchfield.theme.bgColor = UIColor.white.withAlphaComponent(1)
             searchfield.theme.borderColor = UIColor.lightGray.withAlphaComponent(1)
             searchfield.theme.separatorColor = UIColor.lightGray.withAlphaComponent(1)
             searchfield.theme.cellHeight = 30
             searchfield.theme.placeholderColor = UIColor.gray
             searchfield.theme.subtitleFontColor=UIColor.white
             searchfield.startVisible=true
         }
        func removeKloader(){
              let window = UIApplication.shared.keyWindow!
            loadinggifview.removeFromSuperview()
        }
        var loader = UIAlertController()
        func showloader(title: String){
            loader = UIAlertController(title: nil, message: title, preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating();
            
            loader.view.addSubview(loadingIndicator)
            present(loader, animated: false, completion: nil)
        }
        func openCamera(imagePicker:UIImagePickerController)
        {
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

        func openGallary(imagePicker:UIImagePickerController)
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        func applyborder(textfield:UITextField,color:CGColor){
            var bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0.0, y: textfield.frame.height , width: textfield.frame.width, height: 1.0)
            bottomLine.backgroundColor = color
            textfield.borderStyle = UITextField.BorderStyle.none
            textfield.layer.addSublayer(bottomLine)
            textfield.tintColor = .red
            
        }
        
        func dismissloader(){
            loader.dismiss(animated: false, completion: nil)
        }
         public func showToast(message : String) {
            let mymessage = MDCSnackbarMessage()
            mymessage.text = message
            mymessage.duration=TimeInterval(exactly: 1.0)!
            MDCSnackbarManager.messageTextColor = .black
            MDCSnackbarManager.snackbarMessageViewBackgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            MDCSnackbarManager.show(mymessage)
        }
        func imageWithImage(image:UIImage, scaledToSize newSize:CGSize ) -> UIImage {
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            image.draw(in: CGRect(x: 5, y: 0, width: newSize.width, height: newSize.width))
            let newImage : UIImage  = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext();
            return newImage;
            
        }
        func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
               URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
               
           }
        func getdate() ->String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
           return dateFormatter.string(from: Date())
        }
        func getdatetime() ->String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.string(from: Date())
        }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 50
            }
        }
    }
    

}
extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}
