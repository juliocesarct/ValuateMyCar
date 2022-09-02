//
//  ViewController.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 03/08/22.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    private var cars: [Car?] = []
    private let homeVM = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()

    private lazy var containerView1: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(named: "ElementArea")
        element.layer.cornerRadius = 20
        return element
    }()
    
    private lazy var containerView2: UIView = {
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
        element.setTitleColor(UIColor(named: "Background"), for: .normal)
        element.titleLabel?.font = UIFont(name: "Futura-Bold", size: 14)
        element.backgroundColor = UIColor(named: "ElementColor")
        element.addTarget(self, action: #selector(navigateToPage), for: .touchUpInside)
        return element
    }()
    
    private lazy var carCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 360, height: 200)
        let element = UICollectionView(frame: .zero, collectionViewLayout: layout)
        element.register(HomeViewCarCell.self, forCellWithReuseIdentifier: HomeViewCarCell.reuseIdentifier)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        element.layer.cornerRadius = 8
        element.alwaysBounceVertical = false
        element.showsHorizontalScrollIndicator = true
        element.dataSource = self
        element.delegate = self
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        homeVM.fetchCars()
        carCollectionView.reloadData()
        cars.count > 0 ? setupCollection() : setupWelcome()
    }

    @objc func navigateToPage() {
        let addNewVC = AddNewViewController()
        navigationController?.pushViewController(addNewVC, animated: true)
    }
    
    func setupBinding(){
        
        homeVM.$cars.sink { cars in
            self.cars = cars
        }.store(in: &cancellables)
        
        homeVM.$errorString.sink { errorString in
            print(errorString)
        }.store(in: &cancellables)
        
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCarCell.reuseIdentifier, for: indexPath) as? HomeViewCarCell else { return UICollectionViewCell() }
        guard let car = cars[indexPath.row]
            else { return UICollectionViewCell() }
        cell.setCellData(car: car)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let car = cars[indexPath.row] else {return}
        let detailVC = DetailViewController()
        detailVC.car = car
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension HomeViewController {
    
    func setup(){
                
        self.view.backgroundColor = UIColor(named: "Background")
        self.title = "Valuate My Car App"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "ElementColor")!, .font: UIFont(name: "Futura-Bold", size: 22)!]
        
    }
    
    func setupWelcome(){
        
        self.view.addSubview(containerView1)
        containerView1.addSubview(addButton)
        containerView1.addSubview(logo)
        containerView1.addSubview(welcomeTitle)
        containerView1.addSubview(welcomeDescription)
        
        carCollectionView.isHidden = true
        logo.isHidden = false
        welcomeDescription.isHidden = false
        
        welcomeTitle.text = "Welcome to Valuate My Car!"
        welcomeTitle.textColor = UIColor(named: "Black")
        welcomeTitle.font = UIFont(name: "Futura", size: 18)
        
        NSLayoutConstraint.activate([
            
            containerView1.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            containerView1.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerView1.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            logo.topAnchor.constraint(equalTo: self.containerView1.topAnchor, constant: 20),
            logo.widthAnchor.constraint(equalToConstant: 120),
            logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: 100),
            
            welcomeTitle.topAnchor.constraint(equalTo: self.logo.bottomAnchor,constant: 20),
            welcomeTitle.leadingAnchor.constraint(equalTo: self.containerView1.leadingAnchor, constant: 10),
            welcomeTitle.trailingAnchor.constraint(equalTo: self.containerView1.trailingAnchor, constant: -10),
            
            welcomeDescription.topAnchor.constraint(equalTo: self.welcomeTitle.bottomAnchor, constant: 20),
            welcomeDescription.leadingAnchor.constraint(equalTo: self.containerView1.leadingAnchor, constant: 10),
            welcomeDescription.trailingAnchor.constraint(equalTo: self.containerView1.trailingAnchor, constant: -10),
            welcomeDescription.bottomAnchor.constraint(equalTo: self.addButton.topAnchor, constant: -40),
            
            addButton.bottomAnchor.constraint(equalTo: self.containerView1.bottomAnchor, constant: -20),
            addButton.leadingAnchor.constraint(equalTo: self.containerView1.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: self.containerView1.trailingAnchor, constant: -20),
            
        ])
        
        containerView2.removeFromSuperview()
    }
    
    func setupCollection(){
        
        self.view.addSubview(containerView2)
        containerView2.addSubview(addButton)
        containerView2.addSubview(carCollectionView)
        containerView2.addSubview(welcomeTitle)
        
        welcomeTitle.text = "Cars in my garage"
        welcomeTitle.textColor = UIColor(named: "ElementColor")
        welcomeTitle.font = UIFont(name: "Futura", size: 18)
        
        logo.isHidden = true
        welcomeDescription.isHidden = true
        carCollectionView.isHidden = false
        
        NSLayoutConstraint.activate([
            
            containerView2.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView2.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            containerView2.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerView2.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            welcomeTitle.topAnchor.constraint(equalTo: self.containerView2.topAnchor, constant: 20),
            welcomeTitle.leadingAnchor.constraint(equalTo: self.containerView2.leadingAnchor, constant: 10),
            welcomeTitle.trailingAnchor.constraint(equalTo: self.containerView2.trailingAnchor, constant: -10),
            
            carCollectionView.topAnchor.constraint(equalTo: self.welcomeTitle.bottomAnchor, constant: 20),
            carCollectionView.leadingAnchor.constraint(equalTo: self.containerView2.leadingAnchor, constant: 10),
            carCollectionView.trailingAnchor.constraint(equalTo: self.containerView2.trailingAnchor, constant: -10),
            carCollectionView.bottomAnchor.constraint(equalTo: self.addButton.topAnchor, constant: -40),
            
            addButton.bottomAnchor.constraint(equalTo: self.containerView2.bottomAnchor, constant: -20),
            addButton.leadingAnchor.constraint(equalTo: self.containerView2.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: self.containerView2.trailingAnchor, constant: -20),
        
        ])
        containerView1.removeFromSuperview()
    }
    
}
