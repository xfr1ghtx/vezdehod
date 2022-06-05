//
//  PinViewModel.swift
//  passwordCodeScreen
//
//  Created by Developer on 04.06.2022.
//

import Foundation

class PinViewModel {
    
    var didEnterCode: (()->Void)?
    var didDeleteCode: (()->Void)?
    
    func fill(){
        didEnterCode?()
    }
    
    func unFill(){
        didDeleteCode?()
    }
}
