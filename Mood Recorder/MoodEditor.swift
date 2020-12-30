//
//  MoodEditor.swift
//  Mood Recorder
//
//  Created by User13 on 2020/11/25.
//

import SwiftUI

struct MoodEditor: View{
    let moodTypes = ["😄","😡","😱","😯","😭","😈"]
    
    @Environment(\.presentationMode) var preMode
    @State private var title = ""
    @State private var moodType = ""
    @State private var score  = 0
    @State private var date = Date()
    @State private var keyEvent = false

    var moodData: MoodData
    var editMood : Mood?
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    var body: some View{
        Form{
            TextField("發生的事", text: $title)
            DatePicker("日期", selection: $date, in: ...Date(), displayedComponents: .date)
            HStack{
                Text("心情")
                Picker("心情", selection: $moodType){
                    ForEach(moodTypes, id: \.self){(type) in Text(type)
                    }
                }
                .padding()
                .labelsHidden()
                .pickerStyle( SegmentedPickerStyle() )
            }
            Stepper("指數: \(score)", value: $score,in: 1...10 )
            Toggle("重要事件", isOn: $keyEvent)
        }
        .navigationBarTitle(editMood == nil ? "新增心情":"修改心情")
        .navigationBarItems(trailing: Button("Save"){
            
            let mood = Mood(title: self.title, moodType: self.moodType, score: self.score, date: self.dateFormatter.string(from: self.date), keyEvent: self.keyEvent)
            
            if let editMood = self.editMood{
                let index = self.moodData.myMood.firstIndex{
                    return $0.id == editMood.id
                }!
                self.moodData.myMood[index] = mood
            }
            else{
                self.moodData.myMood.insert(mood, at:0)
            }
            self.preMode.wrappedValue.dismiss()
        })
        
        .onAppear()
        {
            if let editMood = self.editMood{
                self.title = editMood.title
                self.date = self.dateFormatter.date(from:editMood.date)!
                self.moodType = editMood.moodType
                self.keyEvent = editMood.keyEvent
                self.score = editMood.score
            }
        }
        
    }
}

struct MoodEditor_Previews: PreviewProvider {
    static var previews: some View{
        MoodEditor(moodData: MoodData())
    }
}
