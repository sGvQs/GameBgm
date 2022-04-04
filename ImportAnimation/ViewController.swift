//
//  ViewController.swift
//  ImportAnimation
//
//  Created by Susumu Goto on 2022/04/02.
//

import UIKit
import Lottie
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer:AVAudioPlayer!
    var animationView: AnimationView = AnimationView()
    
    @IBAction func sun(_ sender: Any) {
        
        audioPlayer.currentTime = TimeInterval(sunSlider.value)
        self.timeCount()
        
    }
    
    @IBOutlet weak var sunSlider: UISlider!
    @IBOutlet weak var animationUI: UIView!
    @IBOutlet weak var playB: UIButton!
    
    func walking() {
        
        animationView.animation = Animation.named("playingGame")
        animationView.frame = CGRect(x: -10, y: 0, width: animationUI.frame.size.width, height: animationUI.frame.size.height)
            animationView.contentMode = .scaleToFill

            animationUI.addSubview(animationView)
            animationView.backgroundBehavior = .pauseAndRestore

            animationView.play()
            animationView.loopMode = .loop
        
    }
    
    func music() {
        
        // 再生する audio ファイルのパスを取得
        let audioPath = Bundle.main.path(forResource: "nscGame", ofType:"mp3")!
        let audioUrl = URL(fileURLWithPath: audioPath)
        
        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
            sunSlider.maximumValue = Float(audioPlayer.duration)
            
        } catch let error as NSError {
            audioError = error
            audioPlayer = nil
            
        }
        
        // エラーが起きたとき
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        
        audioPlayer.numberOfLoops = -1
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
  
    
    @objc func timeCount() {
        sunSlider.value = Float(Double(audioPlayer.currentTime))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeCount), userInfo: nil, repeats: true)

        //アニメーション
        walking()
    
        //音楽
        music()
        
    }
    
    @IBAction func StartButton(_ sender: UIButton) {
        
        audioPlayer.numberOfLoops = -1
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    
    
}

