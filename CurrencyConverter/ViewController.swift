//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Radhi Mighri on 02/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tndLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: UIButton) {
      //  1- Create a request & open a session
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=877a665c92eec4b52b2a40bad36fe1c8")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                // 2- Getting the response (Data)
                if data != nil {
                    //JSONSerialization : An object that converts between JSON and the equivalent Foundation objects(Int, String, Double..).
                    do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        //Async
                        DispatchQueue.main.async {
                            //                            print(jsonResponse)
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                if let tnd = rates["TND"] as? Double{
                                    self.tndLabel.text = "TND: \(tnd)"
                                }
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let tryy = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY: \(tryy)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD: \(usd)"
                                }

                                
                            }
                            
                        }
                        
                    } catch {
                        print("Error")
                    }
                    }
                
                
            }
        }
        
        // 3- Process the data (Parsing: or JSON Serialization)
        task.resume() // starting the task
    }
    
}

// to allow working with the "http" protocol rather than the "https" one, we have to go to "info.plist" add(+) "App Arbitrary Loads" key , then add a sub key "Allow Arbitary Loads" and change its value to "Yes"
