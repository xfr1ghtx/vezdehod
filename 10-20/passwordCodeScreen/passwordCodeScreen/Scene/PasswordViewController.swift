//
//  PasswordViewController.swift
//  passwordCodeScreen
//
//  Created by Developer on 04.06.2022.
//

import UIKit
import SnapKit

class PasswordViewController: UIViewController {
    
    private let backgroundImageView = UIImageView()
    private let logoImageView = UIImageView()
    private let textLabel = UILabel()
    private let pinLabel: PinLabel
    
    private let oneButton = UIButton()
    private let twoButton = UIButton()
    private let threeButton = UIButton()
    private let fourButton = UIButton()
    private let fiveButton = UIButton()
    private let sixButton = UIButton()
    private let sevenButton = UIButton()
    private let eightButton = UIButton()
    private let nineButton = UIButton()
    private let questionButton = UIButton()
    private let zeroButton = UIButton()
    private let backButton = UIButton()
    
    private let firstRow = UIStackView()
    private let secondRow = UIStackView()
    private let thirdRow = UIStackView()
    private let fourthRow = UIStackView()
    private let allRow = UIStackView()
    
    private let gestureView = UIView()
    
    private var checkGesture = false
    
    
    
    private let viewModel: PasswordViewModel
    
    init(viewModel: PasswordViewModel){
        self.viewModel = viewModel
        self.pinLabel = PinLabel(viewModel: PinLabelViewModel(passwordViewModel: self.viewModel))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindToViewModel(){
        viewModel.showSuccessAlert = {[weak self] in
            self?.present(UIAlertController.createAlert(withTitle: "Верно", message: "Вы ввели правильный пароль", cancelActionTitle: "Ок"), animated: true)
        }
        
        viewModel.showPasswordSetAlert = {[weak self] in
            self?.present(UIAlertController.createAlert(withTitle: "Успешно", message: "Вы успешно выставили пароль", cancelActionTitle: "Ок"), animated: true)
            self?.textLabel.text = "Введите пин-код"
        }
            
        
        
        viewModel.showNotSuccessAlert = {[weak self] in
            self?.present(UIAlertController.createAlert(withTitle: "Неверно", message: "Вы ввели неверный пароль", cancelActionTitle: "Ок"), animated: true)
        }
        
    }
    
    
    @objc private func tapOne(){
        viewModel.buttonTap(name: "1")
    }
    
    @objc private func tapTwo(){
        viewModel.buttonTap(name: "2")
    }
    
    @objc private func tapThree(){
        viewModel.buttonTap(name: "3")
    }
    
    @objc private func tapFour(){
        viewModel.buttonTap(name: "4")
    }
    
    @objc private func tapFive(){
        viewModel.buttonTap(name: "5")
    }
    
    @objc private func tapSix(){
        viewModel.buttonTap(name: "6")
    }
    
    @objc private func tapSeven(){
        viewModel.buttonTap(name: "7")
    }
    
    @objc private func tapEight(){
        viewModel.buttonTap(name: "8")
    }
    
    @objc private func tapNine(){
        viewModel.buttonTap(name: "9")
    }
    
    @objc private func tapQuestion(){
        viewModel.buttonTap(name: "question")
    }
    
    @objc private func tapZero(){
        viewModel.buttonTap(name: "0")
    }
    
    @objc private func tapBack(){
        viewModel.buttonTap(name: "back")
    }
    
    @objc private func tapHandle (_ g: UITapGestureRecognizer){
        if(g.location(in: oneButton).x > 0 && g.location(in: oneButton).x < oneButton.frame.width && g.location(in: oneButton).y > 0 && g.location(in: oneButton).y < oneButton.frame.height ){
            viewModel.buttonTap(name: "1")
        }
        else if(g.location(in: twoButton).x > 0 && g.location(in: twoButton).x < twoButton.frame.width && g.location(in: twoButton).y > 0 && g.location(in: twoButton).y < twoButton.frame.height){
            viewModel.buttonTap(name: "2")
        }
        else if(g.location(in: threeButton).x > 0 && g.location(in: threeButton).x < threeButton.frame.width && g.location(in: threeButton).y > 0 && g.location(in: threeButton).y < threeButton.frame.height){
            viewModel.buttonTap(name: "3")
        }
        else if(g.location(in: fourButton).x > 0 && g.location(in: fourButton).x < fourButton.frame.width && g.location(in: fourButton).y > 0 && g.location(in: fourButton).y < fourButton.frame.height ){
            viewModel.buttonTap(name: "4")
        }
        else if(g.location(in: fiveButton).x > 0 && g.location(in: fiveButton).x < fiveButton.frame.width && g.location(in: fiveButton).y > 0 && g.location(in: fiveButton).y < fiveButton.frame.height ){
            viewModel.buttonTap(name: "5")
        }
        else if(g.location(in: sixButton).x > 0 && g.location(in: sixButton).x < sixButton.frame.width && g.location(in: sixButton).y > 0 && g.location(in: sixButton).y < sixButton.frame.height){
            viewModel.buttonTap(name: "6")
        }
        else if(g.location(in: sevenButton).x > 0 && g.location(in: sevenButton).x < sevenButton.frame.width && g.location(in: sevenButton).y > 0 && g.location(in: sevenButton).y < sevenButton.frame.height){
            viewModel.buttonTap(name: "7")
        }
        else if(g.location(in: eightButton).x > 0 && g.location(in: eightButton).x < eightButton.frame.width && g.location(in: eightButton).y > 0 && g.location(in: eightButton).y < eightButton.frame.height){
            viewModel.buttonTap(name: "8")
        }
        else if(g.location(in: nineButton).x > 0 && g.location(in: nineButton).x < nineButton.frame.width && g.location(in: nineButton).y > 0 && g.location(in: nineButton).y < nineButton.frame.height){
            viewModel.buttonTap(name: "9")
        }
        else if(g.location(in: questionButton).x > 0 && g.location(in: questionButton).x < questionButton.frame.width && g.location(in: questionButton).y > 0 && g.location(in: questionButton).y < questionButton.frame.height){
            viewModel.buttonTap(name: "question")
        }
        else if(g.location(in: zeroButton).x > 0 && g.location(in: zeroButton).x < zeroButton.frame.width && g.location(in: zeroButton).y > 0 && g.location(in: zeroButton).y < zeroButton.frame.height){
            viewModel.buttonTap(name: "0")
        }
        else if(g.location(in: backButton).x > 0 && g.location(in: backButton).x < backButton.frame.width && g.location(in: backButton).y > 0 && g.location(in: backButton).y < backButton.frame.height){
            viewModel.buttonTap(name: "back")
        }
    }
    
    @objc private func panHandle(_ g: UIPanGestureRecognizer ){
        if(g.location(in: oneButton).x > 0 && g.location(in: oneButton).x < oneButton.frame.width && g.location(in: oneButton).y > 0 && g.location(in: oneButton).y < oneButton.frame.height ){
            if (checkGesture == false){
                viewModel.buttonTap(name: "1")
                checkGesture = true
            }
        }
        else if(g.location(in: twoButton).x > 0 && g.location(in: twoButton).x < twoButton.frame.width && g.location(in: twoButton).y > 0 && g.location(in: twoButton).y < twoButton.frame.height){
            if (checkGesture == false){
            viewModel.buttonTap(name: "2")
            checkGesture = true
            }
        }
        else if(g.location(in: threeButton).x > 0 && g.location(in: threeButton).x < threeButton.frame.width && g.location(in: threeButton).y > 0 && g.location(in: threeButton).y < threeButton.frame.height){
            if (checkGesture == false){
            viewModel.buttonTap(name: "3")
            checkGesture = true
            }
        }
        else if(g.location(in: fourButton).x > 0 && g.location(in: fourButton).x < fourButton.frame.width && g.location(in: fourButton).y > 0 && g.location(in: fourButton).y < fourButton.frame.height ){
            if (checkGesture == false){
            viewModel.buttonTap(name: "4")
            checkGesture = true
            }
        }
        else if(g.location(in: fiveButton).x > 0 && g.location(in: fiveButton).x < fiveButton.frame.width && g.location(in: fiveButton).y > 0 && g.location(in: fiveButton).y < fiveButton.frame.height ){
            if checkGesture == false{
            viewModel.buttonTap(name: "5")
            checkGesture = true
            }
        }
        else if(g.location(in: sixButton).x > 0 && g.location(in: sixButton).x < sixButton.frame.width && g.location(in: sixButton).y > 0 && g.location(in: sixButton).y < sixButton.frame.height){
            if (checkGesture == false){
            viewModel.buttonTap(name: "6")
            checkGesture = true
            }
        }
        else if(g.location(in: sevenButton).x > 0 && g.location(in: sevenButton).x < sevenButton.frame.width && g.location(in: sevenButton).y > 0 && g.location(in: sevenButton).y < sevenButton.frame.height){
            if (checkGesture == false){
            viewModel.buttonTap(name: "7")
            checkGesture = true
            }
        }
        else if(g.location(in: eightButton).x > 0 && g.location(in: eightButton).x < eightButton.frame.width && g.location(in: eightButton).y > 0 && g.location(in: eightButton).y < eightButton.frame.height){
            if (checkGesture == false){
            viewModel.buttonTap(name: "8")
            checkGesture = true
            }
        }
        else if(g.location(in: nineButton).x > 0 && g.location(in: nineButton).x < nineButton.frame.width && g.location(in: nineButton).y > 0 && g.location(in: nineButton).y < nineButton.frame.height){
            if (checkGesture == false){
            viewModel.buttonTap(name: "9")
            checkGesture = true
            }
        }
        else if(g.location(in: questionButton).x > 0 && g.location(in: questionButton).x < questionButton.frame.width && g.location(in: questionButton).y > 0 && g.location(in: questionButton).y < questionButton.frame.height){
            if (checkGesture == false){
            viewModel.buttonTap(name: "question")
            checkGesture = true
            }
        }
        else if(g.location(in: zeroButton).x > 0 && g.location(in: zeroButton).x < zeroButton.frame.width && g.location(in: zeroButton).y > 0 && g.location(in: zeroButton).y < zeroButton.frame.height){
            if (checkGesture == false){
            viewModel.buttonTap(name: "0")
            checkGesture = true
            }
        }
        else if(g.location(in: backButton).x > 0 && g.location(in: backButton).x < backButton.frame.width && g.location(in: backButton).y > 0 && g.location(in: backButton).y < backButton.frame.height){
            if (checkGesture == false){
            viewModel.buttonTap(name: "back")
            checkGesture = true
            }
        }
        else {
            checkGesture = false
        }
        
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup(){
        backgroundImageViewSetup()
        logoImageViewSetup()
        textLabelSetup()
        pinLabelSetup()
        numberPadSetup()
        bindToViewModel()
    }
    
    private func backgroundImageViewSetup(){
        view.addSubview(backgroundImageView)
        backgroundImageView.image = UIImage.backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        
        backgroundImageView.snp.makeConstraints{make in
            make.edges.equalToSuperview()
        }
    }
    
    private func logoImageViewSetup(){
        view.addSubview(logoImageView)
        logoImageView.image = UIImage.logoImage
        logoImageView.contentMode = .scaleAspectFit
        
        logoImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(122)
            make.centerX.equalToSuperview()
        }
        
    }
    
    private func textLabelSetup(){
        view.addSubview(textLabel)
        
        textLabel.text = "Задайте пин-код"
        textLabel.font = UIFont.systemFont(ofSize: 20)
        textLabel.textColor = .white
        
        textLabel.snp.makeConstraints{make in
            make.top.equalTo(logoImageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    private func pinLabelSetup(){
        view.addSubview(pinLabel)
        
        pinLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.height.equalTo(12)
            make.width.equalTo(127)
        }
    }
    
    
    private func numberPadSetup(){
        
        //button setup
        
        zeroButton.addTarget(self, action: #selector(tapZero), for: .touchUpInside)
        oneButton.addTarget(self, action: #selector(tapOne), for: .touchUpInside)
        twoButton.addTarget(self, action: #selector(tapTwo), for: .touchUpInside)
        threeButton.addTarget(self, action: #selector(tapThree), for: .touchUpInside)
        fourButton.addTarget(self, action: #selector(tapFour), for: .touchUpInside)
        fiveButton.addTarget(self, action: #selector(tapFive), for: .touchUpInside)
        sixButton.addTarget(self, action: #selector(tapSix), for: .touchUpInside)
        sevenButton.addTarget(self, action: #selector(tapSeven), for: .touchUpInside)
        eightButton.addTarget(self, action: #selector(tapEight), for: .touchUpInside)
        nineButton.addTarget(self, action: #selector(tapNine), for: .touchUpInside)
        questionButton.addTarget(self, action: #selector(tapQuestion), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        
        
        let numberButtons = [zeroButton, oneButton, twoButton, threeButton, fourButton, fiveButton,sixButton,sevenButton,eightButton, nineButton]
        
        for i in 0...9{
            numberButtons[i].setTitle("\(i)", for: .normal)
            numberButtons[i].setTitleColor(.white, for: .normal)
            numberButtons[i].titleLabel?.font = UIFont.systemFont(ofSize: 36)
            numberButtons[i].layer.cornerRadius = 37.5
            numberButtons[i].backgroundColor = UIColor.buttonBackground
            
            numberButtons[i].snp.makeConstraints{ make in
                make.width.height.equalTo(90).priority(250)
                make.width.height.greaterThanOrEqualTo(75)
            }
        }
        
        questionButton.setImage(UIImage.questionImage, for: .normal)

        questionButton.backgroundColor = UIColor.clear
        
        questionButton.snp.makeConstraints{make in
            make.width.height.equalTo(90).priority(250)
            make.width.height.greaterThanOrEqualTo(75)
        }
        
        backButton.setImage(UIImage.backImage, for: .normal)

        backButton.backgroundColor = UIColor.clear
        
        backButton.snp.makeConstraints{make in
            make.width.height.equalTo(90).priority(250)
            make.width.height.greaterThanOrEqualTo(75)
        }
        
        //stackView setup
        
        let horizontalStacks = [firstRow, secondRow,thirdRow,fourthRow]
        
        for st in horizontalStacks{
            st.axis = .horizontal
            st.spacing = 29
            st.distribution = .fillEqually
            st.alignment = .fill
            
        }
        
        view.addSubview(allRow)
        
        allRow.axis = .vertical
        allRow.distribution = .fillEqually
        allRow.spacing = 15
        allRow.alignment = .fill
        
        allRow.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(46)
            make.top.equalTo(pinLabel.snp.bottom).offset(52)
            make.bottom.equalToSuperview().inset(158)
        }
        
        //add button in stackView
        firstRow.addArrangedSubview(oneButton)
        firstRow.addArrangedSubview(twoButton)
        firstRow.addArrangedSubview(threeButton)
        firstRow.layoutIfNeeded()
        
        secondRow.addArrangedSubview(fourButton)
        secondRow.addArrangedSubview(fiveButton)
        secondRow.addArrangedSubview(sixButton)
        secondRow.layoutIfNeeded()
        
        thirdRow.addArrangedSubview(sevenButton)
        thirdRow.addArrangedSubview(eightButton)
        thirdRow.addArrangedSubview(nineButton)
        thirdRow.layoutIfNeeded()
        
        fourthRow.addArrangedSubview(questionButton)
        fourthRow.addArrangedSubview(zeroButton)
        fourthRow.addArrangedSubview(backButton)
        fourthRow.layoutIfNeeded()
        
        allRow.addArrangedSubview(firstRow)
        allRow.addArrangedSubview(secondRow)
        allRow.addArrangedSubview(thirdRow)
        allRow.addArrangedSubview(fourthRow)
        allRow.layoutIfNeeded()
        
        
        for i in 0...9{
            numberButtons[i].layer.cornerRadius = numberButtons[i].bounds.size.height * 0.5
        }
        backButton.layer.cornerRadius = backButton.bounds.size.height * 0.5
        questionButton.layer.cornerRadius = questionButton.bounds.size.height * 0.5
        
        view.insertSubview(gestureView, at: .max)
        
        gestureView.backgroundColor = .clear

        gestureView.snp.makeConstraints{make in
            make.edges.equalToSuperview()
        }
        
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panHandle))
        gestureView.addGestureRecognizer(pan)
         
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle))
        gestureView.addGestureRecognizer(tap)
        
        
    }
    
    
    
    
    
}


