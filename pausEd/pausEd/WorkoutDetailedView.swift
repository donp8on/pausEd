//
//  WorkoutDetailedView.swift
//  pausEd
//
//  Created by Don Payton on 11/6/24.
//

import SwiftUI

struct WorkoutDetailedView: View {
    let exercise: Exercise
    @State private var completedSteps: [Bool]
    
    init(exercise: Exercise) {
        self.exercise = exercise
        _completedSteps = State(initialValue: Array(repeating: false, count: exercise.steps.count))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Exercise Image
            HStack{
                Spacer()
                Image(exercise.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
                Spacer()
            }
            
            
            // Exercise Name
            Text(exercise.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Exercise Description
            Text(exercise.description)
                .font(.body)
                .foregroundColor(.gray)
            
            // Steps
            Text("Steps:")
                .font(.title2)
                .fontWeight(.semibold)
            
            // Checklist for steps
            ForEach(exercise.steps.indices, id: \.self) { index in
                Button(action: {
                    completedSteps[index].toggle()
                }) {
                    HStack {
                        Image(systemName: completedSteps[index] ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(completedSteps[index] ? .green : .gray)
                        Text(exercise.steps[index])
                            .foregroundColor(completedSteps[index] ? .green : .primary)
                    }
                    .padding(.vertical, 5)
                }
                .buttonStyle(PlainButtonStyle())             }
            
            Spacer()
        }
        .padding()
        .navigationTitle(exercise.name)
        //.navigationBarBackButtonHidden(true)
    }
}

struct WorkoutDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        // Example Workout instance for preview
        let sampleWorkout = Exercise(name: "Sample Workout", description: "Sample description", steps: ["Step 1", "Step 2", "Step 3"], imageName: "sample_image")
        WorkoutDetailedView(exercise: sampleWorkout)
    }
}
