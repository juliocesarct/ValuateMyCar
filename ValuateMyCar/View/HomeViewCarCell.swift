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
        element.contentMode = .scaleAspectFit
        element.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
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
    }
    
   private func setup() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let innerView = UIView()
        innerView.backgroundColor = .white
        innerView.layer.cornerRadius = 8
        innerView.layer.masksToBounds = true
        innerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(innerView)
        
        innerView.addSubview(carImage)
        innerView.addSubview(carNickname)
        
        NSLayoutConstraint.activate([
            
            innerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            innerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            innerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            innerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            carImage.topAnchor.constraint(equalTo: innerView.topAnchor, constant: 20),
            carImage.leadingAnchor.constraint(equalTo: innerView.leadingAnchor),
            carImage.heightAnchor.constraint(equalToConstant: 120),
            carImage.widthAnchor.constraint(equalTo: innerView.widthAnchor),
            
            carNickname.topAnchor.constraint(equalTo: carImage.bottomAnchor, constant: 10),
            carNickname.bottomAnchor.constraint(equalTo: innerView.bottomAnchor, constant: -10),
            carNickname.centerXAnchor.constraint(equalTo: innerView.centerXAnchor)

        ])
    }
}

extension HomeViewCarCell {
    static var reuseIdentifier: String {
        return "reuseHomeViewCarCell"
    }
}

