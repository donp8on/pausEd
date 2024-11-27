//
//  MindfulQuizView.swift
//  pausEd
//
//  Created by Don Payton on 11/12/24.
//

import SwiftUI

struct MindfulFact {
    let question: String
    let choices: [String]
    let correctAnswer: String
    let explanation: String
}

struct MindfulQuizView: View {
    let mindfulFacts = [
        MindfulFact(
            question: "What does being present in the moment help improve?",
            choices: ["Focus", "Memory", "Creativity", "All of the above"],
            correctAnswer: "All of the above",
            explanation: "Being present helps improve focus, memory, and creativity by reducing distractions and improving awareness."
        ),
        MindfulFact(
            question: "Which of the following can be enhanced by practicing awareness?",
            choices: ["Decision making", "Social interactions", "Physical health", "All of the above"],
            correctAnswer: "All of the above",
            explanation: "Practicing awareness can enhance decision-making, social interactions, and physical health by improving attention and emotional regulation."
        ),
        MindfulFact(
            question: "Which technique is commonly used to reduce stress and improve concentration?",
            choices: ["Deep breathing", "Watching TV", "Drinking coffee", "Listening to loud music"],
            correctAnswer: "Deep breathing",
            explanation: "Deep breathing exercises are a simple and effective way to reduce stress and improve concentration by calming the nervous system."
        ),
        MindfulFact(
            question: "What is a key benefit of observing your thoughts without judgment?",
            choices: ["Increased stress", "Clarity of mind", "Reduced focus", "Avoiding emotions"],
            correctAnswer: "Clarity of mind",
            explanation: "Observing thoughts without judgment helps create mental clarity by separating yourself from negative or distracting thoughts."
        ),
        MindfulFact(
            question: "How does regular practice of being present affect emotional reactions?",
            choices: ["Makes reactions more intense", "Reduces impulsive reactions", "Increases anxiety", "Has no effect"],
            correctAnswer: "Reduces impulsive reactions",
            explanation: "Regular practice of being present helps regulate emotions, leading to more thoughtful and less impulsive reactions."
        ),
        MindfulFact(
            question: "What can practicing non-judgmental awareness help improve?",
            choices: ["Self-compassion", "Self-criticism", "Negative thinking", "Distraction"],
            correctAnswer: "Self-compassion",
            explanation: "Non-judgmental awareness helps foster self-compassion by allowing you to accept yourself without harsh judgment."
        ),
        MindfulFact(
            question: "What part of the brain is most involved in emotional regulation and self-awareness?",
            choices: ["Amygdala", "Hippocampus", "Prefrontal cortex", "Cerebellum"],
            correctAnswer: "Prefrontal cortex",
            explanation: "The prefrontal cortex is responsible for emotional regulation and higher cognitive functions, such as self-awareness and decision-making."
        ),
        MindfulFact(
            question: "Which of these is a recommended strategy for reducing anxiety?",
            choices: ["Ruminating on problems", "Taking slow, deep breaths", "Ignoring the situation", "Overthinking future events"],
            correctAnswer: "Taking slow, deep breaths",
            explanation: "Slow, deep breathing activates the parasympathetic nervous system, which helps calm the body and reduce anxiety."
        ),
        MindfulFact(
            question: "Why is paying attention to your breath an important practice?",
            choices: ["It calms the body", "It improves digestion", "It reduces your heart rate", "All of the above"],
            correctAnswer: "All of the above",
            explanation: "Focusing on your breath can activate the parasympathetic nervous system, helping to calm the body, improve digestion, and reduce heart rate."
        ),
        MindfulFact(
            question: "What can regular practice of awareness help with over time?",
            choices: ["Improved sleep quality", "Increased stress levels", "Reduced memory", "Less focus"],
            correctAnswer: "Improved sleep quality",
            explanation: "Awareness practices can improve sleep quality by reducing stress and calming the mind before sleep."
        )
    ]
    
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var showCorrectMessage = false
    @State private var showExplanation = false
    @State private var quizCompleted = false // Track if quiz is completed
    
    var body: some View {
        VStack(spacing: 20) {
            Text(mindfulFacts[currentQuestionIndex].question)
                .font(.title)
                .padding()
                .multilineTextAlignment(.center) // Ensure multi-line wrapping
                .lineLimit(nil) // No line limit, allows wrapping
                .frame(maxWidth: .infinity, alignment: .leading) // Expand to full width
                .fixedSize(horizontal: false, vertical: true) // Allow vertical expansion

                        
            
            ForEach(mindfulFacts[currentQuestionIndex].choices, id: \.self) { choice in
                Button(action: {
                    selectedAnswer = choice
                    if choice == mindfulFacts[currentQuestionIndex].correctAnswer {
                        showCorrectMessage = true
                        showExplanation = false
                        // Delay moving to the next question
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            nextQuestion()
                        }
                    } else {
                        showExplanation = true
                        showCorrectMessage = false
                    }
                }) {
                    Text(choice)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedAnswer == choice
                                ? (choice == mindfulFacts[currentQuestionIndex].correctAnswer ? Color.green.opacity(0.7) : Color.red.opacity(0.7))
                                : Color.blue.opacity(0.2)
                        )
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            
            if showCorrectMessage {
                Text("Correct!")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.top)
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showCorrectMessage = false
                        }
                    }
            } else if showExplanation && selectedAnswer != nil {
                Text(mindfulFacts[currentQuestionIndex].explanation)
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .padding()
                    .transition(.opacity)
            }
            
            Spacer()

            if quizCompleted {
                Text("Quiz completed!")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding()
            } else {
                Button("Next Question") {
                    nextQuestion()
                }
                .padding()
                .disabled(selectedAnswer == nil) // Disable until an answer is selected
            }
        }
        .padding()
        .navigationTitle("Mindfulness Quiz")
        //.navigationBarBackButtonHidden(true)
    }
    
    private func nextQuestion() {
        if currentQuestionIndex < mindfulFacts.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showExplanation = false
        } else {
            quizCompleted = true
        }
    }
}

struct MindfulQuizView_Previews: PreviewProvider {
    static var previews: some View {
        MindfulQuizView()
    }
}

