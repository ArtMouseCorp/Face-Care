import Foundation

struct Exercise: Codable {
    
    let name: String
    let description: String
    let videoUrl: String
 
    public func getVideoURL() -> URL? {
        guard let url = URL(string: self.videoUrl) else { return nil }
        return url
    }
    
    public static let examples: [Exercise] = [
    
        Exercise(
            name: "Гимнастика для глаз",
            description: "Чтобы снять напряжение и усталость с глаз, посмотрите попеременно то в одну, то в другую сторону. Двигайтесь сверху вниз. Голову при этом поворачивать не надо, двигаются только глазные яблоки.",
            videoUrl: "https://disk.yandex.ru/d/27blP34bDtwXAw/%D0%A4%D0%B0%D0%B8%CC%86%D0%BB%201/%D0%93%D0%B8%D0%BC%D0%BD%D0%B0%D1%81%D1%82%D0%B8%D0%BA%D0%B0%20%D0%B4%D0%BB%D1%8F%20%D0%B3%D0%BB%D0%B0%D0%B7.mp4"
        ),
        Exercise(
            name: "Упражнение для шеи",
            description: "Делайте повороты головы влево — вправо. Это простое упражнение - отличная растяжка для шеи, улучшающая кровоснабжение головы и укрепляющая мышцы.",
            videoUrl: "https://disk.yandex.ru/d/27blP34bDtwXAw/%D0%A4%D0%B0%D0%B8%CC%86%D0%BB%201/%D0%A3%D0%BF%D1%80%D0%B0%D0%B6%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5%20%D0%B4%D0%BB%D1%8F%20%D1%88%D0%B5%D0%B8.mp4"
        ),
        Exercise(
            name: "От головной боли",
            description: "Разместите подушечки пальцев в области под бровями. Медленно наклоните голову вниз, создавая противодействие лба и пальцев. В конце рабочего дня такое упражнение поможет снять напряжение в зоне лба и вокруг глаз.",
            videoUrl: "https://disk.yandex.ru/d/27blP34bDtwXAw/%D0%A4%D0%B0%D0%B8%CC%86%D0%BB%201/%D0%9E%D1%82%20%D0%B3%D0%BE%D0%BB%D0%BE%D0%B2%D0%BD%D0%BE%D0%B8%CC%86%20%D0%B1%D0%BE%D0%BB%D0%B8.mp4"
        ),
        Exercise(
            name: "Лифтинг бровей",
            description: "Прижмите подушечки больших пальце к вискам. Боковой поверхностью указательных пальцев двигайтесь от области межбровья к \"хвостикам\" бровей. Упражнение уменьшает межбровные морщины и снимает напряжение в конце рабочего дня.",
            videoUrl: "https://disk.yandex.ru/d/27blP34bDtwXAw/%D0%A4%D0%B0%D0%B8%CC%86%D0%BB%201/%D0%9B%D0%B8%D1%84%D1%82%D0%B8%D0%BD%D0%B3%20%D0%B1%D1%80%D0%BE%D0%B2%D0%B5%D0%B8%CC%86.mp4"
        )
        
    ]
    
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
