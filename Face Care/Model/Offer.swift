import Foundation

struct Offer: Codable {
    let lang: Language.Code
    let trialTitle: String
    let button: String
    let trialPurchaseId: String
    let notTrialPurchaseId: String
    let comment: String
    let view: Bool
    
    public static let defaultOffer = Offer(lang: .en, trialTitle: "", button: L.get(key: L.Onboarding.OnboardingButton.continue), trialPurchaseId: "fy_1m_3d", notTrialPurchaseId: "fy_1w", comment: "I've been doing it for 3 months, I've been following the recommendations, and the effect is just WOW! This app is a diamond!", view: true)
    
    
    public static func get(completion: (() -> ())? = nil) {
        
        
        loadFromUrl { error in
            
            if let error = error {
                
                print("-------------------------")
                print("Error from url decoding of subscription config:")
                print(error)
                print(error.localizedDescription)
                print("-------------------------")
                
                loadFromJson {
                    completion?() ?? ()
                }
                
                return
            }
            
            completion?() ?? ()
            
        }
        
    }
    
    private static func loadFromUrl(completion: @escaping (Error?) -> ()) {
        
        let urlString = Config.offerURL
        guard let url = URL(string: urlString) else { fatalError() }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(error)
                return
            }

            do {
                let offers = try JSONDecoder().decode([Offer].self, from: data)
                
                offers.forEach { offer in
                    if offer.lang == State.shared.getLanguage() {
                        State.shared.setOffer(to: offer)
                        completion(nil)
                        print("Subsctiption config loaded from url")
                    }
                }
                
            } catch {
                completion(error)
            }

        }.resume()
        
    }
    
    private static func loadFromJson(completion: (() -> ())) {
        
        guard let jsonData = readLocalJSONFile(forName: "offerScreen") else {
            print("-------------------------")
            print("Error from json decoding of subscription config:")
            print("No such file found: offerScreen.json")
            print("-------------------------")
            return
        }
        do {
            let offers = try JSONDecoder().decode([Offer].self, from: jsonData)
            
            offers.forEach { offer in
                if offer.lang == State.shared.getLanguage() {
                    State.shared.setOffer(to: offer)
                    completion()
                    print("Subsctiption config loaded from json file")
                }
            }
            
        } catch {
            print("-------------------------")
            print("Error from json decoding of subscription config:")
            print(error)
            print(error.localizedDescription)
            print("-------------------------")
        }
    }
    
}
