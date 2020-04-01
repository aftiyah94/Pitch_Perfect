//
//  RecordSoundsViewController.swift
//  Pitch_Perfect
//
//  Created by Abdalfattah Altaeb on 4/1/20.
//  Copyright © 2020 Abdalfattah Altaeb. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func recordButtonAction(_ sender: Any) {
        configureUI(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as String
        let recordingName = "recordedAudio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try? audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecordButtonAction(_ sender: Any) {
        configureUI(isRecording: false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setActive(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureUI(isRecording: false)
    }
    
    // Configure the label and buttons
    func configureUI(isRecording: Bool) {
        if isRecording {
            recordingLabel.text = "Recording in Progress"
            recordButton.isEnabled = false
            stopRecordButton.isEnabled = true
        } else {
            recordingLabel.text = "Tap to Record"
            recordButton.isEnabled = true
            stopRecordButton.isEnabled = false
        }
    }
}

