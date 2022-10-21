//
//  DetailViewController.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 30/08/22.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    weak var car: Car!
    weak var coordinator: MainCoordinator?
    
    private let detailVM: DetailViewModel = DetailViewModel()
    private var cancellables = Set<AnyCancellable>()
    private let activityIndicator = UIActivityIndicatorView()
    
    private lazy var modalView: ModalView = {
        return ModalView()
    }()
    
    private lazy var containerView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(named: "ElementArea")
        element.layer.cornerRadius = 20
        element.isHidden = true
        return element
    }()
    
    private lazy var modelLabel: UILabel = {
        let element = UILabel(frame: .zero)
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Loading..."
        element.textColor = UIColor(named: "Black")
        element.font = UIFont(name: "Futura-Bold", size: 18)
        element.textAlignment = .center
        return element
    }()
    
    private lazy var roundedImageView: UIImageView = {
        let element = UIImageView()
        let image = UIImage(systemName: "camera")?.withRenderingMode(.alwaysTemplate)
        element.backgroundColor = UIColor(named: "Background")
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        element.tintColor = .gray
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
        element.font = UIFont(name: "Futura", size: 18)
        element.textAlignment = .center
        return element
    }()
    
    private lazy var valueLabel: UILabel = {
        let element = UILabel(frame: .zero)
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Loading..."
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
        element.setTitleColor(UIColor(named: "Background"), for: .normal)
        element.titleLabel?.font = UIFont(name: "Futura-Bold", size: 14)
        element.backgroundColor = UIColor(named: "ElementColor")
        element.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
        return element
    }()
    
    private lazy var deleteButton: UIButton = {
        let element = UIButton()
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Delete", for: .normal)
        element.layer.cornerRadius = 10
        element.setTitleColor( .red , for: .normal)
        element.titleLabel?.font = UIFont(name: "Futura-Bold", size: 14)
        element.backgroundColor = UIColor(named: "Background")
        element.addTarget(self, action: #selector(deleteCar), for: .touchUpInside)
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setup()
    }
    
    func setupBinding(){
        
        detailVM.$valuation.sink { valuation in
            if let valuation = valuation{
                DispatchQueue.main.async {
                    if let carImage = self.car.carImage{
                        self.roundedImageView.contentMode = .scaleAspectFill
                        self.roundedImageView.image = carImage
                    }
                    self.valueLabel.text = valuation.valuation
                    self.modelLabel.text = valuation.model
                    self.containerView.isHidden = false
                    self.activityIndicator.stopAnimating()
                
                }
            }
            
        }.store(in: &cancellables)
        
        detailVM.$references.sink { refs in
           
            if refs.count > 0 {
                self.detailVM.getValuation(car: self.car, reference: refs[0] )
            }
            
        }.store(in: &cancellables)
        
        detailVM.$errorString.sink {errorString in
            if !errorString.isEmpty {
                
                DispatchQueue.main.async {
                    let errorVC = ErrorViewController()
                    errorVC.titleLabel.text = "Error"
                    errorVC.descriptionLabel.text = errorString
                    self.present(errorVC, animated: false)
                    
                }

            }
            
        }.store(in: &cancellables)
        
    }
    
    @objc func backToHome() {
        navigationController?.popViewController(animated: false)
    }
    
}

extension DetailViewController: ModalViewProtocol{
    
    @objc func deleteCar() {
        
        modalView.setup()
        modalView.delegate = self
        self.view.addSubview(modalView)
        
        NSLayoutConstraint.activate([
            
            modalView.topAnchor.constraint(equalTo: self.view.topAnchor),
            modalView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            modalView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            modalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        ])
    }
    
    func confirmAction() {
        detailVM.deleteCar(car: car)
        backToHome()
    }
    
}

extension DetailViewController {
    
    func setup(){
        
        self.view.addSubview(containerView)
        self.view.addSubview(activityIndicator)
        containerView.addSubview(modelLabel)
        containerView.addSubview(roundedImageView)
        containerView.addSubview(valueTitleLabel)
        containerView.addSubview(valueLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(deleteButton)
        
        activityIndicator.center = self.view.center
        activityIndicator.color = UIColor(named: "ElementColor")
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        
        self.view.backgroundColor = UIColor(named: "Background")
    
        self.title = car.nickname
        self.navigationController?.navigationBar.tintColor = UIColor(named: "ElementColor")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "ElementColor")!, .font: UIFont(name: "Futura-Bold", size: 22)!]
        
        NSLayoutConstraint.activate([
            
            containerView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            modelLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 40),
            modelLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            modelLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            modelLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            
            roundedImageView.topAnchor.constraint(equalTo: self.modelLabel.bottomAnchor, constant: 20),
            roundedImageView.widthAnchor.constraint(equalToConstant: 200),
            roundedImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            roundedImageView.heightAnchor.constraint(equalToConstant: 200),
            
            valueTitleLabel.topAnchor.constraint(equalTo: self.roundedImageView.bottomAnchor, constant: 20),
            valueTitleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            valueTitleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            
            valueLabel.topAnchor.constraint(equalTo: self.valueTitleLabel.bottomAnchor, constant: 10),
            valueLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            valueLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            
            closeButton.topAnchor.constraint(equalTo: self.valueLabel.bottomAnchor, constant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            
            deleteButton.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 20),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            deleteButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            deleteButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -20),
            
        ])
        
    }
    
}
