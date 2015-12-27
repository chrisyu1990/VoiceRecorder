//
//  PlaySoundsViewController.swift
//  VoiceRecorder
//
//  Created by Chris Yu on 2015/12/27.
//  Copyright (c) 2015年 Chris Yu. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var filePathUrl = receivedAudio.filePathUrl//NSURL.fileURLWithPath(filePath)
        audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl,  error: nil)
        audioPlayer.enableRate = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func stop(sender: UIButton) {
        audioPlayer.stop()
    }
    
    @IBAction func playFastMusik(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.play()
    }
    
    @IBAction func playSlowMusik(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
    
    @IBAction func playLowPitch(sender: UIButton) {
        playAudioWithVariablePith(-1000)
    }
    
    @IBAction func playHighPitch(sender: UIButton) {
        playAudioWithVariablePith(1000)
    }
    
    func playAudioWithVariablePith(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        audioEngine.attachNode(audioPlayerNode)
        
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }

}
