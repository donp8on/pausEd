//
//  ScienceQuizView.swift
//  pausEd
//
//  Created by Don Payton on 11/12/24.
//




    
            
import SwiftUI

struct ScienceFact {
    let question: String
    let choices: [String]
    let correctAnswer: String
    let explanation: String
}

struct ScienceQuizView: View {
    let scienceFacts = [
        ScienceFact(
            question: "What planet is known as the Red Planet?",
            choices: ["Earth", "Mars", "Jupiter", "Venus"],
            correctAnswer: "Mars",
            explanation: "Mars is called the Red Planet because of its reddish appearance due to iron oxide on its surface."
        ),
        ScienceFact(
            question: "What is the chemical symbol for water?",
            choices: ["CO2", "O2", "H2O", "NaCl"],
            correctAnswer: "H2O",
            explanation: "H2O represents water, with two hydrogen atoms bonded to one oxygen atom."
        ),
        ScienceFact(
            question: "What gas do plants absorb from the atmosphere during photosynthesis?",
            choices: ["Oxygen", "Nitrogen", "Carbon Dioxide", "Methane"],
            correctAnswer: "Carbon Dioxide",
            explanation: "Plants absorb carbon dioxide and release oxygen during photosynthesis."
        ),
        ScienceFact(
            question: "What is the most abundant gas in Earth's atmosphere?",
            choices: ["Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"],
            correctAnswer: "Nitrogen",
            explanation: "Nitrogen makes up about 78% of Earth's atmosphere."
        ),
        ScienceFact(
            question: "Which planet has the most moons?",
            choices: ["Earth", "Mars", "Jupiter", "Saturn"],
            correctAnswer: "Saturn",
            explanation: "Saturn has 82 confirmed moons, more than any other planet."
        ),
        ScienceFact(
            question: "What is the boiling point of water in Celsius?",
            choices: ["0°C", "50°C", "100°C", "212°C"],
            correctAnswer: "100°C",
            explanation: "Water boils at 100°C or 212°F under standard atmospheric conditions."
        ),
        ScienceFact(
            question: "Which vitamin is primarily produced by the skin when exposed to sunlight?",
            choices: ["Vitamin A", "Vitamin B", "Vitamin C", "Vitamin D"],
            correctAnswer: "Vitamin D",
            explanation: "Sunlight exposure triggers vitamin D production in the skin."
        ),
        ScienceFact(
            question: "What is the powerhouse of the cell?",
            choices: ["Nucleus", "Mitochondria", "Ribosome", "Endoplasmic Reticulum"],
            correctAnswer: "Mitochondria",
            explanation: "Mitochondria generate most of the cell's energy in the form of ATP."
        ),
        ScienceFact(
            question: "Which planet is the hottest in our solar system?",
            choices: ["Mercury", "Venus", "Mars", "Jupiter"],
            correctAnswer: "Venus",
            explanation: "Venus has an extremely dense atmosphere that traps heat, making it the hottest planet."
        ),
        ScienceFact(
            question: "What type of blood cells help our bodies fight infection?",
            choices: ["Red blood cells", "White blood cells", "Platelets", "Plasma"],
            correctAnswer: "White blood cells",
            explanation: "White blood cells are essential for immune defense against infections."
        ),
        ScienceFact(
            question: "Which element is the main component of the Earth's core?",
            choices: ["Aluminum", "Iron", "Copper", "Nickel"],
            correctAnswer: "Iron",
            explanation: "The Earth's core is primarily composed of iron, along with some nickel."
        ),
        ScienceFact(
            question: "What does DNA stand for?",
            choices: ["Deoxyribose Nucleic Acid", "Deoxyribonucleic Acid", "Dioxygen Nucleic Acid", "Diethyl Nucleic Acid"],
            correctAnswer: "Deoxyribonucleic Acid",
            explanation: "DNA stands for Deoxyribonucleic Acid, the molecule that carries genetic information."
        ),
    ]
    
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var showCorrectMessage = false
    @State private var showExplanation = false
    @State private var quizCompleted = false // Track if quiz is completed

    var body: some View {
        VStack(spacing: 20) {
            Text(scienceFacts[currentQuestionIndex].question)
                .font(.title)
                .padding()
            
            ForEach(scienceFacts[currentQuestionIndex].choices, id: \.self) { choice in
                Button(action: {
                    selectedAnswer = choice
                    if choice == scienceFacts[currentQuestionIndex].correctAnswer {
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
                                ? (choice == scienceFacts[currentQuestionIndex].correctAnswer ? Color.green.opacity(0.7) : Color.red.opacity(0.7))
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
                Text(scienceFacts[currentQuestionIndex].explanation)
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
        .navigationTitle("Science Quiz")
        //.navigationBarBackButtonHidden(true)
    }
    
    private func nextQuestion() {
        if currentQuestionIndex < scienceFacts.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showExplanation = false
        } else {
            quizCompleted = true
        }
    }
}

struct ScienceQuizView_Previews: PreviewProvider {
    static var previews: some View {
        ScienceQuizView()
    }
}

