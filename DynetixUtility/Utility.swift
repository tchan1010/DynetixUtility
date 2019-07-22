//
//  Utility.swift
//  AutoPal
//
//  Created by Terence Chan on 5/12/17.
//  Copyright © 2017 Terence Chan. All rights reserved.
//

import Foundation
import UIKit

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

public func showMessage(_ caller: UIViewController, _ title : String, _ msg : String )
{
    let vc = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    vc.addAction(ok)
    caller.present(vc, animated:true, completion: nil)
}
