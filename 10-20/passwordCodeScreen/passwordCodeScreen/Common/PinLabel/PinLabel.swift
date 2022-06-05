//
//  pinLabel.swift
//  passwordCodeScreen
//
//  Created by Developer on 04.06.2022.
//

import UIKit

protocol PinLabelDelegate: AnyObject{
    func DidCompleteSetPassword()
    func DidWrongPassword()
    func DidCorrectPassword()
}

class PinLabel: UIView {
    
    private let viewModel: PinLabelViewModel
    
    weak var delegate: PinLabelDelegate?
    
    let pins = [Pin(), Pin(), Pin(),Pin()]
    var pinFills = -1
    
    var password = ""
    
    let stackView = UIStackView()
    
    init(viewModel: PinLabelViewModel){
        self.viewModel = viewModel
        super.init(frame: CGRect(x: 0, y: 0, width: 127, height: 12))
        setup()
        bindToViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindToViewModel(){
        viewModel.DidFillNextPin = {[weak self] in
            guard let index = self?.pinFills else{
                return
            }
            guard index < 3 else {
                return
            }
            
            self?.pins[index+1].viewModel.didEnterCode?()
            self?.pinFills += 1
            
        }
        
        viewModel.DidUnFillPin = {[weak self] in
            guard let index = self?.pinFills else{
                return
            }
            guard index > -1 else{
                return
            }
            
            
            self?.pins[index].viewModel.didDeleteCode?()
            self?.pinFills -= 1
            
        }
        
        viewModel.DidUnFillAll = {[weak self] in
            
            self?.pinFills = -1
            
            guard let pins = self?.pins else {
                return
            }
            
            for pin in pins{
                pin.viewModel.didDeleteCode?()
            }
            
            
        }
    }
    
    private func setup(){
        stackViewSetup()
        pinsSetup()
    }
    
    private func stackViewSetup(){
        self.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.spacing = 26
        stackView.distribution = .equalSpacing
        
        stackView.snp.makeConstraints{make in
            make.edges.equalToSuperview()
        }
    }
    
    private func pinsSetup(){
        for pin in pins{
            stackView.addArrangedSubview(pin)
            
            pin.snp.makeConstraints{make in
                make.height.width.equalTo(12)
            }
        }
    }
    
     
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
