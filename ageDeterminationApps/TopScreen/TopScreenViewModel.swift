//
//  TopScreenViewModel.swift
//  ageDeterminationApps
//
//  Created by Training on 2021/03/14.
//  Copyright © 2021 training. All rights reserved.
//

import UIKit

class TopScreenViewModel{
    var model = TopScreenModel()
    func catchApiData(data: UIImage) {
        self.model.getImage(
            data: data, onSuccess: { result in
                switch result {
                case .success(let value):
                    let attributes = value["faces"][0]["attributes"]
                    let gender = attributes["gender"]["value"].string
                    let beauty_woman = attributes["beauty"]["female_score"].int
                    let beauty_man = attributes["beauty"]["male_score"].int
                    let age = attributes["age"]["value"].int
                    
                    let emotion_surprise = attributes["emotion"]["surprise"].int
                    let emotion_neutral = attributes["emotion"]["neutral"].int
                    let emotion_anger = attributes["emotion"]["anger"].int
                    let emotion_disgust = attributes["emotion"]["disgust"].int
                    let emotion_happiness = attributes["emotion"]["happiness"].int
                    let emotion_sadness = attributes["emotion"]["sadness"].int
                    let emotion_fear = attributes["emotion"]["fear"].int
                    
                    let datas = Test( gender: gender, age: age, beauty_woman: beauty_woman,
                                      beauty_man: beauty_man,emotion_surprise: emotion_surprise,
                                      emotion_neutral: emotion_neutral,emotion_anger: emotion_anger,
                                      emotion_disgust: emotion_disgust,emotion_happiness: emotion_happiness,
                                      emotion_sadness: emotion_sadness, emotion_fear: emotion_fear)
                    
                    print(datas)
                case .failure(let error):
                    print(error)
                }
            },
            onError: {_ in
            })
    }
}
