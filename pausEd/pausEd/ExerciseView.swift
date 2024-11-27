//
//  ExerciseView.swift
//  pausEd
//
//  Created by Don Payton on 10/29/24.
//
import SwiftUI

struct ExerciseView: View {
    @ObservedObject var timerManager: TimerManager // Accept timerManager

    @State private var selectedCategory: String = "Relax"
    
    // Data for each exercise including description, steps, and image
    let exercises: [String: [Exercise]] = [
        "Stretch": [
            Exercise(name: "Neck Stretch", description: "Relieves tension in the neck.", steps: ["Sit comfortably.", "Tilt your head to the side.", "Hold for 15-30 seconds."], imageName: "neck_stretch"),
            Exercise(name: "Shoulder Stretch", description: "Relaxes shoulder muscles.", steps: ["Stand tall.", "Cross one arm over your chest.", "Hold for 15-30 seconds."], imageName: "shoulder_stretch"),
            Exercise(name: "Hamstring Stretch", description: "Stretches the back of your legs.", steps: ["Stand and bend forward.", "Reach towards your toes.", "Hold for 15-30 seconds."], imageName: "hamstring_stretch")
        ],
        "Relax": [
            Exercise(name: "Breathing Focus", description: "Focuses on deep breathing to calm the mind.", steps: ["Sit comfortably.", "Take a deep breath in.", "Exhale slowly."], imageName: "breathing_focus"),
            Exercise(name: "Body Scan", description: "Promotes relaxation by scanning each body part.", steps: ["Sit or lie down comfortably.", "Close your eyes.", "Mentally scan each body part."], imageName: "body_scan"),
            Exercise(name: "Mindful Seeing", description: "Encourages observing surroundings mindfully.", steps: ["Find a quiet spot.", "Observe your surroundings.", "Focus on shapes and colors."], imageName: "mindful_seeing")
        ],
        "Movement": [
            Exercise(name: "Jogging", description: "Increases heart rate and improves endurance.", steps: ["Start at a slow pace.", "Increase speed gradually.", "Maintain for 15-30 minutes."], imageName: "jogging"),
            Exercise(name: "Dancing", description: "A fun way to get your body moving.", steps: ["Choose your favorite song.", "Dance freely to the rhythm.", "Continue for several songs."], imageName: "dancing"),
            Exercise(name: "Hiking", description: "Improves stamina and leg strength.", steps: ["Choose a trail.", "Wear comfortable shoes.", "Start hiking at a steady pace."], imageName: "hiking")
        ]
    ]

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]), startPoint: .bottomLeading, endPoint: .topTrailing)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Title
                        HStack {
                            Text("Exercises")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            Spacer()
                        }
                        .padding(.top)

                        // Featured Content Banner
                        VStack(alignment: .leading) {
                            Image("exer") // Replace with your image asset
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                                .cornerRadius(15)
                                .shadow(radius: 2)
                        }
                        .padding(.horizontal)

                        // Categories Title
                        Text("Categories:")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        // Enhanced Category Tabs
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ExerCategoryTab(title: "Stretch", isSelected: selectedCategory == "Stretch") {
                                    withAnimation {
                                        selectedCategory = "Stretch"
                                    }
                                }
                                
                                ExerCategoryTab(title: "Relax", isSelected: selectedCategory == "Relax") {
                                    withAnimation {
                                        selectedCategory = "Relax"
                                    }
                                }
                                
                                ExerCategoryTab(title: "Movement", isSelected: selectedCategory == "Movement") {
                                    withAnimation {
                                        selectedCategory = "Movement"
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        // Description Text
                        Text("Exercise is like turning the ignition key—it's any activity that gets your body moving, whether it's jogging, dancing, swimming, or even hiking with friends!")
                            .font(.body)
                            .padding(.horizontal)

                        // Exercise Cards
                        VStack(spacing: 15) {
                            ForEach(exercises[selectedCategory] ?? []) { exercise in
                                ExerciseCard(exercise: exercise)
                            }
                        }
                        .padding(.horizontal)

                        Spacer(minLength: 50) // Add extra space at the bottom to prevent cut-off
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

// Custom Exercise Card Component
struct ExerciseCard: View {
    var exercise: Exercise

    var body: some View {
        NavigationLink(destination: WorkoutDetailedView(exercise: exercise)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(exercise.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                Spacer()
            }
            .padding()
            .frame(height: 100)
            .background(Color.blue)
            .cornerRadius(15)
            .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle()) // Removes the default button styling for the NavigationLink
    }
}

// Category Tab Component
struct ExerCategoryTab: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
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

// Exercise Model
struct Exercise: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let steps: [String]
    let imageName: String
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(timerManager: TimerManager())
    }
}

