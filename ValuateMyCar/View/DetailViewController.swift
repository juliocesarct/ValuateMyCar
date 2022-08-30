//
//  DetailViewController.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 30/08/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var car: Car!
    
    private lazy var containerView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(named: "ElementArea")
        element.layer.cornerRadius = 20
        return element
    }()
    
    private lazy var roundedImageView: UIImageView = {
        let element = UIImageView()
        let image = UIImage(systemName: "car.fill")?.withRenderingMode(.alwaysTemplate)
        element.backgroundColor = UIColor(named: "Background")
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        element.tintColor = UIColor(named: "ElementColor")
        element.image = image
        element.layer.cornerRadius = 100
        element.layer.masksToBounds = true
        return element
    }()
    
    private lazy var valueTitleLabel: UILabel = {
        let element = UILabel(frame: .zero)
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Current value:"
        element.textColor = UIColor(named: "Black")
        element.font = UIFont(name: "Futura", size: 14)
        element.textAlignment = .center
        return element
    }()
    
    private lazy var valueLabel: UILabel = {
        let element = UILabel(frame: .zero)
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "R$ 0,00"
        element.textColor = UIColor(named: "Black")
        element.font = UIFont(name: "Futura", size: 28)
        element.numberOfLines = 2
        element.textAlignment = .center
        return element
    }()
    
    private lazy var closeButton: UIButton = {
        let element = UIButton()
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Close", for: .normal)
        element.layer.cornerRadius = 10
        element.setTitleColor(UIColor(named: "ElementColor"), for: .normal)
        element.titleLabel?.font = UIFont(name: "Futura-Bold", size: 14)
        element.backgroundColor = UIColor(named: "Background")
        element.addTarget(self, action: #selector(navigateToPage), for: .touchUpInside)
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func navigateToPage() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension DetailViewController {
    
    func setup(){
        
        self.view.addSubview(containerView)
        containerView.addSubview(roundedImageView)
        containerView.addSubview(valueTitleLabel)
        containerView.addSubview(valueLabel)
        containerView.addSubview(closeButton)
        
        self.view.backgroundColor = UIColor(named: "Background")
    
        self.title = car.nickname
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "ElementColor")!, .font: UIFont(name: "Futura-Bold", size: 22)!]
        
        NSLayoutConstraint.activate([
            
            containerView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            roundedImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 40),
            roundedImageView.widthAnchor.constraint(equalToConstant: 200),
            roundedImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            roundedImageView.heightAnchor.constraint(equalToConstant: 200),
            
            valueTitleLabel.topAnchor.constraint(equalTo: self.roundedImageView.bottomAnchor, constant: 20),
            valueTitleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            valueTitleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            
            valueLabel.topAnchor.constraint(equalTo: self.valueTitleLabel.bottomAnchor, constant: 10),
            valueLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            valueLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            
            closeButton.topAnchor.constraint(equalTo: self.valueLabel.bottomAnchor, constant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            closeButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -40),
            
        ])
        
    }
    
}
