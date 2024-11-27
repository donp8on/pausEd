//
//  HomeView.swift
//  pausEd
//
//  Created by Don Payton on 10/29/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct homeView: View {
    let quotes = [
        "“Today is your opportunity to build the tomorrow you want.” - Ken Poirot",
        "“The only way to do great work is to love what you do.” - Steve Jobs",
        "“Success is not final, failure is not fatal: It is the courage to continue that counts.” - Winston Churchill",
        "“Your time is limited, don’t waste it living someone else’s life.” - Steve Jobs",
        "“The best way to predict the future is to create it.” - Peter Drucker",
        "”Opportunities don't happen, you create them.” – Chris Grosser",
        "”It always seems impossible until it's done.” – Nelson Mandela",
        "”Don’t count the days, make the days count.” – Muhammad Ali",
        "”You miss 100% of the shots you don’t take.” – Wayne Gretzky"
    ]
    
    @State private var selectedQuote = ""
    @State private var isStacked = true // State to control card layout
    @ObservedObject var timerManager: TimerManager
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]), startPoint: .bottomLeading, endPoint: .topTrailing)
                    .ignoresSafeArea()
                ScrollView{
                    VStack(spacing: 20) {
                        // Welcome Message
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Welcome,")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .font(.system(size: 50))
                                Text("Adonis Payton")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .font(.system(size: 50))
                            }
                            Spacer()
                        }
                        .padding(.horizontal)

                        // Quote Section
                        Text(selectedQuote)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .center)  // Expands horizontally
                            .fixedSize(horizontal: false, vertical: true)   // Ensures the height grows with content

                        
                        // Featured Content Banner as Button
                        NavigationLink(destination: ProductivityFactView()) {
                            VStack(alignment: .leading) {
                                Text("Time Management Basics")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("Master the art of productivity with our tips and tricks.")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.9))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                        }
                        .padding(.top)
                        
                        NavigationLink(destination: GoalSettingView()) {
                            VStack(alignment: .leading) {
                                Text("Unlock Your Potential")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("Start Your Journey Towards Achieving Your Dreams, One Goal at a Time!")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.9))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                        }
                        //.padding(.top)


                        
                        HStack {
                            Text("Explore Categories")
                                .font(.title)
                                .bold()
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)
                                .padding(.bottom)
                            Spacer()
                        }
                        
                        // Interactive cards
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: isStacked ? -40 : 20) {
                                CategoryCardView(
                                    title: "Lessons",
                                    imageName: "book.fill",
                                    color: Color.purple,
                                    destination: LessonsView(timerManager: TimerManager())
                                )

                                CategoryCardView(
                                    title: "Exercise",
                                    imageName: "figure.walk",
                                    color: Color.green,
                                    destination: ExerciseView(timerManager: TimerManager())
                                )

                                CategoryCardView(
                                    title: "Start a Timer",
                                    imageName: "clock.fill",
                                    color: Color.orange,
                                    destination: TimerView(timerManager: timerManager)
                                )
                            }
                            .padding(.horizontal)
                            .animation(.spring(), value: isStacked)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    isStacked = false
                                }
                            }
                        }
                        .frame(height: 200) // Adjust for card height


                        Spacer()
                    }
                    .onAppear {
                        // Randomly select a quote
                        selectedQuote = quotes.randomElement() ?? "“Today is your opportunity to build the tomorrow you want.” - Ken Poirot"
                    }
                }
            }
        }
    }
}

struct CategoryCardView<Destination: View>: View {
    let title: String
    let imageName: String
    let color: Color
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 10) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 175, height: 175)
                    .foregroundColor(.white)

                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .frame(width: 300, height: 250)
            .background(color)
            .cornerRadius(20)
            .shadow(radius: 5)
        }
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView(timerManager: TimerManager())
        
    }
}



