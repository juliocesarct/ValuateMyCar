//
//  AddNewViewController.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 19/08/22.
//

import UIKit
import Combine

class AddNewViewController: UIViewController {
    
    private var addNewVM = AddNewViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var brands: [String] = []
    private var models: [String] = ["Focus","Fiesta","Fusion"]
    private var years: [String] = ["2022","2021","2020"]
    
    private lazy var picker: UIPickerView = {
        let element = UIPickerView()
        element.delegate = self
        element.dataSource = self
        return element
    }()

    private lazy var toolbar: UIToolbar = {
        let element = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        element.tintColor = UIColor(named: "ElementColor")
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        element.items = [cancelButton,flexibleSpaceButton,doneButton]
        return element
    }()
    
    private lazy var roundedImage: UIImageView = {
        let element = UIImageView()
        let image = UIImage(systemName: "car.fill")?.withRenderingMode(.alwaysTemplate)
        element.backgroundColor = UIColor(named: "ElementArea")
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        element.tintColor = UIColor(named: "ElementColor")
        element.image = image
        element.layer.cornerRadius = 100
        element.layer.masksToBounds = true
        return element
    }()
    
    private lazy var  containerView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(named: "ElementArea")
        element.layer.cornerRadius = 20
        return element
    }()
    
    private lazy var nicknameTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.placeholder = "Car Nickname"
        element.textAlignment = .center
        element.layer.cornerRadius = 5
        element.backgroundColor = UIColor(named: "Background")
        return element
    }()
    
    private lazy var brandTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.placeholder = "Loading brands..."
        element.isEnabled = false
        element.textAlignment = .center
        element.layer.cornerRadius = 5
        element.backgroundColor = UIColor(named: "Background")
        element.inputView = picker
        element.inputAccessoryView = toolbar
        element.delegate = self
        return element
    }()
    
    private lazy var modelTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.placeholder = "Model"
        element.textAlignment = .center
        element.layer.cornerRadius = 5
        element.backgroundColor = UIColor(named: "Background")
        element.inputView = picker
        element.inputAccessoryView = toolbar
        element.delegate = self
        element.isEnabled = false
        return element
    }()
    
    private lazy var yearTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.placeholder = "Year"
        element.textAlignment = .center
        element.layer.cornerRadius = 5
        element.backgroundColor = UIColor(named: "Background")
        element.inputView = picker
        element.inputAccessoryView = toolbar
        element.delegate = self
        element.isEnabled = false
        return element
    }()
    
    private lazy var saveButton: UIButton = {
        let element = UIButton()
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Save", for: .normal)
        element.setTitle("Fill all fields to save", for: .disabled)
        element.layer.cornerRadius = 10
        element.setTitleColor(UIColor(named: "Background"), for: .normal)
        element.titleLabel?.font = UIFont(name: "Futura-Bold", size: 14)
        element.backgroundColor = UIColor(named: "ElementColor")
        element.isEnabled = false
        //element.addTarget(self, action: #selector(navigateToPage), for: .touchUpInside)
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBinding()
    }
    
}

extension AddNewViewController {
    
    @objc func cancel(){
        brandTextField.resignFirstResponder()
        modelTextField.resignFirstResponder()
        yearTextField.resignFirstResponder()
    }
    
    @objc func done(){
        
        if brandTextField.isFirstResponder{
            brandTextField.text = brands[picker.selectedRow(inComponent: 0)]
            modelTextField.text = ""
            yearTextField.text = ""
            modelTextField.isEnabled = true
        } else if modelTextField.isFirstResponder{
            modelTextField.text = models[picker.selectedRow(inComponent: 0)]
            yearTextField.text = ""
            yearTextField.isEnabled = true
        } else {
            yearTextField.text = years[picker.selectedRow(inComponent: 0)]
        }
        cancel()
    }
    
    func setupBinding(){
        
        addNewVM.$brands.sink{ vmBrands in
            if vmBrands.count > 0{
                
                DispatchQueue.main.async {
                    self.brands = self.addNewVM.brandsNames
                    self.brandTextField.placeholder = "Select a brand"
                    self.brandTextField.isEnabled = true
                }
                
            }
        }.store(in: &cancellables)
        
    }
    
}


extension AddNewViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if brandTextField.isFirstResponder {
            return brands.count
        } else if modelTextField.isFirstResponder {
            return models.count
        }
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if brandTextField.isFirstResponder {
            return brands[row]
        } else if modelTextField.isFirstResponder {
            return models[row]
        }
        return years[row]
    }
    
    
    
}

extension AddNewViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        !(textField.text?.isEmpty ?? true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(nicknameTextField.text?.isEmpty ?? true) && !(yearTextField.text?.isEmpty ?? true){
            saveButton.isEnabled = true
        }
    }
    
}

extension AddNewViewController {
    
    func setup(){
        
        self.view.addSubview(roundedImage)
        self.view.addSubview(containerView)
        containerView.addSubview(nicknameTextField)
        containerView.addSubview(brandTextField)
        containerView.addSubview(modelTextField)
        containerView.addSubview(yearTextField)
        containerView.addSubview(saveButton)
        
        self.view.backgroundColor = UIColor(named: "Background")
        navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
        navigationController?.navigationBar.tintColor = UIColor(named: "ElementColor")
        
        NSLayoutConstraint.activate([
            
            roundedImage.bottomAnchor.constraint(equalTo: self.containerView.topAnchor, constant: -20),
            roundedImage.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            roundedImage.heightAnchor.constraint(equalToConstant: 200),
            roundedImage.widthAnchor.constraint(equalToConstant: 200),
            
            containerView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            nicknameTextField.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20),
            nicknameTextField.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
            nicknameTextField.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            nicknameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            brandTextField.topAnchor.constraint(equalTo: self.nicknameTextField.bottomAnchor, constant: 20),
            brandTextField.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
            brandTextField.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            brandTextField.heightAnchor.constraint(equalToConstant: 30),
                                    
            modelTextField.topAnchor.constraint(equalTo: self.brandTextField.bottomAnchor, constant: 20),
            modelTextField.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
            modelTextField.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            modelTextField.heightAnchor.constraint(equalToConstant: 30),
            
            yearTextField.topAnchor.constraint(equalTo: self.modelTextField.bottomAnchor, constant: 20),
            yearTextField.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
            yearTextField.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            yearTextField.heightAnchor.constraint(equalToConstant: 30),
            
            saveButton.topAnchor.constraint(equalTo: self.yearTextField.bottomAnchor, constant: 40),
            saveButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -20),
            saveButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            
        ])
    }
    
}