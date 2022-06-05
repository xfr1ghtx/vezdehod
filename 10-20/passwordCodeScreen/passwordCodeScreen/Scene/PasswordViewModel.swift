//
//  PasswordViewModel.swift
//  passwordCodeScreen
//
//  Created by Developer on 04.06.2022.
//

import Foundation

protocol PasswordViewModelDelegate: AnyObject{
    func RequestFillPin()
    func RequestUnFillPin()
    func RequestUnFillAll()
}


class PasswordViewModel {
    
    var showNotSuccessAlert: (() ->Void)?
    var showSuccessAlert: (() -> Void)?
    var showPasswordSetAlert: (() -> Void)?
    
    private let model: PasswordModel
    
    weak var delegate: PasswordViewModelDelegate?
    
    init(model: PasswordModel){
        self.model = model
        bindToModel()
    }
    
    private func bindToModel(){
        model.showSuccessAlert = {[weak self] in
            self?.showSuccessAlert!()
        }
        model.showNotSuccessAlert = {[weak self] in
            self?.showNotSuccessAlert!()
            self?.delegate?.RequestUnFillAll()
        }
        model.showPasswordSetAlert = {[weak self] in
            self?.showPasswordSetAlert!()
            self?.delegate?.RequestUnFillAll()
        }
        
        
    }
    
    func buttonTap(name: String){
        guard name.isNumber == false else{
            delegate?.RequestFillPin()
            model.insertText(name)
            return
        }
        if name == "question"{
        }
        else {
            delegate?.RequestUnFillPin()
            model.deleteBackward()
            return
        }
    }
    
}

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
