//
//  ResultScreenViewController.swift
//  ageDeterminationApps
//
//  Created by Training on 2021/05/06.
//  Copyright © 2021 training. All rights reserved.
//

import UIKit

class ResultScreenViewController: UIViewController{
    @IBOutlet var ResultScreen: UIView!
    private var testValue : Test?
    var value: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(testValue ?? "何もない")
    }
    func close(){
        self.dismiss(animated: true, completion: nil)
    }
}
