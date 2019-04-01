//
//  CEViewControllerDate.swift
//  CuriosityEye
//
//  Created by Camille Tilmont on 28/10/2017.
//  Copyright © 2017 Camille Tilmont. All rights reserved.
//

import UIKit
import PopupDialog


class CEViewControllerDate: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var pickerViewCamera: UIPickerView!
    @IBOutlet var buttonGoToMars: UIButton!
    @IBOutlet var buttonInfos: UIButton!
    
    
    
    let cameras : [String] = ["Front Hazard Avoidance Camera", "Rear Hazard Avoidance Camera", "Mast Camera", "Chemistry and Camera Complex", "Mars Hand Lens Imager", "Mars Descent Imager", "Navigation Camera"]
    
    var cameraMin = ""
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cameras.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cameras[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cameraMin = cameras[row]
    }
    
    private var launch = 0

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        buttonGoToMars.layer.cornerRadius = 7
        buttonInfos.layer.cornerRadius = 19
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "YYYY-MM-dd"
        let loc = Locale(identifier: "fr_FR")
        datePicker.locale = loc
        
        let date = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        
       datePicker.maximumDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        
        

        
        datePicker.date = date!
        print(datePicker.date)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        if UserDefaults.standard.integer(forKey: "launch") == 1{
            launch = UserDefaults.standard.integer(forKey: "launch")}
        
        if launch == 0{
        popup()
        }
        
        UserDefaults.standard.set(launch, forKey: "launch")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func popup (){
        
        let title = "Bienvenu dans les yeux de Curiosity"
        let message = """

- Choisissez une des caméras de Curiosity
- Choisissez une date

Regardez Mars comme si vous y étiez.
"""

        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message)
        let vc = popup.viewController as! PopupDialogDefaultViewController
        
        vc.titleFont = UIFont(name: "Optima-Bold", size: 22)!
        vc.messageFont = UIFont(name: "Optima", size: 17)!
        
        let buttonOne = DefaultButton(title: "GO To Mars") {
        }
        
        popup.addButton(buttonOne)
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
        launch = 1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToMars"){
            
            let destinationViewController : CEViewControllerCollectionView = segue.destination as! CEViewControllerCollectionView
            
            let formater = DateFormatter()
            formater.dateFormat = "YYYY-MM-dd"
            let dateSend = formater.string(from: datePicker.date)
            destinationViewController.dateChoose = dateSend
            
            
            if cameraMin == "Front Hazard Avoidance Camera"{
                
                destinationViewController.cameraChoose = "FHAZ"
                
            }else if cameraMin == "Rear Hazard Avoidance Camera"{
                
                destinationViewController.cameraChoose = "RHAZ"
                
            }else if cameraMin == "Mast Camera"{
                
                destinationViewController.cameraChoose = "MAST"
                
            }else if cameraMin == "Chemistry and Camera Complex"{
                
                destinationViewController.cameraChoose = "CHEMCAM"
                
            }else if cameraMin ==  "Mars Hand Lens Imager"{
                
                destinationViewController.cameraChoose = "MAHLI"
                
            }else if cameraMin == "Mars Descent Imager"{
                
                destinationViewController.cameraChoose = "MARDI"
                
            }else if cameraMin == "Navigation Camera"{
                
                destinationViewController.cameraChoose = "NAVCAM"
                
            }else if cameraMin == "" {
                
                destinationViewController.cameraChoose = "FHAZ"
            }
            
            
    }
    
    }
    
    
    @IBAction func actionGoToMars(_ sender: Any) {
  
    }

 

    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
    }
    
}
