//
//  ViewController.swift
//  callingApp
//
//  Created by AnilyTugce on 20.12.2022.
//

import UIKit
import AVFoundation
import AgoraRtcKit


class ViewController: UIViewController {
    var applyVoiceEffectBtn: UIButton!
    var voiceEffectIndex: UInt = 0
    // The main entry point for Video SDK
    var agoraEngine: AgoraRtcEngineKit!
    // By default, set the current user role to broadcaster to both send and receive streams.
    var userRole: AgoraClientRole = .broadcaster

    // Update with the App ID of your project generated on Agora Console.
    let appID = "ad9893f3b4bb4d919b074fc5cabbbed5"
    // Update with the temporary token generated in Agora Console.
    var token = "007eJxTYLhwh/eU6knfezPjEsw23ahPmNugOS0szvDH2e1v9bgZ2BYpMCSmWFpYGqcZJ5kkJZmkWBpaJhmYm6QlmyYnJiUlpaaYLj+3KLkhkJFBcOkKBkYoBPH5GUpSi0vc8osci0oyk0tzEhkYACEzJTw="
    // Update with the channel name you used to generate the token in Agora Console.
    var channelName = "testForArticula"

    // Click to join or leave a call
    var joinButton: UIButton!
    // Track if the local user is in a call
    var joined: Bool = false
    var appTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Initializes the video view
        initViews()
        // The following functions are used when calling Agora APIs
        initializeAgoraEngine()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        leaveChannel()
        DispatchQueue.global(qos: .userInitiated).async {AgoraRtcEngineKit.destroy()}
    }


    func joinChannel() {
        if !self.checkForPermissions() {
            showMessage(title: "Error", text: "Permissions were not granted")
            return
        }

        let option = AgoraRtcChannelMediaOptions()

        // Set the client role option as broadcaster or audience.
        if self.userRole == .broadcaster {
            option.clientRoleType = .broadcaster
        } else {
            option.clientRoleType = .audience
        }

        // For an audio call scenario, set the channel profile as communication.
        option.channelProfile = .communication

        // Join the channel with a temp token and channel name
        
        let result = agoraEngine.joinChannel(
            byToken: token, channelId: channelName, uid: 0, mediaOptions: option,
            joinSuccess: { (channel, uid, elapsed) in }
        )

        // Check if joining the channel was successful and set joined Bool accordingly
        if (result == 0) {
            joined = true
            showMessage(title: "Success", text: "Successfully joined the channel as \(self.userRole)")
        }
    }

    func leaveChannel() {
        let result = agoraEngine.leaveChannel(nil)
        // Check if leaving the channel was successful and set joined Bool accordingly
        if (result == 0) { joined = false }
    }

    func initializeAgoraEngine() {
        let config = AgoraRtcEngineConfig()
        // Pass in your App ID here.
        config.appId = appID
        // Use AgoraRtcEngineDelegate for the following delegate parameter.
        agoraEngine = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
    }


    func initViews() {
        
        appTitle = UILabel()
        appTitle.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - 75, y: UIScreen.main.bounds.size.height * 0.12 - 38, width: 150, height: 76)
        appTitle.textColor = .black
        appTitle.text = "ARTICULA TASK 1"
        self.view.addSubview(appTitle)
        
        
        joinButton = UIButton(type: .system)
        joinButton.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - 75, y: UIScreen.main.bounds.size.height / 2 - 38, width: 150, height: 76)
        joinButton.setTitle("Join", for: .normal)
        joinButton.setTitleColor(.black, for: .normal)

        joinButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(joinButton)
        
        applyVoiceEffectBtn = UIButton(type: .system)
        applyVoiceEffectBtn.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - 75, y: UIScreen.main.bounds.size.height * 0.75 - 38, width: 150, height: 76)
        applyVoiceEffectBtn.setTitle("Apply voice effect", for: .normal)
        applyVoiceEffectBtn.setTitleColor(.black, for: .normal)
        
        applyVoiceEffectBtn.addTarget(self, action: #selector(applyVoiceEffectBtnClicked), for: .touchUpInside)
        
        self.view.backgroundColor = .white
        self.view.addSubview(applyVoiceEffectBtn)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        if !joined {
                joinChannel()
            if (joined) { joinButton.setTitle("Leave", for: .normal) }
        } else {
            leaveChannel()
            // Check if successfully left the channel and set button title accordingly
            if (!joined) { joinButton.setTitle("Join", for: .normal) }
        }
    }
    
    @objc func applyVoiceEffectBtnClicked() {
        voiceEffectIndex += 1
        // Turn off any previous effects
        agoraEngine.setVoiceBeautifierPreset(AgoraVoiceBeautifierPreset.presetOff)
        agoraEngine.setAudioEffectPreset(AgoraAudioEffectPreset.off)
        agoraEngine.setVoiceConversionPreset(AgoraVoiceConversionPreset.off)
    
        if (voiceEffectIndex == 1) {
            agoraEngine.setVoiceBeautifierPreset(AgoraVoiceBeautifierPreset.presetChatBeautifierMagnetic)
            applyVoiceEffectBtn.setTitle("Voice effect: Chat Beautifier", for: .normal)
        } else if (voiceEffectIndex == 2) {
            agoraEngine.setVoiceBeautifierPreset(AgoraVoiceBeautifierPreset.presetSingingBeautifier)
            applyVoiceEffectBtn.setTitle("Voice effect: Singing Beautifier", for: .normal)
        } else if (voiceEffectIndex == 3) {
            agoraEngine.setAudioEffectPreset(AgoraAudioEffectPreset.voiceChangerEffectHulk)
            applyVoiceEffectBtn.setTitle("Audio effect: Hulk", for: .normal)
        }else if (voiceEffectIndex == 4) {
            agoraEngine.setAudioEffectPreset(AgoraAudioEffectPreset.voiceChangerEffectGirl)
            applyVoiceEffectBtn.setTitle("Audio effect: Girl Effect", for: .normal)
        } else if (voiceEffectIndex == 5) {
            agoraEngine.setVoiceConversionPreset(AgoraVoiceConversionPreset.changerBass)
            applyVoiceEffectBtn.setTitle("Audio effect: Voice Changer", for: .normal)
        } else if (voiceEffectIndex == 6) {
            // Sets the local voice equalization.
            // The first parameter sets the band frequency. The value ranges between 0 and 9.
            // Each value represents the center frequency of the band:
            // 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz.
            // The second parameter sets the gain of each band between -15 and 15 dB.
            // The default value is 0.
            agoraEngine.setLocalVoiceEqualizationOf(AgoraAudioEqualizationBandFrequency.band500, withGain: 3)
            agoraEngine.setLocalVoicePitch(0.5)
            applyVoiceEffectBtn.setTitle("Audio effect: Voice Equalization", for: .normal)
        } else if (voiceEffectIndex > 6) { // Remove all effects
            voiceEffectIndex = 0
            agoraEngine.setLocalVoicePitch(1.0)
            agoraEngine.setLocalVoiceEqualizationOf(AgoraAudioEqualizationBandFrequency.band500, withGain: 0)
            applyVoiceEffectBtn.setTitle("Apply voice effect", for: .normal)
        }
    }


    func checkForPermissions() -> Bool {
        var hasPermissions = false

        switch AVCaptureDevice.authorizationStatus(for: .audio) {
            case .authorized: hasPermissions = true
            default: hasPermissions = requestAudioAccess()
        }
        return hasPermissions
    }

    func requestAudioAccess() -> Bool {
        var hasAudioPermission = false
        let semaphore = DispatchSemaphore(value: 0)
        AVCaptureDevice.requestAccess(for: .audio, completionHandler: { granted in
            hasAudioPermission = granted
            semaphore.signal()
        })
        semaphore.wait()
        return hasAudioPermission
    }

    func showMessage(title: String, text: String, delay: Int = 2) -> Void {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
    



}
extension ViewController: AgoraRtcEngineDelegate {
    // Callback called when a new host joins the channel
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {

    }
}


