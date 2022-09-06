//
//  HomeViewCarCell.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 31/08/22.
//

import UIKit

class HomeViewCarCell: UICollectionViewCell {
    
    private lazy var carImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clipsToBounds = true
        element.layer.cornerRadius = 8
        element.image = UIImage(systemName: "car")
        element.tintColor = .gray
        element.contentMode = .scaleAspectFill
        element.layer.cornerRadius = 20
        return element
    }()
    
    private lazy var carNickname: UILabel = {
        let element = UILabel(frame: .zero)
        element.font = UIFont(name: "Futura-Bold", size: 16)
        element.textColor = UIColor(named: "black")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setCellData(car: Car) {
        
        if let name = car.nickname {
            carNickname.text = name
        }
        
        if let image = car.carImage{
            carImage.image = image
        }
        
    }
    
   private func setup() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 8
       
        let innerView = UIView()
        innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.backgroundColor = UIColor(named: "Background")
        innerView.layer.cornerRadius = 8
        innerView.layer.masksToBounds = true
        
        contentView.addSubview(innerView)
        
        innerView.addSubview(carImage)
        innerView.addSubview(carNickname)
        
        NSLayoutConstraint.activate([
            
            innerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            innerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            innerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            innerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            carImage.topAnchor.constraint(equalTo: innerView.topAnchor, constant: 20),
            carImage.centerXAnchor.constraint(equalTo: innerView.centerXAnchor),
            carImage.heightAnchor.constraint(equalToConstant: 120),
            carImage.widthAnchor.constraint(equalToConstant: 240),
            
            carNickname.topAnchor.constraint(equalTo: carImage.bottomAnchor, constant: 15),
            carNickname.centerXAnchor.constraint(equalTo: innerView.centerXAnchor)

        ])
    }
}

extension HomeViewCarCell {
    static var reuseIdentifier: String {
        return "reuseHomeViewCarCell"
    }
}

