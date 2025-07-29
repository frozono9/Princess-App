//
//  ContentView.swift
//  PrincessCardTrick
//
//  Created by Alex Latorre on 28/7/25.
//

import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    @State private var enteredCode = ""
    @State private var showHomeScreen = true
    @State private var showGridA = true // State to toggle between grids
    @State private var selectedAppName: String = "New York" // Holds the revealed app name

    var body: some View {
        ZStack {
            // The background is applied here and set to ignore the safe area,
            // so it extends to the screen edges without affecting the UI layout.
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            Color.black.opacity(0.1)
                .ignoresSafeArea()

            // TabView to allow swiping between the home screen and a widget screen
            TabView {
                // Page 1: Main Home Screen
                HomeScreenView(
                    showGridA: $showGridA,
                    selectedAppName: $selectedAppName,
                    enteredCode: $enteredCode,
                    showHomeScreen: $showHomeScreen
                )
                .offset(y: 20) // Offset widgets and apps downward

                // Page 2: Widget Screen
                WidgetScreenView()
                .offset(y: 20) // Offset widgets downward
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxHeight: .infinity, alignment: .top) // Ensure TabView is anchored at the top
            .ignoresSafeArea(edges: .top) // Ensure TabView ignores safe area constraints
            
            // ONE static dock over everything
            VStack {
                Spacer()
                DockView(
                    enteredCode: $enteredCode,
                    showHomeScreen: $showHomeScreen,
                    showGridA: $showGridA,
                    selectedAppName: $selectedAppName
                )
                .padding(.horizontal, 60)
                .padding(.bottom, 34) // Account for safe area at bottom
                .offset(y: -70) // Offset dock upward
            }
            .ignoresSafeArea(.container, edges: .bottom) // Extend into safe area
        }
        .frame(maxHeight: .infinity, alignment: .top) // Ensure ZStack is anchored at the top
    }
}

// MARK: - Home Screen View
struct HomeScreenView: View {
    @Binding var showGridA: Bool
    @Binding var selectedAppName: String
    @Binding var enteredCode: String
    @Binding var showHomeScreen: Bool

    var body: some View {
        VStack(spacing: 20) {
            // Widgets
            HStack(spacing: 12) {
                WeatherWidget(selectedCity: selectedAppName)
                CalendarWidget()
            }
            .padding(.horizontal, 20)

            // App Grid
            AppGrid(isGridA: showGridA, selectedAppName: $selectedAppName)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // Anchor content to the top
        .ignoresSafeArea(edges: .top) // Extend container to the top edge
        .contentShape(Rectangle())
        .onTapGesture {
            if showGridA {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showGridA = false
                    selectedAppName = "Revolut"
                }
            }
        }
    }
}

// MARK: - Widget Screen View
struct WidgetScreenView: View {
    var body: some View {
        VStack(spacing: 15) {
            // 10-app grid
            // Row 1: 4 apps
            HStack(spacing: 25) {
                AppIcon(name: "Amazon", imageName: "amazon-icon")
                AppIcon(name: "Stocks", imageName: "stocks-icon")
                AppIcon(name: "Passwords", imageName: "passwords-icon")
                AppIcon(name: "McDonalds", imageName: "mcdonalds-icon")
            }
            
            // Row 2: 4 apps
            HStack(spacing: 25) {
                AppIcon(name: "Calculator", imageName: "calculator-icon")
                AppIcon(name: "Birds", imageName: "birds-icon")
                AppIcon(name: "Wallet", imageName: "wallet-icon")
                AppIcon(name: "Contacts", imageName: "contacts-icon")
            }
            
            // Row 3: 2 apps (shifted right)
            HStack(spacing: 25) {
                Spacer()
                AppIcon(name: "Netflix", imageName: "netflix-icon")
                AppIcon(name: "Taxi", imageName: "taxi-icon")
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()

            }
        }
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // Anchor content to the top
        .ignoresSafeArea(edges: .top) // Extend container to the top edge
    }
}

// MARK: - Weather Widget
struct WeatherWidget: View {
    let selectedCity: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(selectedCity)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
            
            Text("23°")
                .font(.system(size: 42, weight: .thin))
                .foregroundColor(.white)
            
            Spacer()
            
            HStack {
                Image(systemName: "sun.max.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 12))
                
                Text("Sunny")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            Text("H:77° L:55°")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
            
            Text("Weather")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white.opacity(0.6))
        }
        .padding(16)
        .frame(width: 155, height: 155)
        .background(
            LinearGradient(
                colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
    }
}

// MARK: - Calendar Widget
struct CalendarWidget: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("MONDAY")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.red.opacity(0.8))
                
                Spacer()
            }
            
            Text("10")
                .font(.system(size: 28, weight: .light))
                .foregroundColor(.white)
            
            HStack(spacing: 6) {
                Image(systemName: "gift.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 12))
                
                Text("2 birthdays")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Portfolio work s...")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.red)
                
                Text("10 - 10:30AM")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
            
            Text("Calendar")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white.opacity(0.6))
        }
        .padding(14)
        .frame(width: 155, height: 155)
        .background(
            LinearGradient(
                colors: [Color.black.opacity(0.7), Color.black.opacity(0.5)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
    }
}

// MARK: - App Grid
struct AppGrid: View {
    let isGridA: Bool
    @Binding var selectedAppName: String

    var body: some View {
        VStack(spacing: 15) {
            if isGridA {
                GridAViews()
            } else {
                GridBViews(selectedAppName: $selectedAppName)
            }
        }
    }
}

// MARK: - App Icon
struct AppIcon: View {
    let name: String
    let imageName: String
    let isDock: Bool
    let action: (() -> Void)?
    
    init(name: String, imageName: String, isDock: Bool = false, action: (() -> Void)? = nil) {
        self.name = name
        self.imageName = imageName
        self.isDock = isDock
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            VStack(spacing: 8) {
                Image(imageName)
                    .resizable()
                    .frame(width: isDock ? 65 : 62, height: isDock ? 65 : 62)
                    .cornerRadius(isDock ? 16 : 14)
                
                if !isDock {
                    Text(name)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Dock View
struct DockView: View {
    @Binding var enteredCode: String
    @Binding var showHomeScreen: Bool
    @Binding var showGridA: Bool
    @Binding var selectedAppName: String
    
    var body: some View {
        HStack(spacing: 25) {
            AppIcon(name: "Phone", imageName: "phone-icon", isDock: true, action: {
                // Reset the grid and the selected app name
                withAnimation {
                    showGridA = true
                    selectedAppName = "New York"
                }
            })
            AppIcon(name: "Mail", imageName: "mail-icon", isDock: true)
            AppIcon(name: "Messages", imageName: "messages-icon", isDock: true)
            AppIcon(name: "Notes", imageName: "notes-icon", isDock: true)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14) // Increased vertical padding for a taller background
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.black.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
                )
        )
    }
}

// MARK: - Regular App Rows
struct RegularAppRows: View {
    var body: some View {
        VStack(spacing: 10) {
            // This view is no longer directly used by AppGrid,
            // but is kept here for reference or future use.
            // The content is now in GridAViews.
            // Row 1
            HStack(spacing: 25) {
                AppIcon(name: "FaceTime", imageName: "facetime-icon")
                AppIcon(name: "Calendar", imageName: "calendar-icon")
                AppIcon(name: "Photos", imageName: "photos-icon")
                AppIcon(name: "Camera", imageName: "camera-icon")
            }
            
            // Row 2
            HStack(spacing: 25) {
                AppIcon(name: "Mail", imageName: "mail-icon")
                AppIcon(name: "Notes", imageName: "notes-icon")
                AppIcon(name: "Reminders", imageName: "reminders-icon")
                AppIcon(name: "Clock", imageName: "clock-icon")
            }
            
            // Row 3
            HStack(spacing: 25) {
                AppIcon(name: "News", imageName: "news-icon")
                AppIcon(name: "TV", imageName: "tv-icon")
                AppIcon(name: "Podcasts", imageName: "podcasts-icon")
                AppIcon(name: "App Store", imageName: "appstore-icon")
            }
        }
    }
}

// MARK: - Grid A and B Views
struct GridAViews: View {
    var body: some View {
        VStack(spacing: 15) {
            // Row 1
            HStack(spacing: 25) {
                AppIcon(name: "Instagram", imageName: "instagram-icon")
                AppIcon(name: "Whatsapp", imageName: "whatsapp-icon")
                AppIcon(name: "Memos", imageName: "memos-icon")
                AppIcon(name: "Safari", imageName: "safari-icon")
            }
            
            // Row 2
            HStack(spacing: 25) {
                AppIcon(name: "Clock", imageName: "clock-icon")
                AppIcon(name: "News", imageName: "news-icon")
                AppIcon(name: "Authen...", imageName: "authenticator-icon")
                AppIcon(name: "Calendar", imageName: "calendar-icon")
            }
            
            // Row 3
            HStack(spacing: 25) {
                AppIcon(name: "Camera", imageName: "camera-icon")
                AppIcon(name: "Messenger", imageName: "messenger-icon")
                AppIcon(name: "Podcasts", imageName: "podcasts-icon")
                AppIcon(name: "Reddit", imageName: "reddit-icon")
            }
            
            // Row 4
            HStack(spacing: 25) {
                AppIcon(name: "Youtube", imageName: "youtube-icon")
                AppIcon(name: "Maps", imageName: "maps-icon")
                AppIcon(name: "ChatGPT", imageName: "chatgpt-icon")
                AppIcon(name: "Revolut", imageName: "revolut-icon")
            }
        }
    }
}

struct GridBViews: View {
    @Binding var selectedAppName: String

    // This dictionary maps the tapped app in Grid B to the original app in Grid A.
    let gridBtoAGuessMapping: [String: String] = [
        // Grid B Name : Grid A Name
        "Music": "Instagram",
        "Spotify": "Whatsapp",
        "FilmIn": "Memos",
        "Shazam": "Safari",
        "TV": "Clock",
        "Center": "News",
        "Outlook": "Authenticator",
        "Reminders": "Calendar",
        "Settings": "Camera",
        "PayPal": "Messenger",
        "zim": "Podcasts",
        "NFC": "Reddit",
        "Health": "Youtube",
        "Colors": "Maps",
        "CapCut": "ChatGPT"
        // The last app is missing, so it's not in the map.
    ]

    var body: some View {
        VStack(spacing: 15) {
            // Row 1 (Similar colors to Grid A's Row 1)
            HStack(spacing: 25) {
                AppIcon(name: "Music", imageName: "music-icon", action: { selectedAppName = gridBtoAGuessMapping["Music"] ?? "" })
                AppIcon(name: "Spotify", imageName: "spotify-icon", action: { selectedAppName = gridBtoAGuessMapping["Spotify"] ?? "" })
                AppIcon(name: "FilmIn", imageName: "filmin-icon", action: { selectedAppName = gridBtoAGuessMapping["FilmIn"] ?? "" })
                AppIcon(name: "Shazam", imageName: "shazam-icon", action: { selectedAppName = gridBtoAGuessMapping["Shazam"] ?? "" })
            }
            
            // Row 2 (Similar colors to Grid A's Row 2)
            HStack(spacing: 25) {
                AppIcon(name: "TV", imageName: "tv-icon", action: { selectedAppName = gridBtoAGuessMapping["TV"] ?? "" })
                AppIcon(name: "Center", imageName: "center-icon", action: { selectedAppName = gridBtoAGuessMapping["Center"] ?? "" })
                AppIcon(name: "Outlook", imageName: "outlook-icon", action: { selectedAppName = gridBtoAGuessMapping["Outlook"] ?? "" })
                AppIcon(name: "Reminders", imageName: "reminders-icon", action: { selectedAppName = gridBtoAGuessMapping["Reminders"] ?? "" })
            }
            
            // Row 3 (Similar colors to Grid A's Row 3)
            HStack(spacing: 25) {
                AppIcon(name: "Settings", imageName: "settings-icon", action: { selectedAppName = gridBtoAGuessMapping["Settings"] ?? "" })
                AppIcon(name: "PayPal", imageName: "paypal-icon", action: { selectedAppName = gridBtoAGuessMapping["PayPal"] ?? "" })
                AppIcon(name: "zim", imageName: "zim-icon", action: { selectedAppName = gridBtoAGuessMapping["zim"] ?? "" })
                AppIcon(name: "NFC", imageName: "nfctools-icon", action: { selectedAppName = gridBtoAGuessMapping["NFC"] ?? "" })
            }
            
            // Row 4 (One app is missing)
            HStack(spacing: 25) {
                AppIcon(name: "Health", imageName: "health-icon", action: { selectedAppName = gridBtoAGuessMapping["Health"] ?? "" })
                AppIcon(name: "Colors", imageName: "colors-icon", action: { selectedAppName = gridBtoAGuessMapping["Colors"] ?? "" })
                AppIcon(name: "CapCut", imageName: "capcut-icon", action: { selectedAppName = gridBtoAGuessMapping["CapCut"] ?? "" })
                // The 4th app is gone, creating an empty space
                Spacer().frame(width: 62, height: 62)
            }
        }
    }
}


#Preview {
    ContentView()
}
