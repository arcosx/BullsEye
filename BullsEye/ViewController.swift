//
//  ViewController.swift
//  BullsEye
//
//  Created by 王国彬 on 02/12/2017.
//  Copyright © 2017 wgb. All rights reserved.
//

import UIKit
import QuartzCore
class ViewController: UIViewController {
    
    @IBOutlet weak var slider:UISlider!
    var currentValue =  50
    var targetValue = 0
    var score = 0
    var round = 0
    @IBOutlet weak var targetLable:UILabel!
    @IBOutlet weak var scoreLable:UILabel!
    @IBOutlet weak var roundLable:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showAlert(){
        let diffentValue = abs(targetValue - currentValue)
        var point = 100 - diffentValue
        let title : String
        if diffentValue == 0{
            title = "运气逆天！赶紧去买注彩票吧！"
            point += 100
        }else if diffentValue < 5{
            title = "太棒了！差一点就到了!"
            if(diffentValue == 1){
                point += 50
            }
        }else if diffentValue < 10{
            title = "很不错！继续努力！"
        }else{
            title = "差的太远了！"
        }
        score += point
        let message = "The Slider Number is : \(currentValue)"+"\n目标数值是: \(targetValue)"+"\n两者的差值:\(diffentValue)"
        let alert = UIAlertController(title:title,message:message,preferredStyle:.alert)
        let action = UIAlertAction(title:"OK",style:.default,handler:{action in self.startNewRound()})
        alert.addAction(action)
        present(alert,animated:true,completion:nil)
        startNewRound()
        
    }
    @IBAction func sliderMoved(slider:UISlider){
        currentValue = lroundf(slider.value)
    }
    func startNewRound(){
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLables()
    }
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
        // add crossfade effects
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.add(transition, forKey: nil)
    }
    @IBAction func startOver(){
        startNewGame()
    }
    func updateLables(){
        targetLable.text = String(targetValue)
        scoreLable.text = String(score)
        roundLable.text = String(round)
    }
}

