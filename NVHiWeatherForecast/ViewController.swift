//
//  ViewController.swift
//  NVHiWeatherForecast
//
//  Created by Hùng Nguyễn  on 7/22/16.
//  Copyright © 2016 MobileSoftware. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var effectQuote: UIVisualEffectView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempUnit: UILabel!
    
    var tempCelsious = Double()
    var tempFahrenheit = Double()
    var tapping = false
    
    var audioPlayer = AVAudioPlayer()
    
    var background = ["hanoi.jpg","hochiminh.jpg","danang.jpg","Hue.jpg","London.jpg","NewYork.jpeg","tokyo.jpg","Beijing.jpg"]
    
    var cities  = ["Ha Noi",
                   "Ho Chi Minh",
                   "Da Nang",
                   "Hue",
                   "London",
                   "New York",
                   "Tokyo",
                   "Beijing"]
    
    var quotes  = ["I'm convinced that about half of what separates successful entrepreneurs from the non-successful ones is pure perseverance.",
        "My favorite things in life don't cost any money. It's really clear that the most precious resource we all have is time.",
        "If you are willing to do more than you are paid to do, eventually you will be paid to do more than you do.",
        "Opportunities don't happen. You create them.",
        "I think if you do something and it turns out pretty good, then you should go do something else wonderful, not dwell on it for too long. Just figure out what’s next.",
        "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations.",
        "Innovation distinguishes between a leader and a follower.",
        "Stop chasing the money and start chasing the passion."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempLabel.userInteractionEnabled = true
        
        // tap gestureRecognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
        tap.numberOfTapsRequired = 1
        tempLabel.addGestureRecognizer(tap)
        
        // sound
        let filePath = NSBundle.mainBundle().pathForResource("338677__natemarler__birds-morning", ofType: ".wav")
        let url = NSURL(fileURLWithPath: filePath!)
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: url)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
        // effect
        effectQuote.layer.cornerRadius = 8
        effectQuote.clipsToBounds = true
    }

    
    @IBAction func randomButton(sender: UIButton) {
    
        let cityIndex = Int(arc4random_uniform(UInt32(cities.count)))
        cityLabel.text = cities[cityIndex]

        let quoteIndex = Int(arc4random_uniform(UInt32(quotes.count)))
        quoteLabel.text = quotes[quoteIndex]
        
            switch cityLabel.text! {
            case "Ha Noi":
                cityLabel.text = "Ha Noi"
                backgroundImage.image = UIImage(named: "hanoi.jpg")
            case "Ho Chi Minh":
                cityLabel.text = "Ho Chi Minh"
                backgroundImage.image = UIImage(named: "hochiminh.jpg")
            case "Da Nang":
                cityLabel.text = "Da Nang"
                backgroundImage.image = UIImage(named: "danang.jpg")
            case "Hue":
                cityLabel.text = "Hue"
                backgroundImage.image = UIImage(named: "Hue.jpg")
            case "London":
                cityLabel.text = "London"
                backgroundImage.image = UIImage(named: "London.jpg")
            case "New York":
                cityLabel.text = "New York"
                backgroundImage.image = UIImage(named: "NewYork.jpeg")
            case "Tokyo":
                cityLabel.text = "Tokyo"
                backgroundImage.image = UIImage(named: "tokyo.jpg")
            case "Beijing":
                cityLabel.text = "Beijing"
                backgroundImage.image = UIImage(named: "Beijing.jpg")

            default:
                break
            }
        
        
        getTemp()
        playSound()
        
        
    }
    
    func tapLabel() -> Void {
            if !tapping {
            switch tempUnit.text! {
            case "C":
                tempCelsious = Double(tempLabel.text!)!
                tempFahrenheit = (tempCelsious * 1.8) + 32
                tempLabel.text = String(format: "%2.1f", tempFahrenheit)
                tempUnit.text = "F"
            case "F":
                tempFahrenheit = Double(tempLabel.text!)!
                tempCelsious = (tempFahrenheit - 32) / 1.8
                tempLabel.text = String(format: "%2.1f", tempCelsious)
                tempUnit.text = "C"
            default:
                break
            }
          
        }
    }
    
    
    func getTemp() -> Void {
        if tempUnit.text! == "C" {
            let randomNumber = String(format: "%2.1f", tempRandom())
            tempLabel.text = randomNumber
        } else if tempUnit.text! == "F" {
            let randomNumber = String(format: "%2.1f", (tempRandom() * 1.8) + 32)
            tempLabel.text = randomNumber
        }
        
    }
    
    func tempRandom() -> Double {
        return Double(arc4random_uniform(20) + 11) + Double(arc4random()) / Double(INT32_MAX)
    }
    
    func playSound() -> Void {
        if backgroundImage.image == UIImage(named: "hanoi.jpg") || backgroundImage.image == UIImage(named: "tokyo.jpg") {
            let filePath = NSBundle.mainBundle().pathForResource("338677__natemarler__birds-morning", ofType: ".wav")
            let url = NSURL(fileURLWithPath: filePath!)
            
            audioPlayer = try! AVAudioPlayer(contentsOfURL: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()

        } else if backgroundImage.image == UIImage(named: "hochiminh.jpg") || backgroundImage.image == UIImage(named: "Beijing.jpg")
        {
            let filePath = NSBundle.mainBundle().pathForResource("256784__radwoc__atmosphere-evening-birds", ofType: ".wav")
            let url = NSURL(fileURLWithPath: filePath!)
            
            audioPlayer = try! AVAudioPlayer(contentsOfURL: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()

        } else if backgroundImage.image == UIImage(named: "danang.jpg") || backgroundImage.image == UIImage(named: "NewYork.jpeg")
        {
            let filePath = NSBundle.mainBundle().pathForResource("52588__eric5335__crickets", ofType: ".wav")
            let url = NSURL(fileURLWithPath: filePath!)
            
            audioPlayer = try! AVAudioPlayer(contentsOfURL: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } else if backgroundImage.image == UIImage(named: "Hue.jpg") || backgroundImage.image == UIImage(named: "London.jpg")
        {
            let filePath = NSBundle.mainBundle().pathForResource("338677__natemarler__birds-morning", ofType: ".wav")
            let url = NSURL(fileURLWithPath: filePath!)
            
            audioPlayer = try! AVAudioPlayer(contentsOfURL: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        
    }
 
}

