//
//  ErrorView.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 05/09/22.
//

import UIKit

class ErrorViewController: UIViewController{
    
    private lazy var container: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(named: "ElementArea")
        element.layer.cornerRadius = 20
        return element
    }()
    
    lazy var titleLabel: UILabel = {
        let element = UILabel(frame: .zero)
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = UIColor(named: "Black")
        element.font = UIFont(name: "Futura-Bold", size: 24)
        element.textAlignment = .center
        return element
    }()
    
    lazy var descriptionLabel: UILabel = {
        let element = UILabel(frame: .zero)
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = UIColor(named: "Black")
        element.font = UIFont(name: "Futura", size: 14)
        element.numberOfLines = 3
        element.lineBreakMode = .byTruncatingTail
        element.textAlignment = .center
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
}

extension ErrorViewController{
    func setup(){
        
        self.view.backgroundColor = .clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
        self.view.addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            
            container.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            container.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            container.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor,constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20 ),
            descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -40 ),
        
        ])
        
    }
}
