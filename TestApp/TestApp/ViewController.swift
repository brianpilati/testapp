//
//  ViewController.swift
//  TestApp
//
//  Created by Brian Pilati on 12/29/15.
//  Copyright © 2015 Brian Pilati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var progressCounter: Float = 0
    
    func randomCGFloat() -> CGFloat {
        return CGFloat(Float(arc4random()) /  Float(UInt32.max))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
 
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var clickMeButton: UIButton!

    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
    @IBAction func touchCancelButton(sender: AnyObject) {
        print("touch cancel")
        activityIndicator.stopAnimating()
    }
    
    @IBAction func touchDownButton(sender: AnyObject) {
        print("touchdown")
        print("sound", mySingleton.getFirstName(), mySingleton.getLastName())
        activityIndicator.startAnimating()
    }
    
    @IBAction func dragTheButton(sender: UIButton, event: UIEvent) {
        if (progressCounter < 101) {
            let touch : UITouch = event.touchesForView(sender)?.first as UITouch!
            let previousLocation : CGPoint = touch.previousLocationInView(sender)
            let location : CGPoint = touch.locationInView(sender)
            let delta_x :CGFloat = location.x - previousLocation.x
            let delta_y :CGFloat = location.y - previousLocation.y
            sender.center = CGPointMake(sender.center.x + delta_x, sender.center.y + delta_y)
        } else {
            activityIndicator.stopAnimating()
        }
        
        progressView.hidden = false
        progressView.setProgress(progressCounter/100, animated: true)
        progressCounter += 1
        if (progressCounter > 100) {
            clickMeButton.backgroundColor = UIColor.redColor()
            progressView.tintColor = UIColor.redColor()
        }
    }
    
    func randomPositionInt(isHeight: Bool) -> CGFloat {
        let my_height: UInt32 = arc4random_uniform(UInt32(screenSize.height))
        let my_width: UInt32 = arc4random_uniform(UInt32(screenSize.width))
        print("height: ", my_height.description, "width: ", my_width.description)
        
        return isHeight ? CGFloat (my_height + 1) : CGFloat(my_width + 1)
    }

    var loadStarWarsImage: Bool = true
    @IBOutlet weak var viewImage: UIImageView!
    
    @IBAction func editFirstName(sender: UITextField) {
        mySingleton.setFirstName(sender.text!)
    }
    
    @IBAction func editLastName(sender: UITextField) {
        mySingleton.setLastName(sender.text!)
    }
    
    func addImage() -> Void {
        if(loadStarWarsImage) {
            print("Loaded Once")
            viewImage.image = UIImage(named: "starwars.png");
            loadStarWarsImage = false
        }

        viewImage.frame = CGRect(x:randomPositionInt(false), y:randomPositionInt(true), width:viewImage.frame.height, height:viewImage.frame.height)
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        print("Button Clicked")
        ourLabel.text = "You clicked the button"
        ourLabel.textColor = UIColor(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1.0)
        addImage()
        progressCounter = 0
        progressView.setProgress(0, animated: false)
        clickMeButton.backgroundColor = UIColor.blueColor()
        progressView.tintColor = UIColor.blueColor()
    }
    
    @IBOutlet weak var ourLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.hidden = true
        progressView.setProgress(0, animated: false)
        clickMeButton.backgroundColor = UIColor.blueColor()
        progressView.tintColor = UIColor.blueColor()
        firstName.text = mySingleton.getFirstName()
        lastName.text = mySingleton.getLastName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

