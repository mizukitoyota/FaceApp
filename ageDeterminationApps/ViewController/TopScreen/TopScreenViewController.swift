//
//  TopScreenViewController.swift
//  ageDeterminationApps
//
//  Created by Training on 2021/03/14.
//  Copyright © 2021 training. All rights reserved.
//

import UIKit

class TopScreenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var topScreenView: UIView!
    @IBOutlet weak var topTitleNavigationBar: UINavigationBar!
    @IBOutlet weak var topButtonView: UIView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var imageSelectButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var faceApiButton: UIButton!
    @IBOutlet weak var topNavigationTitleItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDefaultImage()
        self.setSelectImageButton()
        self.setCameraButton()
        self.goFaceApiButton()
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
    
    func setSelectImageButton() {
        // 写真選択ボタン
        self.imageSelectButton.setTitle("イメージの選択", for: .normal)
        // ボタン色
        self.imageSelectButton.setTitleColor(.red, for: .normal)
        self.imageSelectButton.layer.cornerRadius = 10.0
        self.imageSelectButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func setCameraButton() {
        // カメラボタン
        self.cameraButton.setTitle("カメラ起動", for: .normal)
        // ボタン色
        self.cameraButton.setTitleColor(.red, for: .normal)
        self.cameraButton.layer.cornerRadius = 10.0
        self.cameraButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func goFaceApiButton() {
        // APIボタン
        self.faceApiButton.setTitle("GO", for: .normal)
        // ボタン色
        self.faceApiButton.setTitleColor(.red, for: .normal)
        self.faceApiButton.layer.cornerRadius = 20.0
        self.faceApiButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func setNavigationBarTitle() {
        // タイトル
        self.topNavigationTitleItem.title = "顔認証"
    }
    
    @IBAction func launchCamera(sender: UIButton) {
        // カメラ起動
        let camera = UIImagePickerController.SourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(camera) {
            let picker = UIImagePickerController()
            picker.sourceType = camera
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
    }
    
    // 画像選択がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
