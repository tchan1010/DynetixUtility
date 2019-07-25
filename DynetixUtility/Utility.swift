//
//  Utility.swift
//  AutoPal
//
//  Created by Terence Chan on 5/12/17.
//  Copyright © 2017 Terence Chan. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

public func second2Str(_ totals : Int64 ) -> String {
    var min : Int64 = totals / 60
    let sec : Int64 = totals % 60
    let hr  : Int64 = min / 60
    min %= 60
    
    let strHr = hr > 0 ? String(format:"%ld hr ", hr) : ""
    let strMin = min > 0 ? String(format:"%ld min ", min) : ""
    let strSec = sec > 0 ? String(format:"%ld s", sec) : ""
    return strHr + strMin + strSec
}

public func date2Str(_ date : Date ) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    return dateFormatter.string(from: date)
}

public func sendEmail(_ caller: UIViewController, _ subject : String, _ msg : String, _ image : UIImage? )
{
    guard MFMailComposeViewController.canSendMail() else {
        showMessage(caller, subject, "Can't send email")
        return
    }
        let picker = MFMailComposeViewController()
    picker.mailComposeDelegate = (caller as! MFMailComposeViewControllerDelegate); // &lt;- very important step if you want feedbacks on what the user did with your email sheet
        
        picker.setSubject(subject)
        
        let emailBody = msg
        
        if image != nil {
            let theImageData : Data = image!.pngData()!
            
            picker.addAttachmentData(theImageData, mimeType: "image/png", fileName: "image.png")
        }
        
        picker.setMessageBody(emailBody, isHTML:false)
        
        picker.navigationBar.barStyle = .black; // choose your style, unfortunately, Translucent colors behave quirky.
        
        caller.present(picker, animated:true, completion:nil)
}

public func showMessage(_ caller: UIViewController, _ title : String, _ msg : String,
                        _ doEmail : Bool = false, _ Image : UIImage? = nil)
{
    let vc = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    vc.addAction(ok)
    if (doEmail && MFMailComposeViewController.canSendMail()) {
         let email = UIAlertAction(title: "Email", style: .default, handler: { action in
                sendEmail(caller, title, msg, Image)
         })
        vc.addAction(email)
    }
    caller.present(vc, animated:true, completion: nil)
}
