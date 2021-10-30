import Foundation

extension Training {
    
    struct Daily: Codable {
        
        private static let MAX_EXERCISES = 8
        
        let dayNumber: Int
        let training: Training
        
        public static var trainings: [Daily] = []
        
        // MARK: - Object functions
        
        public func isOpen() -> Bool {
            
            if self.dayNumber == State.shared.getOpenedDailyTrainingNumber() {
                return isNextTrainingShouldBeOpen()
            }
            
            return self.dayNumber < State.shared.getOpenedDailyTrainingNumber()
            
        }
        
        // MARK: - Static functions
        
        public static func completeTraining() {
            
            let openedTrainingNumber = State.shared.getOpenedDailyTrainingNumber()
            
            // open next training
            State.shared.setOpenedDailyTrainingNumber(to: openedTrainingNumber + 1)
            State.shared.setCompletedDailyTrainingDate(to: Date())
            
        }
        
        public static func createTrainings() {
            
            trainings.removeAll()
            
            parseDailyData { faceAreaDailyData in
                
                let faceAreaDailyData = faceAreaDailyData.filter { State.shared.getProblemAreas().contains($0.faceAreaId) }
                let exercisesCount = Int(MAX_EXERCISES / faceAreaDailyData.count)
                
                for i in 0 ..< 7 {
                    
                    var exercises: [Exercise] = []
                    var trainingDuration: Int = 0
                    
                    for faceAreaTraining in faceAreaDailyData {
                        
                        var exercisesIds: [Int] = []
                        
                        if exercisesCount > faceAreaTraining.days[i].count {
                            exercisesIds = faceAreaTraining.days[i].random(elements: faceAreaTraining.days[i].count)
                        } else {
                            exercisesIds = faceAreaTraining.days[i].random(elements: exercisesCount)
                        }
                     
                        
                        if let faceArea = FaceArea.all.first(where: {$0.id == faceAreaTraining.faceAreaId} ) {
                            
                            faceArea.exercises.filter({exercisesIds.contains($0.id)}).forEach({
                                exercises.append($0)
                                trainingDuration += $0.duration
                            })
                            
                        }
                        
                    }
                    
                    let training = Training(
                        name: "Day \(i + 1) training",
                        description: "Day \(i + 1) training description",
                        duration: Int(trainingDuration / 60),
                        exercises: exercises
                    )
                    let dailyTraining = Daily(dayNumber: i + 1, training: training)
                    trainings.append(dailyTraining)
                    
                }
                
                saveToJson()
                
                var yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
                var components = Calendar.current.dateComponents([.year, .month, .day], from: yesterday)
                components.timeZone = TimeZone(secondsFromGMT: 0)
                yesterday = Calendar.current.date(from: components) ?? yesterday
                
                State.shared.setCompletedDailyTrainingDate(to: yesterday)
                State.shared.setOpenedDailyTrainingNumber(to: 1)
                
            }
            
        }
        
        public static func saveToJson() {
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted

            do {
                let jsonData = try encoder.encode(trainings)

                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    
                    let filename = getDocumentsDirectory().appendingPathComponent("userTrainings.json")
                    do {
                        try jsonString.write(to: filename, atomically: true, encoding: .utf8)
                        print("User trainings successfully saved to \(filename)")
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
            
            let filename = getDocumentsDirectory().appendingPathComponent("userTrainings.json")
            
            do {
                let jsonData = try Data(contentsOf: filename)
                
                print("Loaded from \(filename)")

                let decoder = JSONDecoder()

                let dailyTrainings = try decoder.decode([Training.Daily].self, from: jsonData)
                self.trainings = dailyTrainings
                self.localizeTrainings()
                
            } catch {
                print("error: \(error.localizedDescription)")
            }
            
            
        }
        
        public static func localizeTrainings() {
            
            let allExercises = FaceArea.getAllExercises()
            
            for training in trainings {
                
                for exercise in training.training.exercises {

                    if let localizedExercise = allExercises.first(where: { $0.id == exercise.id }) {
                        exercise.localize(from: localizedExercise)
                    }

                }
                
            }
            
        }
        
        private static func parseDailyData(completion: (([FaceAreaDailyData]) -> ())) {
            
            var faceAreaDailyDataArray: [FaceAreaDailyData] = []

            guard let jsonData = readLocalJSONFile(forName: "dailyTrainings") else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(Daily.Response.self, from: jsonData)
                faceAreaDailyDataArray = decodedData.facaAreaDailyTrainings
                completion(faceAreaDailyDataArray)
            } catch {
                print("Error: ", error)
            }
            
        }
        
        
        
    }
    
}

extension Training.Daily {
    
    private struct Response: Codable {
        let facaAreaDailyTrainings: [FaceAreaDailyData]
    }
    
    private struct FaceAreaDailyData: Codable {
        let faceAreaId: Int
        let days: [[Int]]
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
