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
    
    
    //-------------------------------------------------
    // MARK: - Content
    //-------------------------------------------------
    
    private func viewSetup() {
        view.backgroundColor = .white
    }
    
    private func markLabelSetup() {
        markLabel.text = "Mark"
        markLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(markLabel)
        NSLayoutConstraint.activate([
            markLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            markLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func modelLabelSetup() {
        modelLabel.text = "Model"
        modelLabel.font = UIFont.boldSystemFont(ofSize: 20)
        modelLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(modelLabel)
        NSLayoutConstraint.activate([
            modelLabel.topAnchor.constraint(equalTo: markLabel.bottomAnchor, constant: 30),
            modelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func carImageViewSetup() {
        
        carImageView.image = UIImage(named: "lambo")
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
        lastTimeStartedLabel.text = "Last time started:"
        lastTimeStartedLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lastTimeStartedLabel)
        NSLayoutConstraint.activate([
            lastTimeStartedLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 30),
            lastTimeStartedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20)
        ])
    }
    private func numberOfTripsLabelSetup() {
        numberOfTripsLabel.text = "Number of trips:"
        numberOfTripsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberOfTripsLabel)
        NSLayoutConstraint.activate([
            numberOfTripsLabel.topAnchor.constraint(equalTo: lastTimeStartedLabel.bottomAnchor, constant: 15),
            numberOfTripsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20)
        ])
    }
    private func ratingLabelSetup() {
        ratingLabel.text = "Raiting: X / 10.0"
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 30),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
        ])
    }
    
    private func segmentedControlSetup() {
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: numberOfTripsLabel.bottomAnchor, constant: 40),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func myChoiceImageViewSetup() {
        myChoiceImageView.backgroundColor = .blue
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
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            startButton.heightAnchor.constraint(equalToConstant: 30),
            startButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func rateButtonSetup() {
        rateButton.setTitle("Rate", for: .normal)
        rateButton.backgroundColor = .blue
        rateButton.layer.cornerRadius = 5
        
        rateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rateButton)
        NSLayoutConstraint.activate([
            rateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            rateButton.heightAnchor.constraint(equalToConstant: 30),
            rateButton.widthAnchor.constraint(equalToConstant: 120)
        ])
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
            
            let imageName = carDictionary["imageName"] as? String
            let image = UIImage(named: imageName!)
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

