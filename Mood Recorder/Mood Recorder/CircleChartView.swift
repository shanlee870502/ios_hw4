
//
//  CircleChartView.swift
//  Mood Recorder
//
//  Created by User03 on 2020/11/25.
//

import SwiftUI


struct CircleChartView: View{
    @ObservedObject var moodData : MoodData
    var percentages:[Double]
    var degree:[CGFloat]
    var types = ["😄","😡","😱","😯","😭","😈"]
    var colors:[Color]
    var totalScore: Int=0
    
    init(moodData: MoodData)
    {
        self.moodData = moodData
        if moodData.myMood.count == 0{
            colors = [Color.white,Color.white,Color.white,Color.white,Color.white,Color.white]
            percentages = [1.0]
            degree = [0.0,0.0,0.0,0.0,0.0,0.0]
        }
        else{
            percentages = [0.0,0.0,0.0,0.0,0.0,0.0]
            colors = [Color.gray, Color.red, Color.purple, Color.green, Color.blue, Color.yellow]
            degree = [0.0, CGFloat(percentages[0])]
            
            for mood in moodData.myMood{
                totalScore += mood.score
                for index in 0...5{
                    if(types[index] == mood.moodType){
                        percentages[index] += Double(mood.score)
                    }
                }
            }
            for index in 0...5{
                percentages[index] /= Double(totalScore)
            }
            for index in 2...5{
                degree.append(CGFloat(percentages[index-1]) + degree[index-1])
            }
        }
    }
    
    var body: some View{
        ZStack{
            ForEach(degree.indices){(index) in
                circleView(index: index, degree: self.degree, colors: self.colors)
            }
            Text("心情積分：\(totalScore)分")
        }
        .frame(width:200, height:200)
    }
}

struct circleView: View {
    var index : Int
    var degree : [CGFloat]
    var colors : [Color]
    var body: some View {
        VStack{
            if index == (self.degree.count-1){
                Circle()
                    .trim(from: self.degree[index], to:1)
                    .stroke(self.colors[index],lineWidth: CGFloat(30))
            }
            else{
                Circle()
                    .trim(from: self.degree[index], to:self.degree[index+1])
                    .stroke(self.colors[index],lineWidth: CGFloat(30))
            }
        }
    }
}

struct CircleChartView_Previews: PreviewProvider {
    static var previews: some View{
        CircleChartView(moodData: MoodData())
    }
}

