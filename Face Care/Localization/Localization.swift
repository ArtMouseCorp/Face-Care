import Foundation

internal enum L {

  internal enum Alert {
    internal enum Action {
      /// Отменить
      internal static let cancel = "alert.action.cancel"
      /// Ок
      internal static let ok = "alert.action.ok"
      /// Да
      internal static let yes = "alert.action.yes"
    }
    internal enum Connection {
      /// Нет подключения к интернету.  Пожалуйста, подключитесь к сети и попробуйте еще раз.
      internal static let message = "alert.connection.message"
      /// Нет подключения к интернету
      internal static let title = "alert.connection.title"
    }
    internal enum NotSubscriber {
      /// К сожалению, вы не можете восстановить свою покупку, потому что у вас нет активной подписки.
      internal static let message = "alert.notSubscriber.message"
      /// Не подлежит восстановлению
      internal static let title = "alert.notSubscriber.title"
    }
    internal enum Restored {
      /// Вы успешно восстановили подписку. Теперь вам доступен весь функционал.
      internal static let message = "alert.restored.message"
      /// Восстановлен
      internal static let title = "alert.restored.title"
    }
    internal enum Subscribed {
      /// Вы уже подписаны. Вам доступен весь функционал.
      internal static let message = "alert.subscribed.message"
      /// Подписка оформлена
      internal static let title = "alert.subscribed.title"
    }
    internal enum Training {
      /// Вы уверены, что хотите выйти?
      internal static let title = "alert.training.title"
    }
  }

  internal enum Atricles {
    /// Полезные статьи
    internal static let title = "atricles.title"
  }

  internal enum FacePart {
    /// Cheekbones and cheeks
    internal static let cheekbonesAndCheeks = "facePart.cheekbonesAndCheeks"
    /// Chin
    internal static let chin = "facePart.chin"
    /// Eyes
    internal static let eyes = "facePart.eyes"
    /// Forehead
    internal static let forehead = "facePart.forehead"
    /// Neck
    internal static let neck = "facePart.neck"
  }

  internal enum Home {
    /// День
    internal static let day = "home.day"
    /// Эксклюзивные тренировки
    internal static let exclusiveTrainings = "home.exclusiveTrainings"
    /// Список упражнений
    internal static let exercisesList = "home.exercisesList"
    /// Рекоммендуется на сегодня
    internal static let title = "home.title"
    internal enum Duration {
      internal enum Minutes {
        /// минут
        internal static let five = "home.duration.minutes.five"
        /// минута
        internal static let one = "home.duration.minutes.one"
        /// минуты
        internal static let two = "home.duration.minutes.two"
      }
    }
  }

  internal enum Onboarding {
    /// Загрузить фото
    internal static let loadImage = "onboarding.loadImage"
    /// Получить персональный курс
    internal static let personalPlan = "onboarding.personalPlan"
    internal enum Features {
      /// Чистая кожа
      internal static let first = "onboarding.features.first"
      /// Здоровый цвет лица
      internal static let second = "onboarding.features.second"
      /// Заряд энергии на целый день
      internal static let third = "onboarding.features.third"
    }
    internal enum OnboardingButton {
      /// Продолжить
      internal static let `continue` = "onboarding.onboardingButton.continue"
      /// Да, но только в области глаз
      internal static let eyesWrinkles = "onboarding.onboardingButton.eyesWrinkles"
      /// Нет
      internal static let no = "onboarding.onboardingButton.no"
      /// Начать
      internal static let start = "onboarding.onboardingButton.start"
      /// Да
      internal static let yes = "onboarding.onboardingButton.yes"
      internal enum Sleep {
        /// Больше 8 часов
        internal static let long = "onboarding.onboardingButton.sleep.long"
        /// 7-8 часов
        internal static let normal = "onboarding.onboardingButton.sleep.normal"
        /// Меньше 7 часов
        internal static let short = "onboarding.onboardingButton.sleep.short"
      }
    }
    internal enum Screen {
      internal enum Title {
        /// Как тебя зовут?
        internal static let eighth = "onboarding.screen.title.eighth"
        /// Заметны ли морщинки на лице когда ты улибаешся или смеёшься?
        internal static let fifth = "onboarding.screen.title.fifth"
        /// Ты хочешь выглядель моложе?
        internal static let first = "onboarding.screen.title.first"
        /// На какой области лица ты хотел(а бы сосредоточится?
        internal static let fourth = "onboarding.screen.title.fourth"
        /// Сколько тебе лет?
        internal static let ninth = "onboarding.screen.title.ninth"
        /// Ты хочешь, чтобы лицо выглядело более подтянутым?
        internal static let second = "onboarding.screen.title.second"
        /// Сколько часов обычно длится твой сон?
        internal static let seventh = "onboarding.screen.title.seventh"
        /// Заметны ли морщинки на твоём лице, когда оно расслаблено?
        internal static let sixth = "onboarding.screen.title.sixth"
        /// Какой у тебя тип кожи?
        internal static let third = "onboarding.screen.title.third"
      }
    }
    internal enum SkinType {
      /// Комбинировання
      internal static let combined = "onboarding.skinType.combined"
      /// Сухая
      internal static let dry = "onboarding.skinType.dry"
      /// Жирная
      internal static let fat = "onboarding.skinType.fat"
      /// Нормальная
      internal static let normal = "onboarding.skinType.normal"
    }
    internal enum Start {
      /// Курс Face Care - это ваш путь к естественной красоте и молодости
      internal static let description = "onboarding.start.description"
      /// Добро пожаловать в
      internal static let welcome = "onboarding.start.welcome"
    }
  }

  internal enum PlanGeneration {
    /// Анализ проблемных зон
    internal static let first = "planGeneration.first"
    /// Анализ состояния кожи
    internal static let second = "planGeneration.second"
    /// Подбор упражнений для лица согласно твоим потребностям
    internal static let third = "planGeneration.third"
    /// Подготовка персонально плана тренировок
    internal static let title = "planGeneration.title"
  }

  internal enum Progress {
    /// Добавить фото
    internal static let addImage = "progress.addImage"
    /// Смотрите демонстрацию
    internal static let demonstration = "progress.demonstration"
    /// Галерея прогресса
    internal static let gallery = "progress.gallery"
    /// Ежедневная цель
    internal static let goal = "progress.goal"
    /// Для достижения нилучший результатов, выполняйте упражнения каждый день.
    internal static let subtitle = "progress.subtitle"
    /// Мой прогресс
    internal static let title = "progress.title"
    internal enum Settings {
      /// Проблемные зоны
      internal static let problemAreas = "progress.settings.problemAreas"
      /// Вы можете обнулить пройденые дни, историю и настройки персонального курса и начать снова
      internal static let resetDescription = "progress.settings.resetDescription"
      /// Настройки прогресса
      internal static let title = "progress.settings.title"
      internal enum ProgressButton {
        /// Обнулить прогресс
        internal static let resetProgress = "progress.settings.progressButton.resetProgress"
      }
    }
  }

  internal enum Settings {
    /// Связяться с нами
    internal static let contact = "settings.contact"
    /// Восстановить покупки
    internal static let restore = "settings.restore"
    /// Настройки
    internal static let title = "settings.title"
    internal enum Language {
      /// Английский
      internal static let english = "settings.language.english"
      /// Франзузский
      internal static let french = "settings.language.french"
      /// Немецкий
      internal static let german = "settings.language.german"
      /// Итальянский
      internal static let italian = "settings.language.italian"
      /// Русский
      internal static let russian = "settings.language.russian"
      /// Испанский
      internal static let spanish = "settings.language.spanish"
      /// Язык
      internal static let title = "settings.language.title"
    }
  }

  internal enum Subscription {
    /// Информация о плане
    internal static let planInfo = "subscription.planInfo"
    /// Политика конфеденциальности
    internal static let privacy = "subscription.privacy"
    /// Правила пользования
    internal static let termsOfUse = "subscription.termsOfUse"
    internal enum Interval {
      internal enum Day {
        /// дней
        internal static let five = "subscription.interval.day.five"
        /// день
        internal static let one = "subscription.interval.day.one"
        /// дня
        internal static let two = "subscription.interval.day.two"
      }
      internal enum Month {
        /// месяцев
        internal static let five = "subscription.interval.month.five"
        /// месяц
        internal static let one = "subscription.interval.month.one"
        /// месяца
        internal static let two = "subscription.interval.month.two"
      }
      internal enum Week {
        /// недель
        internal static let five = "subscription.interval.week.five"
        /// неделя
        internal static let one = "subscription.interval.week.one"
        /// недели
        internal static let two = "subscription.interval.week.two"
      }
      internal enum Year {
        /// лет
        internal static let five = "subscription.interval.year.five"
        /// год
        internal static let one = "subscription.interval.year.one"
        /// года
        internal static let two = "subscription.interval.year.two"
      }
    }
  }

  internal enum Training {
    /// Тренировка заверешена
    internal static let completed = "training.completed"
    /// Начать тренировку
    internal static let start = "training.start"
    /// Сделать фото
    internal static let takeImage = "training.takeImage"
  }
}

extension L {
    public static func get(table: String = "Localizable", key: String, args: CVarArg...) -> String {
        let path = Bundle.main.path(forResource: State.shared.getLanguage().rawValue, ofType: "lproj")
        let bundle = Bundle(path: path!) ?? Bundle.main
        let format = bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, arguments: args)
    }
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |(_(|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
