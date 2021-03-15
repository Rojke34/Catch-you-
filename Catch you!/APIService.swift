//
//  APIService.swift
//  Catch you!
//
//  Created by Kevin Rojas on 1/29/19.
//  Copyright © 2019 Kevin Rojas. All rights reserved.
//

import Alamofire
import SwiftyJSON

class CatchYouService: NSObject {
    var baseURL = "http://192.168.2.74:3003/"
    
    static let shareInstance = CatchYouService()
    
    func getRandomVideo(_ completion: @escaping (JSON) -> ()) {
        mainRequest(endPoint: "random_video", method: .post, completion: completion)
    }
    
    func downloadMP3(params: Parameters, videoID: String, _ completion: @escaping (JSON) -> ()) {
        mainRequest(endPoint: "convert_video_to_mp3/\(videoID)", params: params, method: .get, completion: completion)
    }
    
    func cutMP3(params: Parameters, videoName: String, _ completion: @escaping (JSON) -> ()) {
        mainRequest(endPoint: "cut_mp3/\(videoName)", params: params, method: .get, completion: completion)
    }
    
    func getAudioInfo(params: Parameters, videoName: String, _ completion: @escaping (JSON) -> ()) {
        mainRequest(endPoint: "get_audio_info/\(videoName)", params: params, method: .get, completion: completion)
    }
    
    //Main -----
    func mainRequest(endPoint: String, params: Parameters = [:], method: HTTPMethod, completion: @escaping (JSON) -> ()) {
        print("|1 🔥")
        print("|3 URL ", baseURL + endPoint)
        print("|4 🔥")
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Cache-Control" : "no-cache, must-revalidate"
        ]
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 440
        
        manager.request(baseURL + endPoint, method: method, parameters: params, encoding: JSONEncoding(options: []), headers: header)
            
            .responseJSON { response in
                
                let json = JSON(response.data as Any)
                print(json)
                
                DispatchQueue.main.async(execute: {
                    completion(json)
                })
        }
        
    }
}
