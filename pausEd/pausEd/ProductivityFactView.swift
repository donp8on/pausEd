//
//  ProductivityFact.swift
//  pausEd
//
//  Created by Don Payton on 11/13/24.
//
import SwiftUI

struct ProductivityFact {
    let question: String
    let options: [String]
    let correctAnswer: String
    let explanation: String
}

struct ProductivityFactView: View {
    let productivityFacts: [ProductivityFact] = [
        ProductivityFact(
            question: "What is a benefit of taking regular breaks during work?",
            options: ["Improved focus", "Decreased productivity", "More distractions", "Increased fatigue"],
            correctAnswer: "Improved focus",
            explanation: "Regular breaks can help refresh your mind and improve focus over long periods."
        ),
        ProductivityFact(
            question: "Which tool can help you manage tasks effectively?",
            options: ["Social media", "Task management app", "Video games", "Television"],
            correctAnswer: "Task management app",
            explanation: "Task management apps help organize tasks and increase productivity."
        ),
        ProductivityFact(
            question: "What is the purpose of setting SMART goals?",
            options: ["To simplify goals", "To create actionable and measurable goals", "To add more tasks to your list", "To prioritize fun over productivity"],
            correctAnswer: "To create actionable and measurable goals",
            explanation: "SMART goals (Specific, Measurable, Achievable, Relevant, Time-bound) help clarify objectives and improve the likelihood of success."
        ),
        ProductivityFact(
            question: "What is one benefit of delegating tasks effectively?",
            options: ["Improved workload management", "Less accountability", "More micromanagement opportunities", "Reduced collaboration"],
            correctAnswer: "Improved workload management",
            explanation: "Delegating tasks allows you to focus on higher-priority work while empowering others to take ownership of tasks."
        ),
        ProductivityFact(
            question: "What is a common distraction that can hinder productivity?",
            options: ["Focus playlists", "Frequent phone notifications", "Goal setting", "Team collaboration"],
            correctAnswer: "Frequent phone notifications",
            explanation: "Notifications can interrupt workflow and make it harder to regain focus, reducing overall productivity."
        ),
        ProductivityFact(
            question: "What is a recommended length of a work session for optimal productivity?",
            options: ["25 minutes", "50 minutes", "3 hours", "90 minutes"],
            correctAnswer: "25 minutes",
            explanation: "The Pomodoro Technique suggests working in 25-minute intervals with short breaks to maintain focus and avoid burnout."
        )
    ]
    
    @State private var currentIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var showFeedback = false
    @State private var feedbackMessage = ""
    @State private var isCorrect = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Productivity Quiz")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Text(productivityFacts[currentIndex].question)
                .font(.headline)
                .padding(.horizontal)

            ForEach(productivityFacts[currentIndex].options, id: \.self) { option in
                Button(action: {
                    checkAnswer(selected: option)
                }) {
                    Text(option)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(selectedAnswer == option ? (isCorrect ? Color.green.opacity(0.2) : Color.red.opacity(0.2)) : Color.blue.opacity(0.1))
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            
            if showFeedback {
                Text(feedbackMessage)
                    .font(.subheadline)
                    .foregroundColor(isCorrect ? .green : .red)
                    .padding(.horizontal)
                    .transition(.opacity)
            }

            Spacer()
            
            HStack {
                Spacer()
                Button("Next Question") {
                    goToNextQuestion()
                }
                .padding()
                .disabled(selectedAnswer == nil) // Button enabled only after an answer is selected
                Spacer()
            }
        }
        .padding()
        .navigationTitle("Productivity Quiz")
        .navigationBarTitleDisplayMode(.inline)
        // Removed `.navigationBarBackButtonHidden(true)`
    }

    private func checkAnswer(selected: String) {
        selectedAnswer = selected
        let currentFact = productivityFacts[currentIndex]
        
        if selected == currentFact.correctAnswer {
            feedbackMessage = "Correct!"
            isCorrect = true
        } else {
            feedbackMessage = "Incorrect. \(currentFact.explanation)"
            isCorrect = false
        }

        withAnimation {
            showFeedback = true
        }
    }

    private func goToNextQuestion() {
        if currentIndex < productivityFacts.count - 1 {
            currentIndex += 1
            resetQuestion()
        } else {
            feedbackMessage = "Quiz completed!"
        }
    }

    private func resetQuestion() {
        selectedAnswer = nil
        showFeedback = false
        feedbackMessage = ""
    }
}

#Preview {
    ProductivityFactView()
}
