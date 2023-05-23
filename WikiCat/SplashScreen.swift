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
        .background(Color.ui.backgroundColor)
        .padding(.horizontal, 16)
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
        // Fetch api breeds
        let httpRequestManager = HttpRequestManager.shared
        await httpRequestManager.fetchBreeds()
        
        if !httpRequestManager.apiBreedList.isEmpty {
            // Update progress view label
            self.progressViewLabel = "Update local storage's informations ..."
            // Save api breeds to local storage
            RealmController.shared.saveApiCatBreeds(httpRequestManager.apiBreedList)
            // Load home page
            withAnimation(.easeIn(duration: 0.5)) {
                self.loaded = true
            }
        } else {
            // Nothing found on API
            // Update progress view label
            self.progressViewLabel = "Fetching local informations ..."
            // Fetch local storage
            let localBreeds = RealmController.shared.fetchCatBreed()
            if localBreeds.isEmpty {
                // Local storage empty so prevent user that app will close
                // TODO: show alert
                self.presentAlertError = true
                return
            } else {
                // Load home page
                withAnimation(.easeIn(duration: 0.5)) {
                    self.loaded = true
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(loaded: .constant(false))
            .environmentObject(ModelData())
    }
}
