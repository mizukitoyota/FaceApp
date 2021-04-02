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
    @IBOutlet weak var topTitle: UINavigationBar!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            // デフォルトの画像を表示する
            imageView.image = UIImage(named: "pop_gazouha_image_desu.png")
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = .green
        }
    }
    @IBOutlet weak var selectImage: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var apiButton: UIButton!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectImageSetButton()
        self.cameraButtonSetButton()
        self.goFaceApiSetButton()
        self.navigationBarSetTitle()
        self.setButtonView()
    }
        
    // 画像が選択された時に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            self.imageView.image = selectedImage //imageViewにカメラロールから選んだ画像を表示する
        }
        self.dismiss(animated: true)  //画像をImageViewに表示したらアルバムを閉じる
    }
    
    func setButtonView() {
        //　背景色ー薄緑色
        buttonView.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.5, alpha:1.0)
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
        apiButton.setTitle("GO", for: .normal)
        // タイトルの色
        apiButton.setTitleColor(.red, for: .normal)
        apiButton.layer.cornerRadius = 20.0
        apiButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func navigationBarSetTitle() {
        self.navigationTitle.title = "顔認証"
        self.topTitle.titleTextAttributes
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
