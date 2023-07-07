//
//  ViewController.swift
//  AutoLayoutTest
//
//  Created by Dongduk1 on 2023/07/04.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
 
    
    var audioPlayer: AVAudioPlayer!
    var audioFile: URL!
    let MAX_VOLUME: Float = 10.0
    var progressTimer: Timer!
    
    
    
    var musicFileName : [String] = ["Lawrence - TrackTribe","I Had a Feeling - TrackTribe","High Noon - TrackTribe","Drop the Tapes - TrackTribe","Dream It - TrackTribe."]
    
    var selectMusic = "Lawrence - TrackTribe"
    
    @IBOutlet var musicPicekrView: UIPickerView!
    
    let timePlayerSelector:Selector = #selector(ViewController.updatePlayTime)
    let timeRecorderSelector:Selector = #selector(ViewController.updateRecordTime)
    
    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    
    @IBOutlet var slVolume: UISlider!
    
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    
    var audioRecorder : AVAudioRecorder!
    var isRecordMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        audioFile = Bundle.main.url(forResource: musicFileName[0], withExtension: "mp3")
       
        selectAudioFile(selectMusic)
        if !isRecordMode{
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        }else {
            initRecord()
        }
        
    }

    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    
    @objc func updatePlayTime() {
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(true, pause: false, stop: false)
        progressTimer.invalidate()
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        setPlayButtons(true, pause: false, stop: false)
    }
    
    func initPlay() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay() // 실제 메모리에 로딩됨
        audioPlayer.volume = slVolume.value
        
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        
        setPlayButtons(true, pause: false, stop: false)
        
        btnPlay.isEnabled = true
        btnPause.isEnabled = false
        btnStop.isEnabled = false
    }
    
    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    // 시간 정보 형식 바꿔서 출력
    func convertNSTimeInterval2String(_ time:TimeInterval) -> String {
        let min = Int(time/60) // 초로 넘겨주기 때문에 나머지 연산
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        
        return strTime
    }
    
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        }else{
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval2String(0)
        }
        selectAudioFile(selectMusic)
        if !isRecordMode{
            initPlay()
        }else{
            initRecord()
        }
    }
    @IBAction func btnRecord(_ sender: UIButton) {
        if (sender as AnyObject).titleLabel??.text == "Record"{
            audioRecorder.record() //만ㅇ긓러궁 오디오 레고크드 불러오기
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())//객체를 가지고 와서
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecorderSelector, userInfo: nil, repeats: true)
        }else{
            audioRecorder.stop()
            progressTimer.invalidate()
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()//재생준비하도록
        }
    }
    func selectAudioFile(_ forResource : String){
        if !isRecordMode{
            audioFile = Bundle.main.url(forResource: forResource, withExtension: "mp3")
        }else{
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            //폰 내부에 지정 된 디렉토리 정보를 루트 형ㅇ태로 가져오는 바업
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
            // 경로에다가 파이릉 ㄹ 추가한다는 으ㅣ미
            //절대경로로 저장하는 방법
        }
    }
    func initRecord(){
        let recordSettings = [
            AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey : 320000,
            //몇단계로 기록할지 단계
            AVNumberOfChannelsKey : 2,
            AVSampleRateKey : 44100.0] as [String : Any]
            //얼마나 측정할 것인지 시간을
            //레코드정보정의
        //아날로그를 디지털로 변동
        //진폭의 단계를 얼마나 나눌지 또 얼마나 기록할지
        do{
            //오디오 설정을 기반으로 오디오 만들기
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        }catch let error as NSError{
            print("Error - initRecord : \(error)")
        }
        audioRecorder.delegate = self
        
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(0)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance()
        do{
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord,mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
        }catch let error as NSError{
            print("Error - setCategory : \(error)")
        }
        do{
            try session.setActive(true)
        }catch let error as NSError{
            print("Error - setActive : \(error)")
        }
    }
        
    @objc func updateRecordTime(){
        lblRecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return musicFileName.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            selectMusic = musicFileName[row]
            print(selectMusic)
            //audioFile = Bundle.main.url(forResource: musicFileName[row], withExtension: "mp3")
            selectAudioFile(selectMusic)
            initPlay()
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return musicFileName[row]
    }
}

