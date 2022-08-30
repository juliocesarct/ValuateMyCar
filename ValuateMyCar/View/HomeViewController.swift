//
//  ViewController.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 03/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var cars: [Car?] = []

    private lazy var containerView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(named: "ElementArea")
        element.layer.cornerRadius = 20
        return element
    }()
    
    private lazy var logo: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(systemName: "car.fill")
        element.tintColor = UIColor(named: "ElementColor")
        return element
    }()
    
    private lazy var welcomeTitle: UILabel = {
        let element = UILabel(frame: .zero)
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Welcome to Valuate My Car!"
        element.textColor = UIColor(named: "Black")
        element.font = UIFont(name: "Futura", size: 18)
        element.textAlignment = .center
        return element
    }()
    
    private lazy var welcomeDescription: UILabel = {
        let element = UILabel(frame: .zero)
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Click on the button below to register your first car!"
        element.textColor = UIColor(named: "Black")
        element.font = UIFont(name: "Futura", size: 18)
        element.numberOfLines = 2
        element.textAlignment = .center
        return element
    }()
    
    private lazy var addButton: UIButton = {
        let element = UIButton()
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Add New", for: .normal)
        element.layer.cornerRadius = 10
        element.setTitleColor(UIColor(named: "ElementColor"), for: .normal)
        element.titleLabel?.font = UIFont(name: "Futura-Bold", size: 14)
        element.backgroundColor = UIColor(named: "Background")
        element.addTarget(self, action: #selector(navigateToPage), for: .touchUpInside)
        return element
    }()
    
    private lazy var carCollectionView: UICollectionView = {
        let element = UICollectionView()
        
        element.dataSource = self
        element.delegate = self
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCars()
        setup()
    }
    
    func fetchCars(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            cars = try context.fetch(Car.fetchRequest())
        }catch{
            
        }
        
    }

    @objc func navigateToPage() {
        let addNewVC = AddNewViewController()
        navigationController?.pushViewController(addNewVC, animated: true)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        cell.largeContentTitle = "teste"
        return cell
    }
    
}

extension HomeViewController {
    
    func setup(){
        
        self.view.addSubview(containerView)
        containerView.addSubview(logo)
        containerView.addSubview(welcomeTitle)
        containerView.addSubview(welcomeDescription)
        containerView.addSubview(addButton)
        
        self.view.backgroundColor = UIColor(named: "Background")
    
        self.title = "Valuate My Car"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "ElementColor")!, .font: UIFont(name: "Futura-Bold", size: 22)!]
        
        NSLayoutConstraint.activate([
            
            containerView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            logo.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20),
            logo.widthAnchor.constraint(equalToConstant: 120),
            logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: 100),
            
            welcomeTitle.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            welcomeTitle.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            welcomeTitle.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            
            welcomeDescription.topAnchor.constraint(equalTo: self.welcomeTitle.bottomAnchor, constant: 20),
            welcomeDescription.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            welcomeDescription.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            
            addButton.topAnchor.constraint(equalTo: self.welcomeDescription.bottomAnchor, constant: 20),
            addButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -20),
            addButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            
        ])
        
    }
    
}
