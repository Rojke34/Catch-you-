//
//  TableViewController.swift
//  Catch you!
//
//  Created by Kevin Rojas on 1/29/19.
//  Copyright © 2019 Kevin Rojas. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON
import SVProgressHUD

class TableViewController: UITableViewController {
    let service = CatchYouService.shareInstance
    
    @IBOutlet weak var videoPlayer: WKWebView!
    @IBOutlet weak var textLabel: UILabel!
    
    var videoID = String()
    var audioName = String() {
        didSet {
            print("|------------------------------------------------d", audioName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.videoPlayer.loadHTMLString("<iframe width=\"960\" height=\"515\" src=\"https://www.youtube.com/embed/jjuSfhYiup8)?controls=0\" frameborder=\"0\" allow=\"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>", baseURL: nil)
    }

    @IBAction func randomVideo(_ sender: Any) {
        SVProgressHUD.show()
        
        service.getRandomVideo { (data) in
            SVProgressHUD.dismiss()
            
            self.videoID = data["id"]["videoId"].stringValue
            
            print(data["id"]["videoId"].stringValue)
            
//            self.videoPlayer.loadHTMLString("<iframe width=\"960\" height=\"515\" src=\"https://www.youtube.com/embed/\(data["id"]["videoId"].stringValue)?controls=0\" frameborder=\"0\" allow=\"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>", baseURL: nil)
            
        }
    }

    @IBAction func analyseAudio(_ sender: Any) {
        SVProgressHUD.show()
        
        print("|....convertir el video en audio, videoID: ", videoID)
        
        service.downloadMP3(params: [:], videoID: "jjuSfhYiup8") { (data) in
            SVProgressHUD.dismiss()
            
            self.audioName = data["title"].stringValue
            self.textLabel.text = data["title"].stringValue
        }
    }
    
    @IBAction func cutMP3(_ sender: Any) {
        SVProgressHUD.show()
        
        service.cutMP3(params: [:], videoName: "example") { (data) in
            SVProgressHUD.dismiss()
            print("|-----------x", data)
        }
    }
    
    
    @IBAction func getAudioInfo(_ sender: Any) {
        SVProgressHUD.show()
        service.getAudioInfo(params: [:], videoName: "example") { (data) in
            SVProgressHUD.dismiss()
            print(data)
            
//            var result = data.arrayValue[0]
            
        }
    }
}
