//
//  HistoryFactsView.swift
//  pausEd
//
//  Created by Don Payton on 11/12/24.
//


import SwiftUI

struct HistoryFactsView: View {
    struct HistoryFact {
        let statement: String
        let options: [String]
        let correctAnswer: String
        let explanation: String
    }

    let historyFacts: [HistoryFact] = [
        HistoryFact(
            statement: "Who discovered America?",
            options: ["Christopher Columbus", "Leif Erikson", "Marco Polo", "Vasco da Gama"],
            correctAnswer: "Christopher Columbus",
            explanation: "Columbus reached the Americas in 1492, although other explorers like Leif Erikson are thought to have arrived earlier."
        ),
        
        HistoryFact(
            statement: "What year did World War II end?",
            options: ["1941", "1943", "1945", "1947"],
            correctAnswer: "1945",
            explanation: "World War II ended in 1945 after Germany and Japan surrendered."
        ),
        
        HistoryFact(
            statement: "The Great Wall of China was built to protect against which invaders?",
            options: ["Mongols", "Romans", "Persians", "Ottomans"],
            correctAnswer: "Mongols",
            explanation: "The Great Wall was built to protect Chinese states from the Mongols and other northern tribes."
        ),
        
        HistoryFact(
            statement: "What was the main reason for the fall of the Roman Empire?",
            options: ["Invasions by Barbarian tribes", "Economic struggles", "Political corruption", "All of the above"],
            correctAnswer: "All of the above",
            explanation: "The Roman Empire fell due to a combination of factors, including invasions, economic troubles, and political issues."
        ),
        
        HistoryFact(
            statement: "What year was the Declaration of Independence signed?",
            options: ["1776", "1778", "1788", "1801"],
            correctAnswer: "1776",
            explanation: "This document, primarily authored by Thomas Jefferson, declared the American colonies' independence from Britain."
        ),
        
        HistoryFact(
            statement: "What was the Boston Tea Party a protest against?",
            options: ["Religious beliefs", "British taxes", "The colonist hated the taste of tea", "Guns and Weapons"],
            correctAnswer: "British taxes",
            explanation: "Colonists threw tea into Boston Harbor to protest the Tea Act, which led to escalating tensions."
        ),
        
        HistoryFact(
            statement: "Who was the second president of the United States?",
            options: ["Thomas Jefferson", "George Washington", "Abraham Lincoln", "John Adams"],
            correctAnswer: "John Adams",
            explanation: "John Adams served as the second president of the United States from 1797 to 1801, following George Washington."
        ),
        
        HistoryFact(
            statement: "What year did the American Civil War begin?",
            options: ["1776", "1812", "1861", "1901"],
            correctAnswer: "1861",
            explanation: "The American Civil War began in 1861, primarily over issues of slavery and states' rights."
        ),
        
        HistoryFact(
            statement: "Who was the first woman to fly solo across the Atlantic Ocean?",
            options: ["Amelia Earhart", "Eleanor Roosevelt", "Harriet Tubman", "Bessie Coleman"],
            correctAnswer: "Amelia Earhart",
            explanation: "Amelia Earhart became the first woman to fly solo across the Atlantic Ocean in 1932, making a significant contribution to aviation history."
        ),
        
        HistoryFact(
            statement: "Which U.S. president issued the Emancipation Proclamation?",
            options: ["Abraham Lincoln", "George Washington", "Andrew Jackson", "Thomas Jefferson"],
            correctAnswer: "Abraham Lincoln",
            explanation: "Abraham Lincoln issued the Emancipation Proclamation in 1863, which declared that all slaves in Confederate states were free."
        ),
        
        HistoryFact(
            statement: "What ancient civilization built the pyramids in Egypt?",
            options: ["Romans", "Macedonians", "Egyptians", "Persians"],
            correctAnswer: "Egyptians",
            explanation: "The ancient Egyptians built the pyramids as tombs for pharaohs and were some of the most remarkable feats of engineering in history."
        ),

        HistoryFact(
            statement: "What year did the Titanic sink?",
            options: ["1912", "1905", "1921", "1898"],
            correctAnswer: "1912",
            explanation: "The RMS Titanic sank on April 15, 1912, after hitting an iceberg during its maiden voyage, leading to the loss of over 1,500 lives."
        ),

        HistoryFact(
            statement: "Which empire was ruled by Julius Caesar?",
            options: ["Roman Empire", "Ottoman Empire", "Mongol Empire", "Byzantine Empire"],
            correctAnswer: "Roman Empire",
            explanation: "Julius Caesar was a key figure in the Roman Empire, playing a pivotal role in its transition from republic to empire."
        )

    ]
    @State private var selectedAnswer: String? = nil
        @State private var showFeedback: Bool = false
        @State private var feedbackMessage: String = ""
        @State private var isCorrect: Bool = false
        @State private var currentIndex: Int = 0
        @State private var quizCompleted: Bool = false // Track if quiz is completed

        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("History Facts")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text(historyFacts[currentIndex].statement)
                    .font(.headline)
                    .padding(.horizontal)

                ForEach(historyFacts[currentIndex].options, id: \.self) { option in
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

                HStack{
                    Spacer()
                    Button("Next Question") {
                        goToNextQuestion()
                    }
                    .padding()
                    .disabled(!showFeedback || quizCompleted) // Disable until feedback is shown or quiz is completed
                    Spacer()
                }
                
            }
            .padding()
            .navigationTitle("History Facts Quiz")
            .navigationBarTitleDisplayMode(.inline)
            //.navigationBarBackButtonHidden(true)
        }

        private func checkAnswer(selected: String) {
            selectedAnswer = selected
            let currentFact = historyFacts[currentIndex]
            
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
            if currentIndex < historyFacts.count - 1 {
                currentIndex += 1
                resetQuestion()
            } else {
                feedbackMessage = "Quiz completed!"
                quizCompleted = true
            }
        }

        private func resetQuestion() {
            selectedAnswer = nil
            showFeedback = false
            feedbackMessage = ""
        }
    }

    #Preview {
        HistoryFactsView()
    }
