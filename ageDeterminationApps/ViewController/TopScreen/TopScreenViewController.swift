//
//  TopScreenViewController.swift
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
    public var image_id: String?
    public var request_id: String?
    public var time_used: Int?
    public var gender: String?
    public var age: Int?
    public var beauty_woman: Int?
    public var beauty_man: Int?
    public var emotion_surprise: Int?
    public var emotion_neutral: Int?
    public var emotion_anger: Int?
    public var emotion_disgust: Int?
    public var emotion_happiness: Int?
    public var emotion_sadness: Int?
    public var emotion_fear: Int?
//init(image_id: String, request_id: String, time_used: Int, gender: String, age: Int, beauty_woman: Int, beauty_man: Int, emotion_surprise: Int, emotion_neutral: Int, emotion_anger: Int, emotion_disgust: Int, emotion_happiness: Int, emotion_sadness: Int, emotion_fear: Int)
//    self.
}
    
class TopScreenViewController: UIViewController, UIImagePickerControllerDelegate,URLSessionDelegate, URLSessionDataDelegate, UINavigationControllerDelegate {
    @IBOutlet var topScreenView: UIView!
    @IBOutlet weak var topTitleNavigationBar: UINavigationBar!
    @IBOutlet weak var topButtonView: UIView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var imageSelectButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var faceApiButton: UIButton!
    @IBOutlet weak var topNavigationTitleItem: UINavigationItem!
    var coupons: [[String: Any]] = [] { //パースした[String: Any]型のクーポンデータを格納するメンバ変数
        didSet{
        }
    }
    let viewModel = TopScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDefaultImage()
        self.setButton(buttonName: imageSelectButton,title: "イメージの選択",radius: 10)
        self.setButton(buttonName: cameraButton,title: "カメラ起動", radius: 10)
        self.setButton(buttonName: faceApiButton,title: "GO", radius: 20)
        self.setNavigationBarTitle()
        self.setButtonView()
    }
    
    // 画像が選択された時に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            // imageViewにカメラロールから選んだ画像を表示する
            self.topImageView.image = selectedImage
        }
        // 画像をImageViewに表示したらアルバムを閉じる
        self.dismiss(animated: true)
    }
    
    func setDefaultImage() {
        // デフォルトの画像を表示する
        self.topImageView.image = UIImage(named: "pop_gazouha_image_desu")
        self.topImageView.contentMode = .scaleAspectFit
        self.topImageView.backgroundColor = .green
    }
    func setButtonView() {
        // 背景色ー薄緑色
        self.topButtonView.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.5, alpha:1.0)
    }
    
    func setButton(buttonName: UIButton, title: String, radius: CGFloat) {
        // ボタンタイトル設定
        buttonName.setTitle(title, for: .normal)
        // ボタン色設定
        buttonName.setTitleColor(.red, for: .normal)
        buttonName.layer.cornerRadius = radius
        buttonName.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func setNavigationBarTitle() {
        // タイトル
        self.topNavigationTitleItem.title = "顔認証"
    }
    
    @IBAction func launchCamera(sender: UIButton) {
        // カメラ起動
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker, animated: true)
        }
    }
    
    @IBAction func albumButton(_ sender: UIButton) {
        // アルバム起動
        let picker = UIImagePickerController() //アルバムを開く処理を呼び出す
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        // 画面遷移、API
        getImages(onSuccess: {_ in},
                       onError: {_ in})
//        viewmodels(onSuccess: {_ in},
//                             onError: {_ in})
        // 画面遷移
        let storyboard: UIStoryboard = UIStoryboard(name: "ResultScreen", bundle: nil)
        // StoryboardIDを指定してViewControllerを取得する
        let fourthViewController = storyboard.instantiateViewController(withIdentifier: "ResultScreen") as! ResultScreenViewController
        fourthViewController.modalPresentationStyle = .fullScreen
        self.present(fourthViewController, animated: true, completion: nil)
    }
    
    // 画像選択がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    // 検索キーワードの値を元に画像を引っ張ってくる
    // pixabay.com
    func getImages(onSuccess: @escaping(Result<JSON, Error>) -> Void,
                   onError: @escaping(Error) -> Void) {
        
        let photo = self.topImageView.image
        let imageData = photo!.jpegData(compressionQuality: 0.2)
        
        guard let base64String = imageData?.base64EncodedString() else {
            return
        }
        // APIKEY: 2FeR2N3--DLdJOV8RmYi7snd4oplNrpy
        // SecretKey: 0vp2s3Ihe22KEYa_TiWHbLqbbr857EN_
        // API URL: https://api-us.faceplusplus.com/facepp/v3/detect
        // キャスト
        //            let json:JSON = JSON(response.data as Any)
        // let config:URLSessionConfiguration = URLSessionConfiguration.default
        // Sessionを生成.
        // let session: URLSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        // 通信先のURLを生成.
        //        let myUrl:URL = URL(string: "https://api-us.faceplusplus.com/facepp/v3/detect")!
        // POST用のリクエストを生成.
        guard let url = URL(string: "https://api-us.faceplusplus.com/facepp/v3/detect") else { return }
        // リクエスト設定
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "POST"
        // 送信するデータを生成、リクエストにセット.
        //        let str: NSString = "api_key=\("2FeR2N3--DLdJOV8RmYi7snd4oplNrpy")api_secret=\("0vp2s3Ihe22KEYa_TiWHbLqbbr857EN_")image_url=\(imageString)return_attributes=gender,age" as NSString
        //        let myData: NSData = str.data(using: String.Encoding.utf8.rawValue)! as NSData
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
                let json = JSON(value)
            case .failure(let error):
                onError(error)
                print(error)
            }
        }
    }
    
//    func viewmodels(onSuccess: (Result<JSON, Error>) -> Void,
//                    onError: (Error) -> Void) {
//        getImages(
//            onSuccess: { result in
//                switch result {
//                case .success(let value):
//                    let attributes = value["faces"][0]["attributes"]
//                    let gender = attributes["gender"]["value"].string
//                    let beauty_woman = attributes["beauty"]["female_score"].int
//                    let beauty_man = attributes["beauty"]["male_score"].int
//                    let age = attributes["age"]["value"].int
//
//                    let emotion_surprise = attributes["emotion"]["surprise"].int
//                    let emotion_neutral = attributes["emotion"]["neutral"].int
//                    let emotion_anger = attributes["emotion"]["anger"].int
//                    let emotion_disgust = attributes["emotion"]["disgust"].int
//                    let emotion_happiness = attributes["emotion"]["happiness"].int
//                    let emotion_sadness = attributes["emotion"]["sadness"].int
//                    let emotion_fear = attributes["emotion"]["fear"].int
//
//                    let datas = Test( gender: gender, age: age, beauty_woman: beauty_woman, beauty_man: beauty_man, emotion_surprise: emotion_surprise, emotion_neutral: emotion_neutral, emotion_anger: emotion_anger, emotion_disgust: emotion_disgust, emotion_happiness: emotion_happiness, emotion_sadness: emotion_sadness, emotion_fear: emotion_fear)
//                    func aaa(){
//                        print(datas)
//                    }
//                    print(gender ?? "No_Gender",beauty_woman ?? "No_WomanLady",beauty_man ?? "No_NiceGay",age ?? "No_Age")
//                case .failure(let error):
//                    print(error)
//                }
//            },
//            onError: { _ in
//            })
//    }
    func ast(){
        getImages(onSuccess: {_ in}, onError: {_ in})
    }
}
