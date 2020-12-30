//
//  ContentView.swift
//  Mood Recorder
//
//  Created by User13 on 2020/11/24.
//

import SwiftUI

struct ContentView: View {
   @StateObject var moodData = MoodData()
    
    var body: some View {
        TabView{
            MoodListView(moodData:self.moodData).tabItem{
                Text("心情")
                Image(systemName: "face.smiling")
            }
            PieChartView(moodData:self.moodData).tabItem{
                Text("圓餅圖表")
                Image(systemName: "chart.pie")
            }
            CircleChartView(moodData:self.moodData).tabItem{
                Text("圓圈圖表")
                Image(systemName: "circle")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
