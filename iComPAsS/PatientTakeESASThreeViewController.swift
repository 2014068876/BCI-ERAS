//
//  PatientTakeESASThreeViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 25/01/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakeESASThreeViewController: UIViewController {
    
    private struct PTEThree {
        static let toBodyDiagram = "show front"
    }

    @IBOutlet var sharpPain: BEMCheckBox!
    @IBOutlet var stabbingPain: BEMCheckBox!
    @IBOutlet var prickingPain: BEMCheckBox!
    @IBOutlet var burningPain: BEMCheckBox!
    @IBOutlet var boringPain: BEMCheckBox!
    @IBOutlet var splittingPain: BEMCheckBox!
    @IBOutlet var achingPain: BEMCheckBox!
    @IBOutlet var shootingPain: BEMCheckBox!
    @IBOutlet var throbbingPain: BEMCheckBox!
    @IBOutlet var crushingPain: BEMCheckBox!
    @IBOutlet var cuttingPain: BEMCheckBox!
    @IBOutlet var numbingpain: BEMCheckBox!
    @IBOutlet var tiringPain: BEMCheckBox!
    @IBOutlet var stretchingPain: BEMCheckBox!
    @IBOutlet var pressingPain: BEMCheckBox!
    
    
    @IBOutlet var sharpPainLabel: UILabel!
    @IBOutlet var crushingPainLabel: UILabel!
    @IBOutlet var cuttingPainLabel: UILabel!
    @IBOutlet var numbingPainLabel: UILabel!
    @IBOutlet var tiringPainLabel: UILabel!
    @IBOutlet var stretchingPainLabel: UILabel!
    @IBOutlet var pressingPainLabel: UILabel!
    @IBOutlet var stabbingPainLabel: UILabel!
    @IBOutlet var prickingPainLabel: UILabel!
    @IBOutlet var burningPainLabel: UILabel!
    @IBOutlet var boringPainLabel: UILabel!
    @IBOutlet var splittingPainLabel: UILabel!
    @IBOutlet var achingPainLabel: UILabel!
    @IBOutlet var shootingPainLabel: UILabel!
    @IBOutlet var throbbingPainLabel: UILabel!
    var esas = ESAS()
    var language = ""
    var painTypes = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        sharpPainLabel.text = esas.sharp
        crushingPainLabel.text = esas.crushing
        cuttingPainLabel.text = esas.cutting
        numbingPainLabel.text = esas.numbing
        tiringPainLabel.text = esas.tiring
        stretchingPainLabel.text = esas.stretching
        pressingPainLabel.text = esas.pressing
        //tirednessPainLabel.text = esas.tiring
        stabbingPainLabel.text = esas.stabbing
        prickingPainLabel.text = esas.pricking
        burningPainLabel.text = esas.burning
        boringPainLabel.text = esas.boring
        splittingPainLabel.text = esas.splitting
        achingPainLabel.text = esas.aching
        shootingPainLabel.text = esas.shooting
        throbbingPainLabel.text = esas.throbbing
        
    }

    @IBAction func nextPage(sender: UIBarButtonItem) {
        
//        if (sharpPain.on == false && crushingPain.on == false && cuttingPain.on == false && numbingpain.on == false && tiringPain.on == false && stretchingPain.on == false && pressingPain.on == false && stabbingPain.on == false && prickingPain.on == false && burningPain.on == false && boringPain.on == false && splittingPain.on == false && achingPain.on == false && shootingPain.on == false && throbbingPain.on == false){
//            
//        } else {
            if sharpPain.on == true { addPainType("sharp") }
            if crushingPain.on == true { addPainType("crushing") }
            if cuttingPain.on == true { addPainType("cutting") }
            if numbingpain.on == true { addPainType("numbing") }
            if tiringPain.on == true { addPainType("tiring") }
            if stretchingPain.on == true { addPainType("stretching/tugging") }
            if pressingPain.on == true { addPainType("pressing") }
            if stabbingPain.on == true { addPainType("stabbing") }
            if prickingPain.on == true { addPainType("pricking") }
            if burningPain.on == true { addPainType("burning") }
            if boringPain.on == true { addPainType("boring") }
            if splittingPain.on == true { addPainType("splitting") }
            if achingPain.on == true { addPainType("aching") }
            if shootingPain.on == true { addPainType("shooting") }
            if throbbingPain.on == true { addPainType("throbbing") }
            
            self.esas.painTypeString = ",\n  \"pain_types\": \(JSON(painTypes))\n}"
            painTypes.removeAll()
            self.performSegueWithIdentifier(PTEThree.toBodyDiagram, sender: self)
//        }
        
    }
    
    private func addPainType(pain: String){
        let painAdded = ["type": pain]
        painTypes.append(painAdded)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PTEThree.toBodyDiagram:
                let vc = destination as? PatientTakeESASFourViewController
                vc?.esas = esas
                vc?.language = language
            default: break
            }
        }
        
        
    }
    
}
