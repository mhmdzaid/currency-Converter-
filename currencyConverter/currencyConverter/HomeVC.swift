//
//  HomeVC.swift
//  currencyConverter
//
//  Created by mohamed zead on 9/13/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class currency : Decodable{
    let error : Int
    let error_message : String
    let amount : Double
}
class HomeVC: UIViewController , UIPickerViewDataSource,UIPickerViewDelegate{
     var FromCurrency = ""
     var ToCurrency = ""
    let currencies = ["USD","AUD","JPY","CHF","EUR","GBP","CNY","CAD"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            ToCurrency = currencies[row]
        }else{
            FromCurrency = currencies[row]
        }
        
    }
    
    @IBOutlet weak var convertBtn: UIButton!
    @IBOutlet weak var amountTxtField: UITextField!
    @IBOutlet weak var FromPicker: UIPickerView!
    @IBOutlet weak var toPicker: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FromPicker.delegate = self
        FromPicker.dataSource = self
        toPicker.delegate = self
        toPicker.dataSource = self
        // set the first selected and default in pickerView
        ToCurrency = currencies[0]
        FromCurrency = currencies[0]
        convertBtn.layer.cornerRadius = 20
    }

    @IBAction func convertBtnPressed(_ sender: Any) {
        if amountTxtField.text != nil{
            print("from \(FromCurrency).......to \(ToCurrency)")
            let strUrl = String("https://www.amdoren.com/api/currency.php?api_key=zfSNUCRcm848hJnV2UAnbnhKvNcWBK&from=\(FromCurrency)&to=\(ToCurrency)&amount=\(amountTxtField.text!)")
            let url = URL(string: strUrl)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
               
                do{
                    let myData =  try JSONDecoder().decode(currency.self, from: data!)
                    DispatchQueue.main.sync {
                        self.resultLabel.text = String(myData.amount)
                    }
                    
                }catch{
                    print("something went wrong ")
                }
            }).resume()
        }
    }
    
}
