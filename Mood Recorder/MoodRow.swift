//
//  MoodRow.swift
//  Mood Recorder
//
//  Created by User13 on 2020/11/24.
//

import SwiftUI

struct MoodRow: View{
    var myMood: Mood
    var colors = [Color.yellow, Color.red, Color.purple, Color.green, Color.blue, Color.gray]
    
    var types = ["😄","😡","😱","😯","😭","😈"]
    var body: some View{
        HStack(spacing:5){
            
            Text("\(myMood.title)").bold().frame(width:55)
            Text("\(myMood.moodType)x\(myMood.score)")
            Text("\(myMood.date)").foregroundColor(.gray).font(.system(size:12))
            Image(systemName: myMood.keyEvent ?  "heart.fill":"heart")
            
        }.padding(.horizontal).background(colors[types.firstIndex(of: myMood.moodType) ?? 0].opacity(0.2))
    }
}

struct MoodRow_Previes: PreviewProvider {
    static var previews: some View {
        MoodRow(myMood: Mood(title: "單身之夜", moodType: "開心", score: 5, date: "2020/11/11", keyEvent: false))
        
    }
}
