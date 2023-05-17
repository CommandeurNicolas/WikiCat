//
//  SplashScreen.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 17/05/2023.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var loaded: Bool
    
    @State private var progress = 0.0
    
    var body: some View {
        VStack(spacing: 32) {
            Text("WikiCat")
                .font(.custom("Asap-SemiBold", size: 72))
            ProgressView(value: progress)
                .progressViewStyle(GaugeProgressStyle())
                .frame(width: 50, height: 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.ui.backgroundColor)
        .foregroundColor(Color.ui.primaryColor)
        .padding(.horizontal, 16)
        .task {
            await self.loadBreeds()
            print("breeds loaded")
            withAnimation(.easeIn(duration: 0.5)) {
                self.loaded = true
            }
        }
    }
    
    private func loadBreeds() async {
        await HttpRequestManager.shared.fetchBreeds()
    }
}

struct GaugeProgressStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(Color.ui.secondaryColor, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(loaded: .constant(false))
            .environmentObject(ModelData())
    }
}
