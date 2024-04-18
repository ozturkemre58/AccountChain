//
//  ESpeechRecognizer.swift
//  AccountChain
//
//  Created by emre ozturk on 18.04.2024.
//

import Foundation
import Speech
import AVKit

typealias HSpeechRecognizerAuthCallback = (_ authorized: Bool) -> Void
typealias HSpeechRecognizerResultCallback = (_ text: String?) -> Void

class ESpeechRecognizer: NSObject, SFSpeechRecognizerDelegate {
  let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "tr-TR"))
  var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
  var recognitionTask: SFSpeechRecognitionTask?
  let audioEngine = AVAudioEngine()
  var timer = Timer()
  
  override init() {
    super.init()
  }
  
  func requestAuthorization(completion: @escaping HSpeechRecognizerAuthCallback) {
    self.speechRecognizer?.delegate = self
    
    SFSpeechRecognizer.requestAuthorization { (authStatus) in
      switch authStatus {
      case .authorized:
        completion(true)
      case .denied, .restricted, .notDetermined:
        completion(true)
      default:
        break
      }
    }
  }
  
  func isRunning() -> Bool {
    return self.audioEngine.isRunning
  }
  
  func stopSpeechToText() {
    if self.audioEngine.isRunning {
      self.audioEngine.stop()
      self.recognitionRequest?.endAudio()
      self.recognitionTask?.cancel()
      self.recognitionTask = nil
    }
  }
  
  func startSpeechToText(completion: @escaping HSpeechRecognizerResultCallback) {
    // Clear all previous session data and cancel task
    if self.recognitionTask != nil {
      self.recognitionTask?.cancel()
      self.recognitionTask = nil
    }
    
    // Create instance of audio session to record voice
    let audioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setCategory(AVAudioSession.Category.record,
                                   mode: AVAudioSession.Mode.measurement,
                                   options: AVAudioSession.CategoryOptions.defaultToSpeaker)
      try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    } catch {
        print("AVAudioSession error: \(error.localizedDescription)")
    }
    
    self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    
    let inputNode = audioEngine.inputNode
    
    guard let recognitionRequest = recognitionRequest else {
      return
    }
    
    recognitionRequest.shouldReportPartialResults = true
    
    self.recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
      var isFinal = false
      
        if result != nil {
            
            // Speaking any word will invalidate the timer.
            self.timer.invalidate()
            
            // To not speak for 2.5 seconds will be execution in the completion block.
            self.timer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { timer in
                completion(result?.bestTranscription.formattedString)
                isFinal = result!.isFinal
                timer.invalidate()
            }
        }
      
      if error != nil || isFinal {
        self.audioEngine.stop()
        inputNode.removeTap(onBus: 0)
        
        self.recognitionRequest = nil
        self.recognitionTask = nil
      }
    })
    
    let recordingFormat = inputNode.outputFormat(forBus: 0)
    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
      self.recognitionRequest?.append(buffer)
    }
    
    self.audioEngine.prepare()
    
    do {
      try self.audioEngine.start()
    } catch {
      print("audioEngine couldn't start because of an error.")
    }
  }
}

