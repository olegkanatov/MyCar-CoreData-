//
//  ViewController.swift
//  MyCar
//
//  Created by Oleg Kanatov on 13.09.21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var context: NSManagedObjectContext!
    var car: Car!
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .none
        return df
    }()
    
    private var segmentedControl = UISegmentedControl(items: ["Lamborgini", "Ferrari", "Mercedes", "Nissan", "BMW"])
    
    private var markLabel = UILabel()
    private var modelLabel = UILabel()
    private var carImageView = UIImageView()
    private var lastTimeStartedLabel = UILabel()
    private var numberOfTripsLabel = UILabel()
    private var ratingLabel = UILabel()
    private var myChoiceImageView = UIImageView()
    private var startButton = UIButton()
    private var rateButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromFile()
        
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        let mark = segmentedControl.titleForSegment(at: 0)
        fetchRequest.predicate = NSPredicate(format: "mark == %@", mark!)

        do {
            let results = try context.fetch(fetchRequest)
            car = results[0]
            insertDataFrom(selectedCar: car)
        } catch {
            print(error.localizedDescription)
        }
        
        viewSetup()
        markLabelSetup()
        modelLabelSetup()
        carImageViewSetup()
        lastTimeStartedLabelSetup()
        numberOfTripsLabelSetup()
        ratingLabelSetup()
        segmentedControlSetup()
        myChoiceImageViewSetup()
        startButtonSetup()
        rateButtonSetup()
        
        
    }
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
    
    
    //-------------------------------------------------
    // MARK: - Content
    //-------------------------------------------------
    
    private func viewSetup() {
        view.backgroundColor = .white
    }
    
    private func markLabelSetup() {
        markLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(markLabel)
        NSLayoutConstraint.activate([
            markLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            markLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func modelLabelSetup() {
        modelLabel.font = UIFont.boldSystemFont(ofSize: 20)
        modelLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(modelLabel)
        NSLayoutConstraint.activate([
            modelLabel.topAnchor.constraint(equalTo: markLabel.bottomAnchor, constant: 30),
            modelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func carImageViewSetup() {
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(carImageView)
        NSLayoutConstraint.activate([
            carImageView.topAnchor.constraint(equalTo: modelLabel.bottomAnchor, constant: 30),
            carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carImageView.heightAnchor.constraint(equalToConstant: 200),
            carImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func lastTimeStartedLabelSetup() {
        lastTimeStartedLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lastTimeStartedLabel)
        NSLayoutConstraint.activate([
            lastTimeStartedLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 30),
            lastTimeStartedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20)
        ])
    }
    private func numberOfTripsLabelSetup() {
        numberOfTripsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberOfTripsLabel)
        NSLayoutConstraint.activate([
            numberOfTripsLabel.topAnchor.constraint(equalTo: lastTimeStartedLabel.bottomAnchor, constant: 15),
            numberOfTripsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20)
        ])
    }
    private func ratingLabelSetup() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 30),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
        ])
    }
    
    private func segmentedControlSetup() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changeSelected), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: numberOfTripsLabel.bottomAnchor, constant: 40),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func changeSelected (_ sender: UISegmentedControl) {
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        let mark = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        fetchRequest.predicate = NSPredicate(format: "mark == %@", mark!)
        
        do {
            let results = try context.fetch(fetchRequest)
            car = results[0]
            insertDataFrom(selectedCar: car)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func myChoiceImageViewSetup() {
        myChoiceImageView.image = UIImage(named: "myChoice")
        myChoiceImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myChoiceImageView)
        NSLayoutConstraint.activate([
            myChoiceImageView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30),
            myChoiceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myChoiceImageView.heightAnchor.constraint(equalToConstant: 100),
            myChoiceImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myChoiceImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func startButtonSetup() {
        startButton.setTitle("Start Engine", for: .normal)
        startButton.backgroundColor = .blue
        startButton.layer.cornerRadius = 5
        startButton.addTarget(self, action: #selector(startEnginePressed), for: .touchUpInside)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            startButton.heightAnchor.constraint(equalToConstant: 30),
            startButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc func startEnginePressed (_ sender: UIButton) {
        car.timesDriven += 1
        car.lastStarted = Date()
        
        do {
            try context.save()
            insertDataFrom(selectedCar: car)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func rateButtonSetup() {
        rateButton.setTitle("Rate", for: .normal)
        rateButton.backgroundColor = .blue
        rateButton.layer.cornerRadius = 5
        rateButton.addTarget(self, action: #selector(rateItPressed), for: .touchUpInside)
        
        rateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rateButton)
        NSLayoutConstraint.activate([
            rateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            rateButton.heightAnchor.constraint(equalToConstant: 30),
            rateButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc func rateItPressed (_ sender: UIButton) {
        let alertController = UIAlertController(title: "Rate it", message: "Rate this car please", preferredStyle: .alert)
        let rateAction = UIAlertAction(title: "Rate", style: .default) { action in
            if let text = alertController.textFields?.first?.text {
                self.update(rating: (text as NSString).doubleValue)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(rateAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func update(rating: Double) {
        car.rating = rating
        
        do {
            try context.save()
            insertDataFrom(selectedCar: car)
        } catch let error as NSError {
            let alertController = UIAlertController(title: "Wrong value", message: "Wrong input", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            print(error.localizedDescription)
        }
    }
    
    //-------------------------------------------------
    // MARK: - CoreData
    //-------------------------------------------------
    
    private func insertDataFrom (selectedCar car: Car) {
        carImageView.image = UIImage(data: car.imageData!)
        markLabel.text = car.mark
        modelLabel.text = car.model
        myChoiceImageView.isHidden = !(car.myChoice)
        ratingLabel.text = "Rating: \(car.rating) / 10"
        numberOfTripsLabel.text = "Number of trips: \(car.timesDriven)"
        
        lastTimeStartedLabel.text = "Last time started: \(dateFormatter.string(from: car.lastStarted!))"
        segmentedControl.backgroundColor = car.tintColor as? UIColor
    }
    
    private func getDataFromFile() {
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mark != nil")
        
        var records = 0
        
        do{
            records = try context.count(for: fetchRequest)
            print("Is Data there already?")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        guard records == 0 else { return }
        
        
        
        guard let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist"), let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
        
        for dictionary in dataArray {
            let entity = NSEntityDescription.entity(forEntityName: "Car", in: context)
            let car = NSManagedObject(entity: entity!, insertInto: context) as! Car
            
            let carDictionary = dictionary as! [String : AnyObject]
            car.mark = carDictionary["mark"] as? String
            car.model = carDictionary["model"] as? String
            car.rating = carDictionary["rating"] as! Double
            car.lastStarted = carDictionary["lastStarted"] as? Date
            car.timesDriven = carDictionary["timesDriven"] as! Int16
            car.myChoice = carDictionary["myChoice"] as! Bool
            
            guard let imageName = carDictionary["imageName"] as? String else { return }
            let image = UIImage(named: imageName)
            let imageData = image!.pngData()
            car.imageData = imageData
            
            if let colorDictionary = carDictionary["tintColor"] as? [String : Float] {
                car.tintColor = getColor(colorDictionary: colorDictionary)
            }
            
        }
    }
    
    private func getColor(colorDictionary: [String : Float]) -> UIColor {
        guard let red = colorDictionary["red"],
              let green = colorDictionary["green"],
              let blue = colorDictionary["blue"] else { return UIColor() }
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: 1.0)
    }
    
}

