//
//  PinLabelViewModel.swift
//  passwordCodeScreen
//
//  Created by Developer on 04.06.2022.
//

import Foundation

class PinLabelViewModel{
    
    var DidFillNextPin: (() -> Void)?
    var DidUnFillPin: (() -> Void)?
    var DidUnFillAll: (() -> Void)?
    
    private let passwordViewModel: PasswordViewModel
    
    init (passwordViewModel: PasswordViewModel){
        self.passwordViewModel = passwordViewModel
        passwordViewModel.delegate = self
    }
}

extension PinLabelViewModel: PasswordViewModelDelegate{
    func RequestFillPin() {
        DidFillNextPin?()
    }
    
    func RequestUnFillPin() {
        DidUnFillPin?()
    }
    
    func RequestUnFillAll() {
        DidUnFillAll?()
    }
    
    
}

