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
        element.tintColor = .gray
        element.contentMode = .scaleAspectFit
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
            carImage.contentMode = .scaleAspectFill
        }else{
            carImage.image = UIImage(systemName: "camera")
            carImage.contentMode = .scaleAspectFit
        }
        
    }
    
   private func setup() {
        self.backgroundColor = .clear
        
        contentView.backgroundColor = UIColor(named: "Background")
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.addSubview(carImage)
        contentView.addSubview(carNickname)

        NSLayoutConstraint.activate([
            
            carImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            carImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            carImage.heightAnchor.constraint(equalToConstant: 120),
            carImage.widthAnchor.constraint(equalToConstant: 240),
            
            carNickname.topAnchor.constraint(equalTo: carImage.bottomAnchor, constant: 15),
            carNickname.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)

        ])
    }
}

extension HomeViewCarCell {
    static var reuseIdentifier: String {
        return "reuseHomeViewCarCell"
    }
}

