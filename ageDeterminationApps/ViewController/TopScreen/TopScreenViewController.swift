//
//  TopScreenViewController.swift
//  ageDeterminationApps
//
//  Created by Training on 2021/03/14.
//  Copyright © 2021 training. All rights reserved.
//

import UIKit

class TopScreenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var TopScreenView: UIView!
    @IBOutlet weak var TopTitle: UINavigationBar!
    @IBOutlet weak var ButtonView: UIView!
    @IBOutlet weak var ImageView: UIImageView! {
        didSet {
            // デフォルトの画像を表示する
            ImageView.image = UIImage(named: "pop_gazouha_image_desu.png")
            ImageView.contentMode = UIView.ContentMode.scaleAspectFit
            ImageView.backgroundColor = UIColor.green
        }
    }
    @IBOutlet weak var selectImage: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var goFaceApi: UIButton!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectImageSetButton()
        self.cameraButtonSetButton()
        self.goFaceApiSetButton()
        self.navigationBarSetTitle()
        self.setButtonView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 画像が選択された時に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            self.ImageView.image = selectedImage //imageViewにカメラロールから選んだ画像を表示する
        }
        self.dismiss(animated: true)  //画像をImageViewに表示したらアルバムを閉じる
    }
    
    func setButtonView() {
        //　背景色ー薄緑色
        ButtonView.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.5, alpha:1.0)
    }
    
    func selectImageSetButton() {
        // タイトル
        selectImage.setTitle("イメージの選択", for: .normal)
        // タイトルの色
        selectImage.setTitleColor(.red, for: .normal)
        selectImage.layer.cornerRadius = 10.0
        selectImage.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func cameraButtonSetButton() {
        // タイトル
        cameraButton.setTitle("カメラ起動", for: .normal)
        // タイトルの色
        cameraButton.setTitleColor(.red, for: .normal)
        cameraButton.layer.cornerRadius = 10.0
        cameraButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func goFaceApiSetButton() {
        // タイトル
        goFaceApi.setTitle("GO", for: .normal)
        // タイトルの色
        goFaceApi.setTitleColor(.red, for: .normal)
        goFaceApi.layer.cornerRadius = 20.0
        goFaceApi.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func navigationBarSetTitle() {
        self.navigationTitle.title = "顔認証"
        self.TopTitle.titleTextAttributes
            = [NSAttributedString.Key.font: UIFont(name: "Futura-Bold", size: 20)!]
    }
    @IBAction func launchCamera(sender: UIButton) {
        // カメラ起動
        let camera = UIImagePickerController.SourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(camera) {
            let picker = UIImagePickerController()
            picker.sourceType = camera
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func albumButton(_ sender: UIButton) {
        // アルバム起動
        let picker = UIImagePickerController() //アルバムを開く処理を呼び出す
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        // 画面遷移、API
    }
    
    // 画像選択がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
