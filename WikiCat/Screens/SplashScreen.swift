//
//  SplashScreen.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 17/05/2023.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var loaded: Bool
    
    @State var progressViewLabel: String = "Fetching cat breeds informations ..."
    
    @State private var presentAlertError: Bool = false
    
    var body: some View {
        VStack(spacing: 32) {
            // App title
            Text("WikiCat")
                .font(.custom("Asap-SemiBold", size: 72))
                .foregroundColor(Color.ui.primaryColor)
            // Separator
            Divider()
                .frame(width: 100, height: 4)
                .overlay {
                    Capsule()
                        .fill(Color.ui.secondaryColor)
                }
            // Progress view
            VStack {
                Text(progressViewLabel)
                    .font(.custom("Asap-Italic", size: 16))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.ui.secondaryColor)
                ProgressView()
                    .tint(Color.ui.secondaryColor)
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .background(Color.ui.backgroundColor)
        .task {
            await self.loadBreeds()
        }
        .alert(isPresented: $presentAlertError) {
            Alert(
                title: Text("An error occured while fetching cat breeds"),
                message: Text("Please check your network connectivity before retrying !"),
                primaryButton: .default(Text("Retry")) {
                    Task {
                        await self.loadBreeds()
                    }
                },
                secondaryButton: .destructive(Text("Quit")) {
                    self.progressViewLabel = "Closing WikiCat ..."
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        exit(0)
                    }
                }
            )
        }
    }

    private func loadBreeds() async {
        guard let url = URL(string: HttpRequestManager.shared.base_url + "breeds") else {
            print("Invalid URL")
            return
        }
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            print("Retrieving API KEY failed")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
            let result = try JSONDecoder().decode([CatBreed].self, from: data)
            
            // Save api breeds to local storage
            let dataRepository = DataRepository.shared
            // Update progress view label
            self.progressViewLabel = "Update local storage's informations ..."
            if (await dataRepository.isDatabaseEmpty()) {
                await dataRepository.insert(catBreeds: result)
            } else {
                await dataRepository.updateIfNeeded(apiCatBreeds: result)
            }
            
            // Update progress view label
            self.progressViewLabel = "Fetching local informations ..."
            // Show error if no cat breed found in database
            if (await dataRepository.isDatabaseEmpty()) {
                self.presentAlertError = true
            } else {
                // ELSE load home page
                withAnimation(.easeIn(duration: 0.5)) {
                    self.loaded = true
                }
            }
        } catch {
            print("error \(error.localizedDescription)")
            self.presentAlertError = true
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(loaded: .constant(false))
            .environmentObject(ModelData())
    }
}
