//
//  moodData.swift
//  Mood Recorder
//
//  Created by User13 on 2020/11/24.
//

import Foundation
import Combine

class MoodData: ObservableObject{
    @Published var myMood = [Mood]()
    var cancellable: AnyCancellable?
    
    init(){
        if let data = UserDefaults.standard.data(forKey: "myMood"){
            let decoder = JSONDecoder()
            if let decodeData = try? decoder.decode([Mood].self, from:data){
                myMood = decodeData
            }
        }
        
        cancellable = $myMood
            .sink{ (value) in
                let encoder = JSONEncoder()
                do{
                    let data = try encoder.encode(value)
                    UserDefaults.standard.set(data, forKey: "myMood")
                }catch{
                    
                }
            }
    }
}
