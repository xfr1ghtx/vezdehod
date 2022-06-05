//
//  Alert\.swift
//  passwordCodeScreen
//
//  Created by Developer on 05.06.2022.
//

import Foundation
import UIKit

extension UIAlertController{
    
    static func createAlert(withTitle title: String,
                            message: String,
                            cancelActionTitle: String? = nil) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: cancelActionTitle ?? "Ok", style: .cancel)
        alert.addAction(alertAction)
        return alert
    }
}
