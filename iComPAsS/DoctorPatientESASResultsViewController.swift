//
//  DoctorPatientESASResultsViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 25/01/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit
import Charts

class DoctorPatientESASResultsViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate, ChartViewDelegate {
    private struct PatientEsasResult {
        static let showEsasResult = "showEsasResult"
        
    }
    var selectedPatient = 0
    @IBOutlet var tableView: UITableView!
    let symptomPicker = UIPickerView()
    var selectedSymptom = "Pain"
    let symptoms = ["Pain", "Tiredness", "Depression","Anxiety","Drowsiness","Shortness of Breath", "Appetite","Well-Being", "Nausea"]
//    let dates = ["01", "02","03", "04", "05","06","07","08","09","10"]
//    let samplePain = [5,4,5,4,5,4,5,4,5,4]
//    let sampleTiredness = [7,8,7,8,7,8,7,8,7,8]
//    let sampleDepression = [5,4,5,4,5,4,5,4,5,4]
//    let sampleAnxiety = [7,8,7,8,7,8,7,8,7,8]
//    let sampleDrowsiness = [5,4,5,4,5,4,5,4,5,4]
//    let sampleShortnessOfBreath = [7,8,7,8,7,8,7,8,7,8]
//    let sampleAppetite = [5,4,5,4,5,4,5,4,5,4]
//    let sampleWellBeing = [7,8,7,8,7,8,7,8,7,8]
//    let sampleNausea = [5,4,5,4,5,4,5,4,5,4]
//    let sampleOthers = [0,0,0,0,0,0,0,0,0,0]
    
    var patient = Patient()
    var selectedDate = ""
    var pain = 0
    var tiredness = 0
    var nausea = 0
    var depression = 0
    var anxiety = 0
    var drowsiness = 0
    var appetite = 0
    var wellBeing = 0
    var shortnessOfBreath = 0
    var others = ""
    var painTypes = ""
    var selectedEsasID = 0
    var reversedDateTime: [String] = []
    var reversedPain: [Int] = []
    var reversedTiredness: [Int] = []
    var reversedDepression: [Int] = []
    var reversedAnxiety: [Int] = []
    var reversedDrowsiness: [Int] = []
    var reversedShortnessOfBreth: [Int] = []
    var reversedLackOfAppetite: [Int] = []
    var reversedWellBeing: [Int] = []
    var reversedNausea: [Int] = []
    var reversedAllEsasId: [Int] = []
    var reversedOtherSymptoms: [String] = []
    var reversedPainTypes: [String] = []

    @IBOutlet var chooseSymptom: UITextField!
    @IBOutlet var lineChartView: LineChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.symptomPicker.delegate = self
        self.symptomPicker.dataSource = self
        self.symptomPicker.showsSelectionIndicator = true
        self.chooseSymptom.enabled = true
        self.chooseSymptom.inputView = self.symptomPicker
        self.tableView.userInteractionEnabled = true
        self.tableView.flashScrollIndicators()
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        patient.getAllEsasResult(selectedPatient, token: token, completion: {(success) -> Void in
            self.setChart(self.patient.patientDateAnswered, Values: self.patient.patientPain)
            self.setChartDesign()
            self.setXAxisDesign()
            self.setYAxisDesign()
            self.reversedDateTime = self.patient.patientDateTimeAnsweredEsas.reverse()
            self.reversedPain = self.patient.patientPain.reverse()
            self.reversedTiredness = self.patient.patientTiredness.reverse()
            self.reversedDepression = self.patient.patientDepression.reverse()
            self.reversedAnxiety = self.patient.patientAnxiety.reverse()
            self.reversedDrowsiness = self.patient.patientDrowsiness.reverse()
            self.reversedShortnessOfBreth = self.patient.patientShortnessOfBreath.reverse()
            self.reversedLackOfAppetite = self.patient.patientLackOfAppetite.reverse()
            self.reversedWellBeing = self.patient.patientWellBeing.reverse()
            self.reversedNausea = self.patient.patientNausea.reverse()
            self.reversedAllEsasId = self.patient.patientAllEsasId.reverse()
            self.reversedOtherSymptoms = self.patient.patientOtherSymptoms.reverse()
            self.reversedPainTypes = self.patient.patientPainTypes.reverse()
            self.tableView.reloadData()
        })

        
    }
    
    func setXAxisDesign(){
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .Bottom
        xAxis.drawGridLinesEnabled = false
    }
    
    func setYAxisDesign(){
        let leftYAxis = lineChartView.getAxis(ChartYAxis.AxisDependency.Left)
        leftYAxis.drawLabelsEnabled = true
        leftYAxis.drawGridLinesEnabled = false
        leftYAxis.enabled = true
        
        let rightYAxis = lineChartView.getAxis(ChartYAxis.AxisDependency.Right)
        rightYAxis.drawGridLinesEnabled = false
        rightYAxis.enabled = false
        
        
    }
    
    func setChartDesign(){
        
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.animate(xAxisDuration: 1.0, easingOption: .EaseInOutCubic)
        lineChartView.descriptionText = ""
        lineChartView.noDataText = "There are no esas results yet"
        
    }
    func setChart(dataPoints: [String], Values: [Int]){
        lineChartView.delegate = self
        var dataEntries: [ChartDataEntry] = []
        var dataDays: [String] = []
        var count = 0
        for i in 0..<patient.patientDateAnswered.count{
            let DataEntry = ChartDataEntry(value: Double(Values[i]),xIndex:i)
            dataEntries.append(DataEntry)
            dataDays.append(patient.patientDateAnswered[count])
            if(count == dataPoints.count - 1){
                count = 0
            }else{
                count = count + 1
            }
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: nil)
        switch selectedSymptom{
        case "Pain":
            lineChartDataSet.colors = [UIColor.redColor()]
            lineChartDataSet.circleColors = [UIColor.redColor()]
        case "Tiredness":
            lineChartDataSet.colors = [UIColor.orangeColor()]
            lineChartDataSet.circleColors = [UIColor.orangeColor()]
        case "Depression":
            lineChartDataSet.colors = [UIColor.blueColor()]
            lineChartDataSet.circleColors = [UIColor.blueColor()]
        case "Anxiety":
            lineChartDataSet.colors = [UIColor.greenColor()]
            lineChartDataSet.circleColors = [UIColor.greenColor()]
        case "Drowsiness":
            lineChartDataSet.colors = [UIColor.purpleColor()]
            lineChartDataSet.circleColors = [UIColor.purpleColor()]
        case "Shortness of Breath":
            lineChartDataSet.colors = [UIColor.yellowColor()]
            lineChartDataSet.circleColors = [UIColor.yellowColor()]
        case "Appetite":
            lineChartDataSet.colors = [UIColor.cyanColor()]
            lineChartDataSet.circleColors = [UIColor.cyanColor()]
        case "Well-Being":
            lineChartDataSet.colors = [UIColor.grayColor()]
            lineChartDataSet.circleColors = [UIColor.grayColor()]
        case "Nausea":
            lineChartDataSet.colors = [UIColor.magentaColor()]
            lineChartDataSet.circleColors = [UIColor.magentaColor()]
//        case "Others":
//            lineChartDataSet.colors = [UIColor.brownColor()]
//            lineChartDataSet.circleColors = [UIColor.brownColor()]
        default:break
        }

        let lineChartData = LineChartData(xVals: dataDays, dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        let legend = lineChartView.legend
        legend.enabled = false
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return symptoms.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chooseSymptom.text = symptoms[row]
        selectedSymptom = symptoms[row]
        switch row{
        case 0:
            setChart(patient.patientDateAnswered, Values: patient.patientPain)
        case 1:
            setChart(patient.patientDateAnswered, Values: patient.patientTiredness)
        case 2:
            setChart(patient.patientDateAnswered, Values: patient.patientDepression)
        case 3:
            setChart(patient.patientDateAnswered, Values: patient.patientAnxiety)
        case 4:
            setChart(patient.patientDateAnswered, Values: patient.patientDrowsiness)
        case 5:
            setChart(patient.patientDateAnswered, Values: patient.patientShortnessOfBreath)
        case 6:
            setChart(patient.patientDateAnswered, Values: patient.patientLackOfAppetite)
        case 7:
            setChart(patient.patientDateAnswered, Values: patient.patientWellBeing)
        case 8:
            setChart(patient.patientDateAnswered, Values: patient.patientNausea)
//        case 9:
//            setChart(patient.patientDateAnsweredEsas, Values: patient.patientOtherValue)
        default:break
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return symptoms[row]
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if patient.patientDateTimeAnsweredEsas.count == 0{
            return 1
        }else{
            return patient.patientDateTimeAnsweredEsas.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.patient.patientDateTimeAnsweredEsas.count == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("noESASResults", forIndexPath: indexPath)
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("esasDate", forIndexPath: indexPath)
            var date = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila")
            if let selectedDateNS = dateFormatter.dateFromString(reversedDateTime[indexPath.row]) {
                date = selectedDateNS
            }
            let dateFormatterTwo = NSDateFormatter()
            dateFormatterTwo.dateFormat = "MMM d, yyyy' at 'h:mm a"
            cell.textLabel?.text = dateFormatterTwo.stringFromDate(date)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.userInteractionEnabled = false
        if self.patient.patientDateTimeAnsweredEsas.count > 0 {
            selectedDate = reversedDateTime[indexPath.row]
            pain = reversedPain[indexPath.row]
            tiredness = reversedTiredness[indexPath.row]
            nausea = reversedNausea[indexPath.row]
            depression = reversedDepression[indexPath.row]
            anxiety = reversedAnxiety[indexPath.row]
            drowsiness = reversedDrowsiness[indexPath.row]
            appetite = reversedLackOfAppetite[indexPath.row]
            wellBeing = reversedWellBeing[indexPath.row]
            shortnessOfBreath = reversedShortnessOfBreth[indexPath.row]
            others = reversedOtherSymptoms[indexPath.row]
            selectedEsasID = reversedAllEsasId[indexPath.row]
            painTypes = reversedPainTypes[indexPath.row]
            performSegueWithIdentifier(PatientEsasResult.showEsasResult, sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PatientEsasResult.showEsasResult:
                let vc = destination as? DoctorPatientDateEsasResultViewController
                vc?.selectedDate = selectedDate
                vc?.pain = pain
                vc?.tiredness = tiredness
                vc?.nausea = nausea
                vc?.depression = depression
                vc?.anxiety = anxiety
                vc?.drowsiness = drowsiness
                vc?.appetite = appetite
                vc?.wellBeing = wellBeing
                vc?.shortnessOfBreath = shortnessOfBreath
                vc?.others = others
                vc?.esasID = selectedEsasID
                vc?.painTypes = painTypes
            default: break
            }
        }
    }
    

}
