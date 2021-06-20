//
//  TopScreenViewController.swift
//  ageDeterminationApps
//
//  Created by Training on 2021/03/14.
//  Copyright © 2021 training. All rights reserved.
//

import UIKit
    
class TopScreenViewController: UIViewController {
    @IBOutlet var topScreenView: UIView!
    @IBOutlet weak var topTitleNavigationBar: UINavigationBar!
    @IBOutlet weak var topButtonView: UIView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var imageSelectButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var faceApiButton: UIButton!
    @IBOutlet weak var topNavigationTitleItem: UINavigationItem!
    
    let viewModel = TopScreenViewModel()
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDefaultImage()
        self.setButton(buttonName: imageSelectButton,title: "イメージの選択",radius: 10)
        self.setButton(buttonName: cameraButton,title: "カメラ起動", radius: 10)
        self.setButton(buttonName: faceApiButton,title: "GO", radius: 20)
        self.setNavigationBarTitle()
        self.setButtonView()
        picker.delegate = self
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
            picker.sourceType = .camera
            self.present(picker, animated: true)
        }
    }
    
    @IBAction func albumButton(_ sender: UIButton) {
        //アルバムを開く処理を呼び出す
       picker.sourceType = .photoLibrary
       self.present(picker, animated: true)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        guard let photo = self.topImageView.image else {
            return
        }
        // 画面遷移、API
        self.viewModel.catchApiData(data: photo)
        print()
        // 画面遷移
        let storyboard: UIStoryboard = UIStoryboard(name: "ResultScreen", bundle: nil)
        // StoryboardIDを指定してViewControllerを取得する
        let fourthViewController = storyboard.instantiateViewController(withIdentifier: "ResultScreen") as! ResultScreenViewController
        self.present(fourthViewController, animated: true, completion: nil)
    }
    
    // 画像選択がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
// delegateについて調べる
extension TopScreenViewController: UIImagePickerControllerDelegate{
    // 画像が選択された時に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            // imageViewにカメラロールから選んだ画像を表示する
            self.topImageView.image = selectedImage
        }
        // 画像をImageViewに表示したらアルバムを閉じる
        self.dismiss(animated: true)
    }
}

extension TopScreenViewController: UINavigationControllerDelegate {
    
}
