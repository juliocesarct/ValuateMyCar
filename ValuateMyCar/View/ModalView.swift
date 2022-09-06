//
//  ModalView.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 05/09/22.
//

import UIKit

protocol ModalViewProtocol {
    func confirmAction()
}

class ModalView: UIView{
    
    var delegate: ModalViewProtocol? = nil
    
    private lazy var modalContainerView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(named: "Background")
        element.layer.cornerRadius = 20
        return element
    }()
    
    private lazy var modalLabel: UILabel = {
        let element = UILabel(frame: .zero)
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Confirm delete?"
        element.textColor = UIColor(named: "Black")
        element.font = UIFont(name: "Futura", size: 14)
        element.textAlignment = .center
        return element
    }()
    
    private lazy var confirmButton: UIButton = {
        let element = UIButton()
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Confirm", for: .normal)
        element.layer.cornerRadius = 10
        element.setTitleColor(UIColor(named: "Background"), for: .normal)
        element.titleLabel?.font = UIFont(name: "Futura-Bold", size: 14)
        element.backgroundColor = UIColor(named: "ElementColor")
        element.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        return element
    }()
    
    private lazy var closeButton: UIButton = {
        let element = UIButton()
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Close", for: .normal)
        element.layer.cornerRadius = 10
        element.setTitleColor( UIColor(named: "ElementColor") , for: .normal)
        element.titleLabel?.font = UIFont(name: "Futura-Bold", size: 14)
        element.backgroundColor = UIColor(named: "ElementArea")
        element.addTarget(self, action: #selector(close), for: .touchUpInside)
        return element
    }()
    
    @objc func confirm(){
        if let delegate = delegate {
            delegate.confirmAction()
        }
    }
    
    @objc func close(){
        self.removeFromSuperview()
    }
}


extension ModalView {
    func setup(){
        
        self.addSubview(modalContainerView)
        
        modalContainerView.addSubview(modalLabel)
        modalContainerView.addSubview(confirmButton)
        modalContainerView.addSubview(closeButton)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            
            modalContainerView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            modalContainerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            modalContainerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            modalLabel.topAnchor.constraint(equalTo: modalContainerView.topAnchor,constant: 40),
            modalLabel.centerXAnchor.constraint(equalTo: modalContainerView.centerXAnchor),
            
            confirmButton.topAnchor.constraint(equalTo: modalLabel.bottomAnchor,constant: 40),
            confirmButton.leadingAnchor.constraint(equalTo: modalContainerView.leadingAnchor,constant: 10),
            confirmButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor,constant: -10),
            confirmButton.bottomAnchor.constraint(equalTo: modalContainerView.bottomAnchor, constant: -10),
            
            closeButton.topAnchor.constraint(equalTo: modalLabel.bottomAnchor,constant: 40),
            closeButton.leadingAnchor.constraint(equalTo: confirmButton.trailingAnchor,constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: modalContainerView.trailingAnchor,constant: -10),
            closeButton.bottomAnchor.constraint(equalTo: modalContainerView.bottomAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalTo: confirmButton.widthAnchor)

        ])
        
    }
}
