import Foundation

extension Training {
    
    struct Exclusive {
        
        public static var trainings: [Training] = []
        
        public static func createTrainings() {
            
            trainings.removeAll()
            
            for faceArea in FaceArea.all {
                
                if let exercise = faceArea.exercises.randomElement() {
                    
                    let training = Training(name: exercise.name, description: exercise.description, duration: exercise.duration, exercises: [exercise])
                    
                    trainings.append(training)
                    
                }
                
            }
            
            saveToJson()
            
        }
        
        public static func localizeTrainings() {
            
            let allExercises = FaceArea.getAllExercises()
            
            for training in trainings {
                
                for exercise in training.exercises {
                    
                    if let localizedExercise = allExercises.first(where: { $0.id == exercise.id }) {
                        exercise.localize(from: localizedExercise)
                        training.name = localizedExercise.name
                        training.description = localizedExercise.description
                    }
                    
                }
                
            }
            
        }
        
        public static func saveToJson() {
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            do {
                let jsonData = try encoder.encode(trainings)
                
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    
                    let filename = getDocumentsDirectory().appendingPathComponent("exclusiveTrainings.json")
                    do {
                        try jsonString.write(to: filename, atomically: true, encoding: .utf8)
                        print("Exclusive trainings successfully saved to \(filename)")
                    } catch {
                        // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
                        print("Failed writing to URL: \(filename), Error: " + error.localizedDescription)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        public static func loadFromJson() {
            
            let filename = getDocumentsDirectory().appendingPathComponent("exclusiveTrainings.json")
            
            do {
                let jsonData = try Data(contentsOf: filename)
                
                print("Loaded from \(filename)")
                
                let decoder = JSONDecoder()
                
                let exclusiveTrainings = try decoder.decode([Training].self, from: jsonData)
                self.trainings = exclusiveTrainings
                self.localizeTrainings()
                
            } catch {
                print("error: \(error.localizedDescription)")
            }
            
            
        }
        
    }
    
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
