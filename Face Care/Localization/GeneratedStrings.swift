//// swiftlint:disable all
//// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
//
//import Foundation
//
//// swiftlint:disable superfluous_disable_command file_length implicit_return
//
//// MARK: - Strings
//
//// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
//// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
//internal enum L {
//
//  internal enum Alert {
//    internal enum Action {
//      /// Отменить
//      internal static let cancel = L.tr("Localizable", "alert.action.cancel")
//      /// Ок
//      internal static let ok = L.tr("Localizable", "alert.action.ok")
//      /// Да
//      internal static let yes = L.tr("Localizable", "alert.action.yes")
//    }
//    internal enum Connection {
//      /// Нет подключения к интернету.  Пожалуйста, подключитесь к сети и попробуйте еще раз.
//      internal static let message = L.tr("Localizable", "alert.connection.message")
//      /// Нет подключения к интернету
//      internal static let title = L.tr("Localizable", "alert.connection.title")
//    }
//    internal enum NotSubscriber {
//      /// К сожалению, вы не можете восстановить свою покупку, потому что у вас нет активной подписки.
//      internal static let message = L.tr("Localizable", "alert.notSubscriber.message")
//      /// Не подлежит восстановлению
//      internal static let title = L.tr("Localizable", "alert.notSubscriber.title")
//    }
//    internal enum Restored {
//      /// Вы успешно восстановили подписку. Теперь вам доступен весь функционал.
//      internal static let message = L.tr("Localizable", "alert.restored.message")
//      /// Восстановлен
//      internal static let title = L.tr("Localizable", "alert.restored.title")
//    }
//    internal enum Subscribed {
//      /// Вы уже подписаны. Вам доступен весь функционал.
//      internal static let message = L.tr("Localizable", "alert.subscribed.message")
//      /// Подписка оформлена
//      internal static let title = L.tr("Localizable", "alert.subscribed.title")
//    }
//    internal enum Training {
//      /// Вы уверены, что хотите выйти?
//      internal static let title = L.tr("Localizable", "alert.training.title")
//    }
//  }
//
//  internal enum Atricles {
//    /// Полезные статьи
//    internal static let title = L.tr("Localizable", "atricles.title")
//  }
//
//  internal enum FacePart {
//    /// Cheekbones and cheeks
//    internal static let cheekbonesAndCheeks = L.tr("Localizable", "facePart.cheekbonesAndCheeks")
//    /// Chin
//    internal static let chin = L.tr("Localizable", "facePart.chin")
//    /// Eyes
//    internal static let eyes = L.tr("Localizable", "facePart.eyes")
//    /// Forehead
//    internal static let forehead = L.tr("Localizable", "facePart.forehead")
//    /// Neck
//    internal static let neck = L.tr("Localizable", "facePart.neck")
//  }
//
//  internal enum Home {
//    /// День
//    internal static let day = L.tr("Localizable", "home.day")
//    /// Эксклюзивные тренировки
//    internal static let exclusiveTrainings = L.tr("Localizable", "home.exclusiveTrainings")
//    /// Список упражнений
//    internal static let exercisesList = L.tr("Localizable", "home.exercisesList")
//    /// Рекоммендуется на сегодня
//    internal static let title = L.tr("Localizable", "home.title")
//    internal enum Duration {
//      internal enum Minutes {
//        /// минут
//        internal static let five = L.tr("Localizable", "home.duration.minutes.five")
//        /// минута
//        internal static let one = L.tr("Localizable", "home.duration.minutes.one")
//        /// минуты
//        internal static let two = L.tr("Localizable", "home.duration.minutes.two")
//      }
//    }
//  }
//
//  internal enum Onboarding {
//    /// Загрузить фото
//    internal static let loadImage = L.tr("Localizable", "onboarding.loadImage")
//    /// Получить персональный курс
//    internal static let personalPlan = L.tr("Localizable", "onboarding.personalPlan")
//    internal enum Features {
//      /// Чистая кожа
//      internal static let first = L.tr("Localizable", "onboarding.features.first")
//      /// Здоровый цвет лица
//      internal static let second = L.tr("Localizable", "onboarding.features.second")
//      /// Заряд энергии на целый день
//      internal static let third = L.tr("Localizable", "onboarding.features.third")
//    }
//    internal enum OnboardingButton {
//      /// Продолжить
//      internal static let `continue` = L.tr("Localizable", "onboarding.onboardingButton.continue")
//      /// Да, но только в области глаз
//      internal static let eyesWrinkles = L.tr("Localizable", "onboarding.onboardingButton.eyesWrinkles")
//      /// Нет
//      internal static let no = L.tr("Localizable", "onboarding.onboardingButton.no")
//      /// Начать
//      internal static let start = L.tr("Localizable", "onboarding.onboardingButton.start")
//      /// Да
//      internal static let yes = L.tr("Localizable", "onboarding.onboardingButton.yes")
//      internal enum Sleep {
//        /// Больше 8 часов
//        internal static let long = L.tr("Localizable", "onboarding.onboardingButton.sleep.long")
//        /// 7-8 часов
//        internal static let normal = L.tr("Localizable", "onboarding.onboardingButton.sleep.normal")
//        /// Меньше 7 часов
//        internal static let short = L.tr("Localizable", "onboarding.onboardingButton.sleep.short")
//      }
//    }
//    internal enum Screen {
//      internal enum Title {
//        /// Как тебя зовут?
//        internal static let eighth = L.tr("Localizable", "onboarding.screen.title.eighth")
//        /// Заметны ли морщинки на лице когда ты улибаешся или смеёшься?
//        internal static let fifth = L.tr("Localizable", "onboarding.screen.title.fifth")
//        /// Ты хочешь выглядель моложе?
//        internal static let first = L.tr("Localizable", "onboarding.screen.title.first")
//        /// На какой области лица ты хотел(а) бы сосредоточится?
//        internal static let fourth = L.tr("Localizable", "onboarding.screen.title.fourth")
//        /// Сколько тебе лет?
//        internal static let ninth = L.tr("Localizable", "onboarding.screen.title.ninth")
//        /// Ты хочешь, чтобы лицо выглядело более подтянутым?
//        internal static let second = L.tr("Localizable", "onboarding.screen.title.second")
//        /// Сколько часов обычно длится твой сон?
//        internal static let seventh = L.tr("Localizable", "onboarding.screen.title.seventh")
//        /// Заметны ли морщинки на твоём лице, когда оно расслаблено?
//        internal static let sixth = L.tr("Localizable", "onboarding.screen.title.sixth")
//        /// Какой у тебя тип кожи?
//        internal static let third = L.tr("Localizable", "onboarding.screen.title.third")
//      }
//    }
//    internal enum SkinType {
//      /// Комбинировання
//      internal static let combined = L.tr("Localizable", "onboarding.skinType.combined")
//      /// Сухая
//      internal static let dry = L.tr("Localizable", "onboarding.skinType.dry")
//      /// Жирная
//      internal static let fat = L.tr("Localizable", "onboarding.skinType.fat")
//      /// Нормальная
//      internal static let normal = L.tr("Localizable", "onboarding.skinType.normal")
//    }
//    internal enum Start {
//      /// Курс Face Care - это ваш путь к естественной красоте и молодости
//      internal static let description = L.tr("Localizable", "onboarding.start.description")
//      /// Добро пожаловать в
//      internal static let welcome = L.tr("Localizable", "onboarding.start.welcome")
//    }
//  }
//
//  internal enum PlanGeneration {
//    /// Анализ проблемных зон
//    internal static let first = L.tr("Localizable", "planGeneration.first")
//    /// Анализ состояния кожи
//    internal static let second = L.tr("Localizable", "planGeneration.second")
//    /// Подбор упражнений для лица согласно твоим потребностям
//    internal static let third = L.tr("Localizable", "planGeneration.third")
//    /// Подготовка персонально плана тренировок
//    internal static let title = L.tr("Localizable", "planGeneration.title")
//  }
//
//  internal enum Progress {
//    /// Добавить фото
//    internal static let addImage = L.tr("Localizable", "progress.addImage")
//    /// Смотрите демонстрацию
//    internal static let demonstration = L.tr("Localizable", "progress.demonstration")
//    /// Галерея прогресса
//    internal static let gallery = L.tr("Localizable", "progress.gallery")
//    /// Ежедневная цель
//    internal static let goal = L.tr("Localizable", "progress.goal")
//    /// Для достижения нилучший результатов, выполняйте упражнения каждый день.
//    internal static let subtitle = L.tr("Localizable", "progress.subtitle")
//    /// Мой прогресс
//    internal static let title = L.tr("Localizable", "progress.title")
//    internal enum Settings {
//      /// Проблемные зоны
//      internal static let problemAreas = L.tr("Localizable", "progress.settings.problemAreas")
//      /// Вы можете обнулить пройденые дни, историю и настройки персонального курса и начать снова
//      internal static let resetDescription = L.tr("Localizable", "progress.settings.resetDescription")
//      /// Настройки прогресса
//      internal static let title = L.tr("Localizable", "progress.settings.title")
//      internal enum ProgressButton {
//        /// Обнулить прогресс
//        internal static let resetProgress = L.tr("Localizable", "progress.settings.progressButton.resetProgress")
//      }
//    }
//  }
//
//  internal enum Settings {
//    /// Связяться с нами
//    internal static let contact = L.tr("Localizable", "settings.contact")
//    /// Восстановить покупки
//    internal static let restore = L.tr("Localizable", "settings.restore")
//    /// Настройки
//    internal static let title = L.tr("Localizable", "settings.title")
//    internal enum Language {
//      /// Английский
//      internal static let english = L.tr("Localizable", "settings.language.english")
//      /// Франзузский
//      internal static let french = L.tr("Localizable", "settings.language.french")
//      /// Немецкий
//      internal static let german = L.tr("Localizable", "settings.language.german")
//      /// Итальянский
//      internal static let italian = L.tr("Localizable", "settings.language.italian")
//      /// Русский
//      internal static let russian = L.tr("Localizable", "settings.language.russian")
//      /// Испанский
//      internal static let spanish = L.tr("Localizable", "settings.language.spanish")
//      /// Язык
//      internal static let title = L.tr("Localizable", "settings.language.title")
//    }
//  }
//
//  internal enum Subscription {
//    /// Информация о плане
//    internal static let planInfo = L.tr("Localizable", "subscription.planInfo")
//    /// Политика конфеденциальности
//    internal static let privacy = L.tr("Localizable", "subscription.privacy")
//    /// Правила пользования
//    internal static let termsOfUse = L.tr("Localizable", "subscription.termsOfUse")
//    internal enum Interval {
//      internal enum Day {
//        /// дней
//        internal static let five = L.tr("Localizable", "subscription.interval.day.five")
//        /// день
//        internal static let one = L.tr("Localizable", "subscription.interval.day.one")
//        /// дня
//        internal static let two = L.tr("Localizable", "subscription.interval.day.two")
//      }
//      internal enum Month {
//        /// месяцев
//        internal static let five = L.tr("Localizable", "subscription.interval.month.five")
//        /// месяц
//        internal static let one = L.tr("Localizable", "subscription.interval.month.one")
//        /// месяца
//        internal static let two = L.tr("Localizable", "subscription.interval.month.two")
//      }
//      internal enum Week {
//        /// недель
//        internal static let five = L.tr("Localizable", "subscription.interval.week.five")
//        /// неделя
//        internal static let one = L.tr("Localizable", "subscription.interval.week.one")
//        /// недели
//        internal static let two = L.tr("Localizable", "subscription.interval.week.two")
//      }
//      internal enum Year {
//        /// лет
//        internal static let five = L.tr("Localizable", "subscription.interval.year.five")
//        /// год
//        internal static let one = L.tr("Localizable", "subscription.interval.year.one")
//        /// года
//        internal static let two = L.tr("Localizable", "subscription.interval.year.two")
//      }
//    }
//  }
//
//  internal enum Training {
//    /// Тренировка заверешена
//    internal static let completed = L.tr("Localizable", "training.completed")
//    /// Начать тренировку
//    internal static let start = L.tr("Localizable", "training.start")
//    /// Сделать фото
//    internal static let takeImage = L.tr("Localizable", "training.takeImage")
//  }
//}
//// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
//// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces
//
//// MARK: - Implementation Details
//
//extension L {
//    private static func tr(_ table: String = "Localizable", _ key: String, _ args: CVarArg...) -> String {
//        print("Working")
//        let path = Bundle.main.path(forResource: State.shared.getLanguage().rawValue, ofType: "lproj")
//        let bundle = Bundle(path: path!) ?? Bundle.main
//        let format = bundle.localizedString(forKey: key, value: nil, table: table)
//        return String(format: format, arguments: args)
//    }
//}
//
//// swiftlint:disable convenience_type
//private final class BundleToken {
//    static let bundle: Bundle = {
//        let path = Bundle.main.path(forResource: State.shared.getLanguage().rawValue, ofType: "lproj")
//        return Bundle(path: path!) ?? Bundle.main
//    }()
//}
//// swiftlint:enable convenience_type
