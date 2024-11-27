//
//  GoalSettingView.swift
//  pausEd
//
//  Created by Don Payton on 11/12/24.
//

import SwiftUI

struct Goal: Identifiable, Codable {
    var id = UUID()  // Add a unique identifier
    var description: String
    var steps: [String]
    var timeframe: String
    var motivation: String
}

struct GoalSettingView: View {
    @State private var goals: [Goal] = []
    @State private var newGoal: String = ""
    @State private var newStep: String = ""
    @State private var newTimeframe: String = ""
    @State private var newMotivation: String = ""
    @State private var selectedGoalIndex: Int? = nil
    
    let goalsKey = "goals" // Key to store goals in UserDefaults
    
    var body: some View {
        ScrollView {  // Wrap everything inside one ScrollView
            VStack(spacing: 30) {
                Text("Goal Setting")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // Show form to add new goal
                VStack(spacing: 20) {
                    TextField("Enter your goal", text: $newGoal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    Button(action: addGoal) {
                        Text("Add Goal")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(newGoal.isEmpty ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(newGoal.isEmpty)
                }
                .padding(.horizontal)
                
                // Show existing goals
                if !goals.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Your Goals")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        ForEach(goals) { goal in
                            Button(action: {
                                if let index = goals.firstIndex(where: { $0.id == goal.id }) {
                                    selectedGoalIndex = index
                                }
                            }) {
                                HStack {
                                    Text(goal.description)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right.circle.fill")
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                                .shadow(radius: 3)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Show details and questions for selected goal
                if let index = selectedGoalIndex {
                    let goal = goals[index]
                    
                    VStack(spacing: 20) {
                        Text("Goal: \(goal.description)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        
                        Text("How will you achieve this goal?")
                            .font(.subheadline)
                            .padding(.top)
                        
                        // Steps to achieve goal
                        ForEach(goal.steps, id: \.self) { step in
                            Text("Step: \(step)")
                                .padding(.horizontal)
                        }
                        
                        // Timeframe and motivation
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Timeframe: \(goal.timeframe)")
                                .padding(.horizontal)
                            
                            Text("Motivation: \(goal.motivation)")
                                .padding(.horizontal)
                        }
                        
                        // Add new step and ask questions
                        VStack(spacing: 20) {
                            TextField("New step to achieve this goal", text: $newStep)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            TextField("Timeframe for this step", text: $newTimeframe)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            TextField("Why is this goal important to you?", text: $newMotivation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            Button(action: {
                                updateGoal()
                            }) {
                                Text("Add Step & Motivation")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(newStep.isEmpty || newTimeframe.isEmpty || newMotivation.isEmpty ? Color.gray : Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .disabled(newStep.isEmpty || newTimeframe.isEmpty || newMotivation.isEmpty)
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            selectedGoalIndex = nil // Deselect goal and go back to goal list
                        }) {
                            Text("Back to All Goals")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.vertical)
                }
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                loadGoals() // Load goals when the view appears
            }
            .onDisappear {
                saveGoals() // Save goals when the view disappears
            }
        }
    }
    
    private func addGoal() {
        // Add new goal to the list
        let goal = Goal(description: newGoal, steps: [], timeframe: "", motivation: "")
        goals.append(goal)
        newGoal = "" // Clear input field
        saveGoals() // Save goals to UserDefaults
    }
    
    private func updateGoal() {
        guard let index = selectedGoalIndex else { return }
        
        // Add the new step, timeframe, and motivation to the selected goal
        goals[index].steps.append(newStep)
        goals[index].timeframe = newTimeframe
        goals[index].motivation = newMotivation
        
        // Reset the form fields
        newStep = ""
        newTimeframe = ""
        newMotivation = ""
        saveGoals() // Save goals to UserDefaults
    }
    
    private func saveGoals() {
        // Convert goals to Data and save to UserDefaults
        if let encoded = try? JSONEncoder().encode(goals) {
            UserDefaults.standard.set(encoded, forKey: goalsKey)
        }
    }
    
    private func loadGoals() {
        // Load saved goals from UserDefaults
        if let savedGoals = UserDefaults.standard.data(forKey: goalsKey),
           let decodedGoals = try? JSONDecoder().decode([Goal].self, from: savedGoals) {
            goals = decodedGoals
        }
    }
}

struct GoalSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GoalSettingView()
    }
}




