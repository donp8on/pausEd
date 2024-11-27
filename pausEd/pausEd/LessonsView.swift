//
//  LessonsView.swift
//  pausEd
//
//  Created by Don Payton on 10/29/24.
//

import SwiftUI

struct LessonsView: View {
    enum Category: String {
        case randomFacts = "Random Facts"
        case personalDevelopment = "Personal Development"
    }

    @State private var selectedCategory: Category = .randomFacts
    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject var timerManager: TimerManager
    @State private var cardScale: CGFloat = 1.0

    var body: some View {
        NavigationStack{
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]), startPoint: .bottomLeading, endPoint: .topTrailing)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Title
                        Text("Lessons")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.horizontal)

                        // Featured Content Banner
                        VStack(alignment: .leading) {
                            //Text("Lesson of the Day")
                                //.font(.headline)
                                //.padding(.bottom, 5)

                            Image("lesson") // Replace with your image asset
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                                .cornerRadius(15)
                                .shadow(radius: 2)
                                .scaleEffect(selectedCategory == .randomFacts ? 1.0 : 0.95) // Subtle scaling effect
                                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0), value: selectedCategory)
                        }
                        .padding(.horizontal)

                        // Categories Title
                        Text("Categories:")
                            .font(.headline)
                            .padding(.horizontal)

                        // Categories Chips
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                CategoryTab(title: "Random Facts", icon: "lightbulb", isSelected: selectedCategory == .randomFacts) {
                                    withAnimation(.spring()) {
                                        selectedCategory = .randomFacts
                                    }
                                }

                                CategoryTab(title: "Personal Development", icon: "person.crop.circle", isSelected: selectedCategory == .personalDevelopment) {
                                    withAnimation(.spring()) {
                                        selectedCategory = .personalDevelopment
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        // Description
                        Text("Learn something new every day! Select a category to explore different topics.")
                            .font(.body)
                            .padding(.horizontal)

                        // Lesson Cards
                        VStack(spacing: 15) {
                            if selectedCategory == .randomFacts {
                                LessonCard(title: "Food", subtitle: "Explore cuisines and nutrition facts", color: .red, destination: FoodFactsQuizView())
                                LessonCard(title: "Science", subtitle: "Discover fascinating scientific facts", color: .blue, destination: ScienceQuizView())
                                LessonCard(title: "History", subtitle: "Dive into historical events and trivia", color: .green, destination: HistoryFactsView())
                            } else if selectedCategory == .personalDevelopment {
                                LessonCard(title: "Mindfulness", subtitle: "Tips and tricks for mindfulness", color: .purple, destination: MindfulQuizView())
                                LessonCard(title: "Goal Setting", subtitle: "Learn to set and achieve goals", color: .orange, destination: GoalSettingView())
                                LessonCard(title: "Productivity", subtitle: "Boost your efficiency and output", color: .pink, destination: ProductivityFactView())
                            }
                        }
                        .padding(.horizontal)

                        Spacer(minLength: 50) // Add extra space at the bottom to prevent cut-off
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.purple]), startPoint: .leading, endPoint: .trailing),
                for: .navigationBar
            )
            .toolbarBackground(.hidden, for: .navigationBar)
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 0) // Prevents overlap
            }
        }
    }
}

// LessonCard Component
struct LessonCard<Destination: View>: View {
    var title: String
    var subtitle: String
    var color: Color
    var destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                Spacer()
            }
            .padding()
            .frame(height: 100)
            .background(color)
            .cornerRadius(15)
            .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle()) // Ensures no interference with default button behavior
    }
}



// CategoryTab Component
struct CategoryTab: View {
    var title: String
    var icon: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.headline)
                Text(title)
                    .font(.headline)
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
            .foregroundColor(isSelected ? .blue : .black)
            .cornerRadius(10)
            .scaleEffect(isSelected ? 1.1 : 1.0) // Animation for selected tab
            .animation(.spring(), value: isSelected)
        }
    }
}


struct LessonsView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsView(timerManager: TimerManager())
    }
}






