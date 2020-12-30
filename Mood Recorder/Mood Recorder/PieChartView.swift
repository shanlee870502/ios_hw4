//
//  PieChartView.swift
//  Mood Recorder
//
//  Created by User03 on 2020/11/25.
//

import SwiftUI

struct PieChartView: View{
    @ObservedObject var moodData : MoodData
    var percentages: [Double]
    var angle:[Angle]
    var types = ["😄","😡","😱","😯","😭","😈"]
    var colors:[Color]
    
    init(moodData: MoodData){
        self.moodData = moodData
        if moodData.myMood.count == 0{
            self.colors = [Color.white,Color.white,Color.white,Color.white,Color.white,Color.white,Color.white]
            self.percentages = [0.0,0.0,0.0,0.0,0.0,0.0]
            self.angle = [.degrees(0),.degrees(0),.degrees(0),.degrees(0),.degrees(0),.degrees(0),.degrees(0)]
        }
        else{
            percentages = [0.0,0.0,0.0,0.0,0.0,0.0]
            angle = [Angle]()
            colors = [Color.yellow, Color.red, Color.purple, Color.green, Color.blue, Color.gray]
            var totalMood = 0
            for mood in moodData.myMood{
                totalMood += mood.score;
                for index in 0...5{
                    if(types[index] == mood.moodType){
                        percentages[index] += Double(mood.score)
                    }
                }
            }
            var startDegree: Double = 0
            for index in 0...5{
                percentages[index] /= Double(totalMood)
                angle.append(.degrees(startDegree))
                startDegree += 360 * percentages[index]
            }
        }
    }
    var body: some View{
        VStack{
            ZStack{
                ForEach(angle.indices){(index) in
                    ExtractedView(index: index, angle: self.angle, colors: self.colors)
                }
                
            }.frame(width:300, height:300)
            HStack{
                ForEach(types.indices){(index) in
                    VStack{
                    colors[index].frame(width:10, height:10)
                    Text(types[index] + "\n"+String(format: "%.f",percentages[index] * 100)+"%")
                    }
                }
            }
            
            .padding()
        }
    }
}

struct ExtractedView: View{
    var index: Int
    var angle: [Angle]
    var colors: [Color]
    var body: some View{
        ZStack{
            if index == (angle.count-1)
            {
                Chart(startAngle: angle[index], endAngle: .degrees(360)).fill(colors[index].opacity(0.8))
            }
            else{
                Chart(startAngle: angle[index], endAngle: angle[index+1]).fill(colors[index].opacity(0.8))
            }
        }
    }
}

struct Chart: Shape{
    var startAngle:Angle
    var endAngle: Angle
    func path(in rect: CGRect)-> Path{
        Path{(path) in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            path.move(to:center)
            path.addArc(center:center, radius:rect.midX, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(moodData: MoodData())
    }
}
