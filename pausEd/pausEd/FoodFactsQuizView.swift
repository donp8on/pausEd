//
//  FoodFactsQuizView.swift
//  pausEd
//
//  Created by Don Payton on 11/12/24.
//
import SwiftUI

struct FoodFact {
    let question: String
    let choices: [String]
    let correctAnswer: String
    let explanation: String
}

struct FoodFactsQuizView: View {
    let foodFacts = [
        FoodFact(
            question: "Which fruit is known for having high vitamin C content?",
            choices: ["Banana", "Apple", "Orange", "Grapes"],
            correctAnswer: "Orange",
            explanation: "Oranges are rich in vitamin C, which helps boost the immune system."
        ),
        FoodFact(
            question: "What type of food is tofu?",
            choices: ["Fruit", "Vegetable", "Dairy", "Soy-based protein"],
            correctAnswer: "Soy-based protein",
            explanation: "Tofu is made from soybeans and is a popular plant-based protein source."
        ),
        FoodFact(
            question: "Which grain is typically used to make pasta?",
            choices: ["Rice", "Wheat", "Barley", "Oats"],
            correctAnswer: "Wheat",
            explanation: "Most pasta is made from wheat flour, which gives it its characteristic texture."
        ),
        FoodFact(
            question: "Which of these is a type of berry?",
            choices: ["Strawberry", "Raspberry", "Tomato", "Cucumber"],
            correctAnswer: "Raspberry",
            explanation: "Raspberries are a true berry, unlike strawberries which are aggregate fruits."
        ),
        FoodFact(
            question: "Which vegetable is often used to make guacamole?",
            choices: ["Tomato", "Avocado", "Cucumber", "Lettuce"],
            correctAnswer: "Avocado",
            explanation: "Avocados are mashed to make the creamy base of guacamole."
        ),
        FoodFact(
            question: "Which of these is not a type of cheese?",
            choices: ["Cheddar", "Brie", "Gouda", "Peanut Butter"],
            correctAnswer: "Peanut Butter",
            explanation: "Peanut butter is made from peanuts, not milk, so it's not a type of cheese."
        ),
        FoodFact(
            question: "What is sushi traditionally made with?",
            choices: ["Rice", "Bread", "Pasta", "Lettuce"],
            correctAnswer: "Rice",
            explanation: "Sushi is made with vinegared rice and typically paired with fish or vegetables."
        ),
        FoodFact(
            question: "Which fruit is commonly used in making guacamole?",
            choices: ["Banana", "Peach", "Avocado", "Orange"],
            correctAnswer: "Avocado",
            explanation: "Avocados are used to make guacamole, a popular dip in Mexican cuisine."
        ),
        FoodFact(
            question: "What is hummus primarily made of?",
            choices: ["Tomatoes", "Chickpeas", "Potatoes", "Carrots"],
            correctAnswer: "Chickpeas",
            explanation: "Hummus is made from blended chickpeas, tahini, olive oil, and spices."
        ),
        FoodFact(
            question: "What is the main ingredient in a traditional Caesar salad?",
            choices: ["Tomatoes", "Lettuce", "Spinach", "Cabbage"],
            correctAnswer: "Lettuce",
            explanation: "Caesar salad is made with romaine lettuce, croutons, and Caesar dressing."
        ),
    ]
    
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var showCorrectMessage = false
    @State private var showExplanation = false
    @State private var quizCompleted = false // Track if quiz is completed
    
    var body: some View {
        VStack(spacing: 20) {
            Text(foodFacts[currentQuestionIndex].question)
                .font(.title)
                .padding()
            
            ForEach(foodFacts[currentQuestionIndex].choices, id: \.self) { choice in
                Button(action: {
                    selectedAnswer = choice
                    if choice == foodFacts[currentQuestionIndex].correctAnswer {
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
                                ? (choice == foodFacts[currentQuestionIndex].correctAnswer ? Color.green.opacity(0.7) : Color.red.opacity(0.7))
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
                Text(foodFacts[currentQuestionIndex].explanation)
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
        .navigationTitle("Food Quiz")
        //.navigationBarBackButtonHidden(true)
    }
    
    private func nextQuestion() {
        if currentQuestionIndex < foodFacts.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showExplanation = false
        } else {
            quizCompleted = true
        }
    }
}

struct FoodFactsQuizView_Previews: PreviewProvider {
    static var previews: some View {
        FoodFactsQuizView()
    }
}
