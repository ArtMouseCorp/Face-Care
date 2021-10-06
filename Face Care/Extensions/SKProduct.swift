import Foundation
import StoreKit

extension SKProduct {
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var isFree: Bool {
        price == 0.00
    }
    
    var localizedPrice: String? {
        guard !isFree else {
            return nil
        }
        
        let formatter = SKProduct.formatter
        formatter.locale = priceLocale
        
        return formatter.string(from: price)
    }
    
    func getSubscriptionPeriod(showOne: Bool = false) -> String {
        
        let perdiod = self.subscriptionPeriod
        let numberOfUnits = perdiod?.numberOfUnits ?? 0
        
        var unit = ""
        
        switch perdiod!.unit {
            
        case .day:
            let oneDay = L.Subscription.Interval.Day.one
            let twoDays = L.Subscription.Interval.Day.two
            let fiveDays = L.Subscription.Interval.Day.five
            
            unit = getNoun(number: numberOfUnits, one: oneDay, two: twoDays, five: fiveDays)
        case .week:
            let oneWeek = L.Subscription.Interval.Week.one
            let twoWeeks = L.Subscription.Interval.Week.two
            let fiveWeeks = L.Subscription.Interval.Week.five
            
            unit = getNoun(number: numberOfUnits, one: oneWeek, two: twoWeeks, five: fiveWeeks)
        case .month:
            let oneMonth = L.Subscription.Interval.Month.one
            let twoMonths = L.Subscription.Interval.Month.two
            let fiveMonths = L.Subscription.Interval.Month.five
            
            unit = getNoun(number: numberOfUnits, one: oneMonth, two: twoMonths, five: fiveMonths)
        case .year:
            let oneYear = L.Subscription.Interval.Year.one
            let twoYears = L.Subscription.Interval.Year.two
            let fiveYears = L.Subscription.Interval.Year.five
            
            unit = getNoun(number: numberOfUnits, one: oneYear, two: twoYears, five: fiveYears)
        @unknown default:
            unit = "N/A"
        }
        
        if showOne {
            return L.get(key: unit, args: numberOfUnits)
        } else {
            return numberOfUnits > 1 ? L.get(key: unit, args: numberOfUnits) : L.get(key: unit)
        }
    }
    
    func getTrialPeriod() -> String? {
        
        let perdiod = self.introductoryPrice?.subscriptionPeriod
        let numberOfUnits = perdiod?.numberOfUnits ?? 0
        
        var unit = ""
        
        switch perdiod?.unit {
            
        case .day:
            let oneDay = L.Subscription.Interval.Day.one
            let twoDays = L.Subscription.Interval.Day.two
            let fiveDays = L.Subscription.Interval.Day.five
            
            unit = getNoun(number: numberOfUnits, one: oneDay, two: twoDays, five: fiveDays)
        case .week:
            let oneWeek = L.Subscription.Interval.Week.one
            let twoWeeks = L.Subscription.Interval.Week.two
            let fiveWeeks = L.Subscription.Interval.Week.five
            
            unit = getNoun(number: numberOfUnits, one: oneWeek, two: twoWeeks, five: fiveWeeks)
        case .month:
            let oneMonth = L.Subscription.Interval.Month.one
            let twoMonths = L.Subscription.Interval.Month.two
            let fiveMonths = L.Subscription.Interval.Month.five
            
            unit = getNoun(number: numberOfUnits, one: oneMonth, two: twoMonths, five: fiveMonths)
        case .year:
            let oneYear = L.Subscription.Interval.Year.one
            let twoYears = L.Subscription.Interval.Year.two
            let fiveYears = L.Subscription.Interval.Year.five
            
            unit = getNoun(number: numberOfUnits, one: oneYear, two: twoYears, five: fiveYears)
        case .none:
            return nil
        @unknown default:
            unit = "N/A"
        }
        
        return "\(numberOfUnits) " + unit.uppercased()
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
