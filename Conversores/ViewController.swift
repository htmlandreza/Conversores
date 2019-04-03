//
//  ViewController.swift
//  Conversores
//
//  Created by Andreza Moreira on 14/03/19.
//  Copyright © 2019 Andreza Moreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var valueInputTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultUnitLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var unitSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueInputTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // tirar o foco ao tocar em outras partes da tela
        view.endEditing(true)
    }
    
    @IBAction func showNext(_ sender: UIButton) {
        switch unitLabel.text! {
        case "Temperatura":
            unitLabel.text = "Peso" // título da tela
            //btUnit1.setTitle("Kilograma", for: .normal) // nome do botão 1
            //btUnit2.setTitle("Libra", for: .normal) // nome do botão 2
            unitSegmentedControl.setTitle("Kilograma", forSegmentAt: 0)
            unitSegmentedControl.setTitle("Libra", forSegmentAt: 1)
        case "Peso":
            unitLabel.text = "Moeda"
            unitSegmentedControl.setTitle("Real", forSegmentAt: 0)
            unitSegmentedControl.setTitle("Dólar", forSegmentAt: 1)
        case "Moeda":
            unitLabel.text = "Distância"
            unitSegmentedControl.setTitle("Metro", forSegmentAt: 0)
            unitSegmentedControl.setTitle("Kilômetro", forSegmentAt: 1)
        default:
            unitLabel.text = "Temperatura"
            unitSegmentedControl.setTitle("Celsius", forSegmentAt: 0)
            unitSegmentedControl.setTitle("Farenhein", forSegmentAt: 1)
        }
        
        valueInputTextField.text = "" // se muda de opção, apaga o valor anterior
        
        convert(nil)
        resultLabel.isHidden = true
        resultUnitLabel.isHidden = true
    }
    
    func unitLabelTypes(){
        switch unitLabel.text! {
        case "Temperatura":
        calcTemperature()
        case "Peso":
        calcWeight()
        case "Moeda":
        calcCurrency()
        default:
        calcDistance()
        }
    }
    
    func resultLabelFormat(){
        let result = Double(resultLabel.text!)!
        resultLabel.text = String(format: "%.2f", result)
    }
    
    @IBAction func convert(_ sender: UISegmentedControl?) {
        unitLabelTypes()
        
        view.endEditing(true) // faz o teclado desaparecer
        resultLabelFormat()
    }
    
    func calcTemperature(){
        guard let temperature = Double(valueInputTextField.text!) else {return}
        
        // se o botão estiver em destaque
        if unitSegmentedControl.selectedSegmentIndex == 0 && valueInputTextField.text != ""{
            resultUnitLabel.text = "Farenheint" // nome da descrição do valor
            resultLabel.text = String(temperature * 1.8 + 32.0)
            
        }
        if unitSegmentedControl.selectedSegmentIndex == 1 && valueInputTextField.text != ""{
            resultUnitLabel.text = "Celsius"
            resultLabel.text = String((temperature - 32.0)/1.8)
        }
        if valueInputTextField.text == ""{
            resultLabel.isHidden = true
            resultUnitLabel.isHidden = true
        }
        
        resultLabelFormat()
        
        resultLabel.isHidden = false
        resultUnitLabel.isHidden = false
    }
    
    func calcWeight(){
        guard let weight = Double(valueInputTextField.text!) else {return}
        
        if unitSegmentedControl.selectedSegmentIndex == 0 && valueInputTextField.text != ""{
            resultUnitLabel.text = "Libra"
            resultLabel.text = String(weight / 2.2046)
        }
        if unitSegmentedControl.selectedSegmentIndex == 1 && valueInputTextField.text != ""{
            resultUnitLabel.text = "Kilograma"
            resultLabel.text = String(weight * 2.2046)
        }
        if valueInputTextField.text == ""{
            resultLabel.isHidden = true
            resultUnitLabel.isHidden = true
        }
        
        resultLabelFormat()
        
        resultLabel.isHidden = false
        resultUnitLabel.isHidden = false
    }
    
    func calcCurrency(){
        guard let currency = Double(valueInputTextField.text!) else {return}
        
        if unitSegmentedControl.selectedSegmentIndex == 0 && valueInputTextField.text != "" {
            resultUnitLabel.text = "Dólar"
            resultLabel.text = String(currency / 3.81)
        }
        if unitSegmentedControl.selectedSegmentIndex == 1 && valueInputTextField.text != ""{
            resultUnitLabel.text = "Real"
            resultLabel.text =  String(currency * 3.81)
        }
        if valueInputTextField.text == ""{
            resultLabel.isHidden = true
            resultUnitLabel.isHidden = true
        }
        
        resultLabelFormat()
        
        resultLabel.isHidden = false
        resultUnitLabel.isHidden = false
    }
    
    func calcDistance(){
        guard let distance = Double(valueInputTextField.text!) else {return}
        
        if unitSegmentedControl.selectedSegmentIndex == 0 && valueInputTextField.text != "" {
            resultUnitLabel.text = "Kilômetros"
            resultLabel.text = String(distance / 1000)
        }
        if unitSegmentedControl.selectedSegmentIndex == 1 && valueInputTextField.text != ""{
            resultUnitLabel.text = "Metros"
            resultLabel.text = String(distance * 1.8)
        }
        if valueInputTextField.text == ""{
            resultLabel.isHidden = true
            resultUnitLabel.isHidden = true
        }
        
        resultLabelFormat()
        
        resultLabel.isHidden = false
        resultUnitLabel.isHidden = false
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        unitLabelTypes()
    }
    
    
}

