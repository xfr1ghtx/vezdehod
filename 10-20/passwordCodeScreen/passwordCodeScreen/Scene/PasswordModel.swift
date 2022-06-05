//
//  PasswordModel.swift
//  passwordCodeScreen
//
//  Created by Developer on 04.06.2022.
//

import Foundation


class PasswordModel{
    
    var showNotSuccessAlert: (() ->Void)?
    var showSuccessAlert: (() -> Void)?
    var showPasswordSetAlert: (() -> Void)?
    
    var code = ""
    var maxLength = 4
    
    var setPassword = false
    var password = ""
    
    var hasText: Bool{
        return code.count > 0
    }
    
    func insertText(_ text: String){
        guard code.count < maxLength else {
            return
        }
        
        code.append(text)
        
        if code.count == 4 && setPassword == false{
            setPassword = true
            password = code
            code = ""
            showPasswordSetAlert?()
        }
        else if code.count == 4 && setPassword == true{
            if (password == code){
                showSuccessAlert?()
            }
            else{
                code = ""
                showNotSuccessAlert?()
            }
        }
    }
    
    func deleteBackward(){
        if hasText{
            code.removeLast()
        }
    }
}
