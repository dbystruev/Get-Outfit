//
//  lib/models/question.dart
//
//  Created by Denis Bystruev on 14/03/2020.
//

import 'package:get_outfit/models/gender.dart';

enum QuestionType { header, multiChoice, range, singleChoice, text }

class Question {
  final List<String> answers;
  final int defaultAnswer;
  final Gender gender;
  final String hint;
  final bool isDropdown;
  final bool isVisual;
  final int maxValue;
  final int minValue;
  final String subtitle;
  final String title;
  final QuestionType type;
  final int value;

  Question(
    this.title, {
    this.answers = const [],
    this.defaultAnswer,
    this.gender = Gender.both,
    this.hint,
    this.isDropdown = false,
    this.isVisual = false,
    this.maxValue,
    this.minValue,
    this.subtitle,
    this.type = QuestionType.text,
    this.value,
  });

  factory Question.dropdown(String title,
          {List<String> answers,
          int defaultAnswer = 0,
          Gender gender,
          String subtitle}) =>
      Question(
        title,
        answers: answers,
        defaultAnswer: defaultAnswer,
        gender: gender,
        isDropdown: true,
        subtitle: subtitle,
        type: QuestionType.singleChoice,
      );

  factory Question.header(String title, {Gender gender, String subtitle}) =>
      Question(
        title,
        gender: gender,
        subtitle: subtitle,
        type: QuestionType.header,
      );

  factory Question.multiChoice(String title,
          {List<String> answers, Gender gender, String subtitle}) =>
      Question(
        title,
        answers: answers,
        gender: gender,
        subtitle: subtitle,
        type: QuestionType.multiChoice,
      );

  factory Question.pictures(String title,
          {Gender gender, String subtitle, List<String> urls}) =>
      Question(
        title,
        answers: urls,
        gender: gender,
        isVisual: true,
        subtitle: subtitle,
        type: QuestionType.multiChoice,
      );

  factory Question.range(String title, int minValue, int value, int maxValue,
          {Gender gender, String subtitle}) =>
      Question(
        title,
        gender: gender,
        maxValue: maxValue,
        minValue: minValue,
        subtitle: subtitle,
        type: QuestionType.range,
        value: value,
      );

  factory Question.singleChoice(String title,
          {List<String> answers, Gender gender, String subtitle}) =>
      Question(
        title,
        answers: answers,
        gender: gender,
        subtitle: subtitle,
        type: QuestionType.singleChoice,
      );

  factory Question.yesNo(String title, {Gender gender, String subtitle}) =>
      Question.singleChoice(
        title,
        answers: ['Да', 'Нет'],
        gender: gender,
        subtitle: subtitle,
      );

  static List<List<Question>> get all => [
        // Page 1 of 5
        [
          Question('Давайте познакомимся. Как вас зовут?'),
          Question.header('Образ жизни'),
          Question.singleChoice(
            'На сколько лет вы себя ощущаете?',
            answers: [
              '18-25',
              '25-30',
              '30-40',
              '40-50',
              '>50',
            ],
          ),
          Question('Как мы можем найти вас в Instagram/Facebook/VK?'),
          Question('Ваша профессия (род деятельности)?'),
          Question(
            'Опишите ваш образ жизни в процентном соотношении.',
            subtitle:
                'Например, 60% — работа в офисе, 20% — встречи с друзьями, рестораны, 10% — занятия спортом, 10% — вечерние прогулки по парку.',
          ),
          Question(
            'Для чего нужен образ?',
            subtitle: 'Например, работа в офисе, отпуск, занятия спортом...',
          ),
          Question('Ваша любимая музыкальная группа/исполнитель?'),
        ],
        // Page 2 of 5
        [
          Question.header('Предпочтения'),
          Question.pictures(
            'Выберите, какой стиль вам наиболее близок',
            subtitle: 'Можно выбрать несколько картинок',
            urls: [
              'https://static.tildacdn.com/tild3466-6665-4661-a164-356332393861/FullSizeRender_1.jpg',
              'https://static.tildacdn.com/tild6465-6164-4635-b637-623266353139/FullSizeRender.jpg',
              'https://static.tildacdn.com/tild3236-3066-4263-b836-666439666333/FullSizeRender_4.jpg',
              'https://static.tildacdn.com/tild6139-3235-4335-a631-353934303335/FullSizeRender_6.jpg',
              'https://static.tildacdn.com/tild6661-3166-4965-b566-333265326436/FullSizeRender_9.jpg',
              'https://static.tildacdn.com/tild6466-6238-4465-a231-386265326564/FullSizeRender_10.jpg',
              'https://static.tildacdn.com/tild6235-3538-4232-b964-646138376438/IMG_1903.JPG',
              'https://static.tildacdn.com/tild3930-3666-4234-b365-626165656131/IMG_1917.JPG',
              'https://static.tildacdn.com/tild3232-3961-4635-a262-326334613437/IMG_1925.JPG',
              'https://static.tildacdn.com/tild3539-3839-4438-b066-666531313231/FullSizeRender_5.jpg',
              'https://static.tildacdn.com/tild3330-3039-4832-b866-303738633237/FullSizeRender_671.jpg',
              'https://static.tildacdn.com/tild3630-6431-4635-a339-643839663566/IMG_1956.JPG',
            ],
          ),
          Question.multiChoice(
            'Какая посадка брюк является наиболее комфортной для вас?',
            answers: [
              'Низкая',
              'Средняя',
              'Высокая',
            ],
          ),
          Question.multiChoice(
            'Какой фасон юбок вы предпочитаете?',
            answers: [
              'Юбка-карандаш',
              'Джинсовая юбка',
              'Кожаная юбка',
              'Юбка А-силуэта',
              'Плиссированная юбка',
            ],
          ),
          Question.multiChoice(
            'Какую длину юбки/платья вы предпочитаете?',
            answers: [
              'Мини',
              'До колена',
              'Ниже колена (миди)',
              'Макси',
            ],
          ),
          Question.multiChoice(
            'Какой фасон платьев вам нравится?',
            answers: [
              'А-силует',
              'Платье-рубашка',
              'Трикотажное платье',
              'Платье-футляр',
              'Коктейльное платье',
              'Вечернее платье',
            ],
          ),
          Question.multiChoice(
            'Какую обувь вы предпочитаете?',
            answers: [
              'Балетки',
              'Кроссовки',
              'Туфли на шнурках',
              'Лодочки',
              'Ботинки',
              'Слипоны',
              'Мокасины',
              'Эспадрильи',
              'Сандали',
              'Туфли на каблуках',
              'Босоножки на танкетке',
              'Сапоги',
              'Ботфорты',
            ],
          ),
          Question(
            'Укажите в процентном соотношении, как часто вы носите обувь на плоской под��шве и на каблуке?',
            subtitle: '(Например, 60% —плоская подошва, 40% — каблук).',
          ),
          Question.multiChoice(
            'Какие аксессуары вы носите/хотели бы носить?',
            answers: [
              'Серьги',
              'Кольца',
              'Бусы',
              'Подвески и кулоны',
              'Браслеты',
              'Брошки',
              'Шейные платки',
              'Ободки',
              'Заколки',
              'Ношу только ювелирные изделия',
            ],
          ),
          Question.multiChoice(
            'Есть ли части тела, которые вы хотели бы ��крыть?',
            answers: [
              'Нет',
              'Ж��вот',
              'Грудь',
              'Руки, плечи',
              'Спина',
              'Бедра',
              'Колени',
              'Ноги',
            ],
          ),
          Question('В каких магазинах вы обычно совершаете покупки?'),
          Question('Какие бренды вы предпочитаете?'),
          Question.multiChoice(
            'Какие материалы вы предпочитаете?',
            answers: [
              'Хлопок',
              'Шерсть',
              'Шелк',
              'Кашемир',
              'Натуральная кожа',
              'Экокожа (искусственная кожа)',
              'Искусственные ткани (вискоза)',
              'Синтетически�� материалы (акрил, лайкра, полиэстер)',
              'Не ношу синтетику',
              'Трикотаж',
              'Не ношу трикотаж',
              'Лен',
              'Бархат',
              'Вельвет',
            ],
          ),
          Question(
            'Какие вещи вы категорически не носите?',
            subtitle:
                'Например, топы на бретельках, кружево, стразы и пайетки, пышные юбки...',
          ),
          Question.multiChoice(
            'Какие из принтов вы не носите?',
            answers: [
              'Анималистичный принт',
              'Цветочный принт',
              'В горошек',
              'В клетку',
              'В полоску',
              'Огуречный принт',
              'Логотипы',
              'Мелкий рисунок',
            ],
          ),
          Question('Какие цвета вам не нравятся?'),
          Question.singleChoice(
            'Вы хотите попробовать что-то новое?',
            answers: [
              'Да, хочу смелые образы и сочетания, чтобы окружающие заметили перемену',
              'Нет, хочу что-то в моем стиле, чтобы вписалось в текущий гардероб',
            ],
          ),
          Question.multiChoice(
            'Для вас наиболее важно, чтобы...',
            answers: [
              'Одежда была комфортной',
              'Образ выделялся из толпы',
              'Вещи были подобраны на распродажах',
              'Соблюдался минимализм в стиле',
              'Стилист создал образы на свой вкус',
              'Одежда была доставлена максимально быстро',
              'Выглядеть модно, быть в курсе последних трендов',
              'Сэкономить время на шопинге',
            ],
            subtitle: 'Можно выбрать несколько вариантов',
          )
        ],
        // Page 3 of 5
        [
          Question.header('Определите бюджет'),
          Question.singleChoice(
            'Обычно вы покупаете...',
            answers: [
              'Вещи только из новых коллекций',
              'Чаще из новых коллекций',
              'Чаще на распродажах',
              'Вещи только на распродажах',
            ],
          ),
          Question.range('Сколько вы бы потратили на футболку или топ? (₽)',
              300, 20200, 40000),
          Question.range('Сколько вы бы потратили на джинсы или брюки? (₽)',
              500, 25300, 50000),
          Question.range(
              'Сколько вы бы потратили на платье? (₽)', 1000, 25500, 50000),
          Question.range('Сколько вы бы потратили на куртку или пиджак? (₽)',
              500, 50500, 100000),
          Question.range(
              'Сколько вы бы потратили на обувь? (₽)', 500, 50500, 100000),
          Question.range(
              'Сколько вы бы потратили на аксессуары? (₽)', 500, 50300, 100000),
        ],
        // Page 4 of 5
        [
          Question.header('Укажите размеры'),
          Question('Ваш рост?', hint: 'см'),
          Question('Ваш вес?', hint: 'кг'),
          Question.dropdown(
            'Ваш размер (футболка, свитер)?',
            answers: [
              'XXS/XS (40)',
              'XS/S (42)',
              'S (44)', // default
              'M (46)',
              'L (48)',
              'L/XL (50)',
              'XL (52)',
              'XXL (54/56)',
              'XXXL (58)',
            ],
            defaultAnswer: 2,
          ),
          Question.dropdown(
            'Ваш размер брюк?',
            answers: [
              '38 (32)', // default
              '40 (34)',
              '42 (36)',
              '44 (38)',
              '46 (40)',
              '48 (42)',
              '50 (44)',
              '52 (46)',
              '54 (48)',
              '56 (50)',
              '58 (52)',
            ],
          ),
          Question.dropdown(
            'Длина брюк/джинс?',
            answers: [
              'L28 (150–157)', // default
              'L30 (158–164)',
              'L32 (165–177)',
              'L34 (178–185)',
              'L36 (>185)',
              'Затрудняюсь ответить',
            ],
          ),
          Question.dropdown(
            'Ваш размер обуви?',
            answers: [
              '34', // default
              '35',
              '36',
              '37',
              '38',
              '39',
              '40',
              '41',
              '42',
              '43',
              '44',
            ],
          ),
        ],
        // Page 5 of 5
        [
          Question.yesNo(
              'Готовы ли вы рассмотреть покупку вещей в магазинах, требующих предоплату по банковской карте (ассортимент будет шире)?'),
          Question.dropdown(
            'Ваш объем талии?',
            answers: [
              'W24', // default
              'W25',
              'W26',
              'W27',
              'W28',
              'W29',
              'W30',
              'W31',
              'W32',
              'W33',
              'W34',
            ],
            subtitle: 'Можно посмотреть на ваших джинсах',
          ),
          Question.singleChoice(
            'Готовы ли вы рассмотреть доставку из разных магазинов?',
            answers: ['Да', 'Нет. Доставка из одного магазина в одно время'],
          ),
          Question.yesNo(
              'Готовы ли вы рассмотреть платную доставку (ассортимент будет шире)?'),
          Question('В каком городе вы проживаете?'),
          Question.singleChoice(
            'Как часто вы покупаете новые вещи?',
            answers: [
              'Несколько раз в месяц',
              'Один раз в месяц',
              'Каждые два месяца',
              'На каждый новый сезон',
              'Один раз в полгода и реже',
            ],
          ),
          Question.singleChoice(
            'Ваш любимый мессенджер?',
            answers: [
              'WhatsApp',
              'Telegram',
              'Facebook Messenger',
              'ВКонтакте',
              'Viber',
            ],
          ),
          Question.singleChoice(
            'Откуда вы о нас узнали?',
            answers: [
              'СМИ',
              'Facebook',
              'Instagram',
              'Google',
              'Яндекс',
              'Вконтакте',
              'Друзья/родственники',
              'Другое',
            ],
          ),
          Question(
            'Дополнительные комментарии',
            subtitle: 'Если вдруг мы что-то не учли, пожалуйста, сообщите нам:',
          ),
          Question('Ваш e-mail'),
          Question('Ваш мобильный телефон'),
        ],
      ];
}
