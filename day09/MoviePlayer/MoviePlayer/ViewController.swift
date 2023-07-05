//
//  ViewController.swift
//  MoviePlayer
//
//  Created by CSMAC09 on 2023/07/05.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        let filePath:String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4")
        let url = NSURL(fileURLWithPath: filePath!)
//        let playerController = AVPlayerViewController()
//        let player = AVPlayer(url:  url as URL)
//        playerController.player = player
//        self.present(playerController, animated:  true)
//        {
//            player.play()
//        }
        playVideo(url: url)
    }
    
    @IBAction func btnPlayerExternalMovie(_ sender: UIButton) {
        let url = NSURL(string:"https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mp4")!
//        let playerController = AVPlayerViewController()
//
//        let player = AVPlayer(url: url as URL)
//        playerController.player = player
//
//        self.present(playerController, animated: true){
//            player.play()
//        }
        playVideo(url: url)
    }
    
    private func playVideo(url : NSURL){
        
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        self.present(playerController, animated: true){
            player.play()
        }
        
    }
}

