//
//  TopScreenModel.swift
//  ageDeterminationApps
//
//  Created by Training on 2021/03/14.
//  Copyright © 2021 training. All rights reserved.
//

import UIKit
//HTTPリクエスト
import Alamofire
//（ユーザー情報の保存）JSONファイル解析
import SwiftyJSON

struct Test {
    let image_id: String?
    let request_id: String?
    let time_used: Int?
    let gender: String?
    let age: Int?
    let beauty_woman: Int?
    let beauty_man: Int?
    let emotion_surprise: Int?
    let emotion_neutral: Int?
    let emotion_anger: Int?
    let emotion_disgust: Int?
    let emotion_happiness: Int?
    let emotion_sadness: Int?
    let emotion_fear: Int?
}

class TopScreenModel {
    /// データ表現
    /// データ変更をViewModelへ通知
        
    // 検索キーワードの値を元に画像を引っ張ってくるResult:appleの成功時、
    // pixabay.com
    func getImage(data: UIImage?, onSuccess: @escaping(Result<JSON, Error>) -> Void,
                   onError: @escaping(Error) -> Void) {
    guard let imageData = data?.jpegData(compressionQuality: 0.2) else {
            return
        }
        let base64String = imageData.base64EncodedString()
        // APIKEY: 2FeR2N3--DLdJOV8RmYi7snd4oplNrpy
        // SecretKey: 0vp2s3Ihe22KEYa_TiWHbLqbbr857EN_
        // API URL: https://api-us.faceplusplus.com/facepp/v3/detect
        // POST用のリクエストを生成.
        guard let url = URL(string: "https://api-us.faceplusplus.com/facepp/v3/detect") else { return }
        // リクエスト設定
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "POST"
        //         通信用のConfigを生成.
        let configer: [String: Any] = ["api_key" : "2FeR2N3--DLdJOV8RmYi7snd4oplNrpy",
                                       "api_secret": "0vp2s3Ihe22KEYa_TiWHbLqbbr857EN_",
                                       "image_base64": base64String,
                                       "return_landmark": 1,
                                       "return_attributes": "gender,age,beauty,emotion"]
        // responseJSONーAPIサーバーとの通信処理
        // Alamofireを使ってhttpリクエストを投げます。getでリクエストを投げる（URL形式）、responseが返ってくる
        AF.request(url, method: .post, parameters: configer).responseJSON { (response) in
            print(response)
            switch response.result {
            case .success(let value):
                onSuccess(.success(JSON(value)))
            case .failure(let error):
                onError(error)
                print(error)
            }
        }
    }
    func viewmodels(onSuccess: (Result<JSON, Error>) -> Void,
                    onError: (Error) -> Void) {
    }
}
