//
//  LoadingView.swift
//  Flicker
//
//  Created by Soha Ahmed on 08/12/2023.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var isActive = false

    @State private var isSelected = false
    @Namespace private var swipeAnimation
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack{
                Text("Flicker")
                    .font(.largeTitle).bold()
                    .foregroundStyle(.secondary)
                
                
                HStack(spacing: 20){
                    if isSelected {
                        singleCircle(name: "first", color: .blue)
                        
                        singleCircle(name: "second", color: .pink)
                    } else {
                        singleCircle(name: "second", color: .pink)
                        
                        singleCircle(name: "first", color: .blue)
                    }
                }
                .animation(.linear(duration:0.3), value: isSelected)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(Color.gray.opacity(0.3))
            .onReceive(timer) { value in
                withAnimation{
                    isSelected.toggle()
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func singleCircle(name: String, color: Color) -> some View {
        Circle()
            .foregroundColor(color)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
            .matchedGeometryEffect(id: name, in: swipeAnimation)
    }
}

#Preview {
    LoadingView()
}
