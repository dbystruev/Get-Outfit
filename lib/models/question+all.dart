//
//  lib/models/question+all.dart
//
//  Created by Denis Bystruev on 15/03/2020.
//

import 'package:get_outfit/models/question.dart';

extension AllQuestions on Question {
  static List<List<Question>> get local => [
        // Page 1 of 5
        [
          Question.header(
              'Здравствуйте!\nРасскажите нам о себе,\nэто займет не более 8 минут.'),
          Question('Давайте познакомимся. Как вас зовут?'),
          // Question.header('Образ жизни'),
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
          Question('Как мы можем найти вас в соц. сетях?'),
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
          Question.dropdownMale(
            'Как обычно добираетесь до работы?',
            answers: [
              'Пешком',
              'Общественным транспортом',
              'На велосипеде',
              'На машине',
              'Пешком/Общественным транспортом/Каршеринг/Такси',
            ],
          ),
          Question('Ваша любимая музыкальная группа/исполнитель?'),
        ],
        // Page 2 of 5
        [
          Question.header('Предпочтения'),
          Question.picturesFemale(
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
          Question.picturesMale(
            'Выберите, какой стиль вам наиболее близок',
            subtitle: 'Можно выбрать несколько картинок',
            urls: [
              'https://static.tildacdn.com/tild6131-3439-4239-a265-643836313663/FullSizeRender_3.jpg',
              'https://static.tildacdn.com/tild3237-6639-4166-b463-393935366237/FullSizeRender_5.jpg',
              'https://static.tildacdn.com/tild6662-6632-4161-b163-313563653036/FullSizeRender_7.jpg',
              'https://static.tildacdn.com/tild3238-6134-4536-a530-633939633466/FullSizeRender_8.jpg',
              'https://static.tildacdn.com/tild3833-6531-4531-b632-303861373364/FullSizeRender_11.jpg',
              'https://static.tildacdn.com/tild6137-3364-4232-a464-346663623861/FullSizeRender.jpg',
              'https://static.tildacdn.com/tild3530-3962-4532-b138-623931333737/IMG_1885.JPG',
              'https://static.tildacdn.com/tild3138-3830-4065-b339-316436653262/IMG_1898.JPG',
              'https://static.tildacdn.com/tild6334-6463-4464-a535-386339643732/IMG_1940.JPG',
              'https://static.tildacdn.com/tild3633-6633-4434-b835-336638663637/FullSizeRender_1.jpg',
              'https://static.tildacdn.com/tild3362-6166-4362-a439-343233333235/FullSizeRender_3.jpg',
              'https://static.tildacdn.com/tild6439-3233-4364-b737-383763363737/FullSizeRender_346.jpg',
            ],
          ),
          Question.multiChoiceFemale(
            'Какая посадка брюк является наиболее комфортной для вас?',
            answers: [
              'Низкая',
              'Средняя',
              'Высокая',
            ],
          ),
          Question.multiChoiceMale(
            'Какой фасон брюк вы предпочитаете?',
            answers: [
              'Укороченные',
              'Зауженные',
              'Прямые',
              'Свободные',
              'Клеш',
            ],
          ),
          Question.multiChoiceFemale(
            'Какой фасон юбок вы предпочитаете?',
            answers: [
              'Юбка-карандаш',
              'Джинсовая юбка',
              'Кожаная юбка',
              'Юбка А-силуэта',
              'Плиссированная юбка',
            ],
          ),
          Question.multiChoiceFemale(
            'Какую длину юбки/платья вы предпочитаете?',
            answers: [
              'Мини',
              'До колена',
              'Ниже колена (миди)',
              'Макси',
            ],
          ),
          Question.multiChoiceFemale(
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
          Question.multiChoiceFemale(
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
          Question.multiChoiceMale(
            'Какая обувь вам нравится?',
            answers: [
              'Кеды',
              'Кроссовки',
              'Классические туфли',
              'Лоферы',
              'Ботинки',
              'Слипоны',
              'Мокасины',
              'Сандали',
            ],
          ),
          Question.female(
            'Укажите в процентном соотношении, как часто вы носите обувь на плоской подошве и на каблуке?',
            subtitle: '(Например, 60% — плоская подошва, 40% — каблук).',
          ),
          Question.multiChoiceFemale(
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
          Question.multiChoiceFemale(
            'Есть ли части тела, которые вы хотели бы скрыть?',
            answers: [
              'Нет',
              'Живот',
              'Грудь',
              'Руки, плечи',
              'Спина',
              'Бедра',
              'Колени',
              'Ноги',
            ],
          ),
          // Question.headerMale('',
          //     subtitle:
          //         'Нам важно знать, какой стиль наиболее близок вам, а какие\nвещи вы бы предпочли исключить из своего гардероба.'),
          Question('В каких магазинах вы обычно совершаете покупки?'),
          Question('Какие бренды вы предпочитаете?'),
          Question.multiChoiceFemale(
            'Какие материалы вы предпочитаете?',
            answers: [
              'Хлопок',
              'Шерсть',
              'Шелк',
              'Кашемир',
              'Натуральная кожа',
              'Экокожа (искусственная кожа)',
              'Искусственные ткани (вискоза)',
              'Синтетические материалы (акрил, лайкра, полиэстер)',
              'Не ношу синтетику',
              'Трикотаж',
              'Не ношу трикотаж',
              'Лен',
              'Бархат',
              'Вельвет',
            ],
          ),
          Question.multiChoiceMale(
            'Какие материалы вы предпочитаете?',
            answers: [
              'Хлопок',
              'Шерсть',
              'Шелк',
              'Кашемир',
              'Натуральная кожа',
              'Экокожа (искусственная кожа)',
              'Искусственные ткани (вискоза)',
              'Синтетические материалы (акрил, лайкра, полиэстер)',
              'Не ношу синтетику',
              'Трикотаж',
              'Не ношу трикотаж',
              'Лен',
            ],
          ),
          Question.female(
            'Какие вещи вы категорически не носите?',
            subtitle:
                'Например, топы на бретельках, кружево, стразы и пайетки, пышные юбки...',
          ),
          Question.multiChoiceMale(
            'Что из перечисленного вы не носите?',
            answers: [
              'V-образный вырез',
              'Поло',
              'Карман на груди',
              'Большой логотип',
              'Водолазка',
              'Толстовка с капюшоном',
              'Джинсы',
              'Кардиган',
              'Свитер',
              'Шорты',
            ],
          ),
          Question.multiChoiceFemale(
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
          Question.multiChoiceMale(
            'Какие из принтов вы не носите?',
            answers: [
              'Анималистичный принт',
              'Цветочный принт',
              'В горошек',
              'В клетку',
              'В полоску',
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
          Question.rangeFemale(
            'Сколько вы бы потратили на футболку или топ? (₽)',
            300,
            20200,
            40000,
          ),
          Question.rangeMale(
            'Сколько вы бы потратили на футболку? (₽)',
            300,
            15100,
            30000,
          ),
          Question.rangeMale(
              'Сколько вы бы потратили на рубашку? (₽)', 500, 20300, 40000),
          Question.range('Сколько вы бы потратили на джинсы или брюки? (₽)',
              500, 25500, 50000),
          Question.rangeFemale(
              'Сколько вы бы потратили на платье? (₽)', 1000, 25500, 50000),
          Question.range('Сколько вы бы потратили на куртку или пиджак? (₽)',
              500, 50500, 100000),
          Question.range(
              'Сколько вы бы потратили на обувь? (₽)', 500, 50500, 100000),
          Question.range(
              'Сколько вы бы потратили на аксессуары? (₽)', 500, 50500, 100000),
        ],
        // Page 4 of 5
        [
          Question.header('Укажите размеры'),
          Question('Ваш рост?', hint: 'см'),
          Question('Ваш вес?', hint: 'кг'),
          Question.dropdownFemale(
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
          Question.dropdownMale(
            'Ваш размер (футболка, рубашка, свитер)?',
            answers: [
              'XS (44)', // default
              'S (46)',
              'M (48)',
              'L (50)',
              'XL (52)',
              'XXL (54/56)',
              'XXXL (58)',
            ],
          ),
          Question.dropdownMale(
            'Ваш размер сорочки?',
            answers: [
              '36', // default
              '37',
              '38',
              '39',
              '40',
              '41',
              '42',
              '43',
              '44',
              '45',
              '46',
              '47',
              '48',
              'Затрудняюсь ответить',
            ],
          ),
          Question.dropdownMale(
            'Ваш размер джинсов?',
            answers: [
              'W28/L32', // default
              'W29/L32',
              'W30/L32',
              'W31/L32',
              'W32/L32',
              'W33/L32',
              'W34/L32',
              'W36/L32',
              'W38/L32',
              'W28/L34',
              'W29/L34',
              'W30/L34',
              'W31/L34',
              'W32/L34',
              'W33/L34',
              'W34/L34',
              'W36/L34',
              'W38/L34',
              'Затрудняюсь ответить',
            ],
          ),
          Question.dropdownFemale(
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
          Question.dropdownMale(
            'Ваш размер брюк?',
            answers: [
              '40/42', // default
              '42/44',
              '44/46',
              '46/48',
              '50/52',
              '52/54',
              '54/56',
            ],
          ),
          Question.dropdownFemale(
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
          Question.dropdownFemale(
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
          Question.dropdownMale(
            'Ваш размер обуви?',
            answers: [
              '38', // default
              '39',
              '40',
              '41',
              '42',
              '43',
              '44',
              '45',
              '46',
              '47',
              '48',
            ],
          ),
          Question.multiChoiceMale(
            'Особенности фигуры',
            answers: [
              'Широкие плечи',
              'Широкая грудь',
              'Длинные руки',
              'Длинные ноги',
              'Короткие ноги',
              'Мускулистые ноги',
              'Наличие живота',
              'Худое телосложение',
              'Промежуточные размеры',
            ],
          ),
        ],
        // Page 5 of 5
        [
          Question.header('Завершение'),
          Question.yesNo(
              'Готовы ли вы рассмотреть покупку вещей в магазинах, требующих предоплату по банковской карте (ассортимент будет шире)?'),
          Question.dropdownFemale(
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
            'Готовы ли вы рассмотреть доставку из разных магазинов (ассортимент будет шире)?',
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
            subtitle: 'Мы создадим чат со стилистом в указанном мессенджере',
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
