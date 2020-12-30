//
//  MoodListView.swift
//  Mood Recorder
//
//  Created by User03 on 2020/11/25.
//

import SwiftUI

struct MoodListView:View{
    @ObservedObject var moodData : MoodData
    @State private var showEditMood = true
    
    var body: some View {
        NavigationView{
            List{
                ForEach(moodData.myMood){(index) in
                    NavigationLink(
                        destination: MoodEditor(moodData: self.moodData, editMood: index)){
                        MoodRow(myMood:index)
                    }
                }
                .onDelete{(indexSet) in
                    self.moodData.myMood.remove(atOffsets: indexSet)
                }
                .onMove{(indexSet, index) in
                    self.moodData.myMood.move(fromOffsets: indexSet, toOffset: index)
                }
            }
            .navigationBarTitle("心情日記")
            .navigationBarItems(leading: EditButton(),trailing: Button(action:{self.showEditMood = true},label:{Image(systemName:"plus.circle.fill")}))
            .sheet(isPresented: $showEditMood){NavigationView{MoodEditor(moodData: self.moodData)}}
            
        }
    }
}

struct MoodListView_Previews: PreviewProvider{
    
    static var previews: some View{
        MoodListView(moodData: MoodData())
    }
}
