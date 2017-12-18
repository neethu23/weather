//
//  ViewController.swift
//  weather
//
//  Created by Somasekharan, Neethu on 5/27/16.
//  Copyright © 2016 neethu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    //var wasSucessful = false
    @IBAction func find(_ sender: AnyObject) {
        
        var wasSucessful = false
        
        let attemptedUrl = URL(string: "http://www.weather-forecast.com/locations/" + textField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl{
            
         let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)
                
                let webArray = webContent!.components(separatedBy: "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if webArray.count > 1{
                    
                    let weatherArray = webArray[1].components(separatedBy: "</span>")

                    
                    if weatherArray.count > 1{
                        
                        wasSucessful = true
                        
                        let line = weatherArray[0].replacingOccurrences(of: "&deg;", with: "º")
                        
                        DispatchQueue.main.async(execute: { () -> Void in

                            self.label.text = line
                        })
                        
                    }
                    
                }
                
            }
            /*if wasSucessful == false {
             
             self.label.text = " please enter a valid city"
             
             }*/
         })
            
            task.resume()
            
            
            //if not right url then wont go inside the task so error msg has to be written outside the task
            // as is false in the beginning it shows please enter a valid city for a second before showing the right output. have to find a work around.
            if wasSucessful == false {
                
                self.label.text = " please enter a valid city"
            }
            
            //task.resume()
            
        } else {
            
            self.label.text = "Please enter a valid City"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




                        








