//
//  Mood.swift
//  Mood Recorder
//
//  Created by User13 on 2020/11/24.
//

import Foundation

struct Mood: Identifiable, Codable{
    let id = UUID()
    var title: String
    var moodType:String
    var score: Int
    var date: String
    var keyEvent: Bool
}
