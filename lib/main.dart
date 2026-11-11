import 'package:flutter/material.dart';

void main() {
  runApp(const GnmQuizApp());
}

class GnmQuizApp extends StatelessWidget {
  const GnmQuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ГНМ: Навигатор и Практикум',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF0F4F8),
        useMaterial3: true,
      ),
      home: const DisclaimerScreen(),
    );
  }
}

// --- ЭКРАН 1: ДИСКЛЕЙМЕР ---
class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.psychology, size: 80, color: Colors.indigo),
              const SizedBox(height: 20),
              const Text(
                'Навигатор по ГНМ\n(Кейсы • Самоанализ • Констелляции • Техники)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade700),
                ),
                child: const Text(
                  'ВНИМАНИЕ: Все материалы, клинические задачи, тесты на констелляции и психологические упражнения основаны на концепции 5 Биологических Законов Р. Г. Хамера и предназначены исключительно для образовательных целей и саморефлексии.\n\nКонцепция ГНМ не признана официальной медициной и психиатрией. Приложение не ставит диагнозов и не заменяет консультацию врача.',
                  style: TextStyle(fontSize: 13.5, color: Colors.black87),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
                  );
                },
                child: const Text('Понятно, открыть приложение', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- ГЛАВНЫЙ ЭКРАН С 5 ВКЛАДКАМИ ---
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ClinicalCasesTab(),
    const SelfInquiryTab(),
    const ConstellationsTab(),
    const PracticesTab(),
    const ReferenceTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey.shade600,
        backgroundColor: Colors.white,
        selectedFontSize: 11,
        unselectedFontSize: 10,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind),
            label: 'Кейсы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Самоанализ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hub),
            label: 'Констелляции',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement),
            label: 'Техники',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Компас',
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ВКЛАДКА 1: КЛИНИЧЕСКИЕ КЕЙСЫ (СИТУАЦИОННЫЕ ЗАДАЧИ)
// ============================================================================
class ClinicalCase {
  final String title;
  final String patientProfile;
  final String lifeContext;
  final String symptoms;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String breakdown;

  ClinicalCase({
    required this.title,
    required this.patientProfile,
    required this.lifeContext,
    required this.symptoms,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.breakdown,
  });
}

class ClinicalCasesTab extends StatefulWidget {
  const ClinicalCasesTab({Key? key}) : super(key: key);

  @override
  State<ClinicalCasesTab> createState() => _ClinicalCasesTabState();
}

class _ClinicalCasesTabState extends State<ClinicalCasesTab> {
  int _currentCaseIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  int? _selectedAnswerIndex;

  final List<ClinicalCase> _cases = [
    ClinicalCase(
      title: 'Кейс №1: Боль в плече',
      patientProfile: 'Мужчина, 38 лет. По тесту аплодисментов — биологический ПРАВША.',
      lifeContext: 'Неделю назад крупно поссорился с женой, чувствовал себя виноватым («я плохой муж, не смог её поддержать»). Вчера вечером они наконец помирились и всё обсудили.',
      symptoms: 'Сегодня утром проснулся от сильной ноющей боли и отека в ПРАВОМ плечевом суставе. Руки и ноги горячие, чувствует общую расслабленность.',
      questionText: 'Определите фазу СБП, зародышевый листок и суть конфликта:',
      options: [
        'КА-фаза | Эктодерма | Конфликт разлуки с женой',
        'Пкл-фаза (Восстановление) | Новая мезодерма | Конфликт самообесценивания (КСО) в отношении партнера',
        'Пкл-фаза | Старая мезодерма | Конфликт атаки со стороны жены',
        'КА-фаза | Новая мезодерма | КСО в отношении матери или ребенка'
      ],
      correctAnswerIndex: 1,
      breakdown: '1. Ткань: Суставы, кости и связки относятся к Новой мезодерме.\n'
          '2. Фаза: В Новой мезодерме отек, воспаление и боль возникают ТОЛЬКО в фазе восстановления (Пкл) после примирения (КЛ).\n'
          '3. Латеральность: Для правши ПРАВАЯ сторона тела — партнерская (жена, друзья, коллеги).\n'
          '4. Конфликт: Плечо символизирует КСО «я плохой партнер / не смог обнять и поддержать».',
    ),
    ClinicalCase(
      title: 'Кейс №2: Детский сад и кожа',
      patientProfile: 'Женщина, 29 лет. По тесту аплодисментов — биологическая ЛЕВША.',
      lifeContext: 'Всю рабочую неделю впервые оставляла 3-летнего сына в детском саду. Очень переживала, как он там без нее. Наступили выходные, ребенок снова дома на руках у мамы.',
      symptoms: 'В субботу на эпидермисе внутренней стороны ПРАВОГО предплечья появилась красная зудящая сыпь (дерматит).',
      questionText: 'Почему высыпало именно на ПРАВОЙ руке и какая это фаза?',
      options: [
        'Пкл-фаза | Эктодерма | Конфликт разлуки с ребенком (для левши правая сторона — сторона матери/ребенка)',
        'КА-фаза | Старая мезодерма | Конфликт грязи и атаки на правой стороне',
        'Пкл-фаза | Эктодерма | Конфликт разлуки с мужем (партнерская сторона)',
        'Эпикризис | Энтодерма | Кусковой конфликт'
      ],
      correctAnswerIndex: 0,
      breakdown: '1. Ткань: Эпидермис (верхний слой кожи) — это Эктодерма (кора мозга).\n'
          '2. Конфликт: Внутренняя сторона рук отвечает за конфликт разлуки («оторвали от объятий»).\n'
          '3. Фаза: В КА-фазе эпидермис незаметно изъязвляется, а покраснение, отек и зуд возникают в Пкл-фазе (воссоединение с сыном на выходных).\n'
          '4. Латеральность: У ЛЕВШИ стороны инвертированы! Правая сторона для левши отвечает за мать и детей.',
    ),
    ClinicalCase(
      title: 'Кейс №3: Узелок в груди',
      patientProfile: 'Женщина, 45 лет. Биологическая ПРАВША.',
      lifeContext: 'Две недели назад её маленький сын попал в больницу. Женщина не находит себе места, плохо спит по ночам, постоянно прокручивает мысли о его здоровье, ладони ледяные.',
      symptoms: 'На осмотре обнаружено плотное безболезненное образование (плюс-ткань / рост клеток) в ЛЕВОЙ молочной железе (собственно железистая ткань). Воспаления нет.',
      questionText: 'В какой фазе и в каком конфликте находится женщина?',
      options: [
        'Пкл-фаза | Эктодерма | Конфликт разлуки с сыном (протоки железы)',
        'КА-фаза (Активная) | Старая мезодерма | Конфликт заботы/беспокойства о гнезде (ребенке)',
        'КА-фаза | Новая мезодерма | Конфликт самообесценивания матери',
        'Пкл-фаза | Старая мезодерма | Распад опухоли после выздоровления сына'
      ],
      correctAnswerIndex: 1,
      breakdown: '1. Вегетатика: Бессонница, принудительное мышление и холодные руки — верный признак активной КА-фазы (симпатикотония).\n'
          '2. Ткань: Железистая ткань груди — Старая мезодерма (Мозжечок). Она дает РОСТ клеток (плюс-ткань) именно в КА-фазе. Биологический смысл: дать больше молока, чтобы спасти детеныша.\n'
          '3. Латеральность: Для правши ЛЕВАЯ сторона — сторона матери/ребенка.',
    ),
    ClinicalCase(
      title: 'Кейс №4: Правосторонняя ангина',
      patientProfile: 'Студент, 21 год (Латеральность рук для ствола мозга не применяется).',
      lifeContext: 'Месяц готовился получить грант на обучение, но в последний момент грант отдали другому («кусок уплыл из-под носа»). Позавчера декан нашел для него другое финансирование, студент выдохнул.',
      symptoms: 'Сегодня поднялась температура 38.5, сильная слабость, гнойный налет на ПРАВОЙ миндалине (гнойная ангина), ночью сильно потеет.',
      questionText: 'Объясните с точки зрения ГНМ, почему поражена именно ПРАВАЯ миндалина и что за процесс идет:',
      options: [
        'КА-фаза | Эктодерма | Территориальный конфликт потери денег',
        'Пкл-фаза | Энтодерма | Работа грибков/микобактерий после конфликта «невозможности проглотить желанный кусок» (правая сторона ствола)',
        'Пкл-фаза | Энтодерма | Конфликт «невозможности выплюнуть плохой кусок» (левая сторона)',
        'КА-фаза | Старая мезодерма | Конфликт атаки на горло'
      ],
      correctAnswerIndex: 1,
      breakdown: '1. Ткань: Миндалины (подслизистая) относятся к Энтодерме (Ствол мозга).\n'
          '2. Правило сторон для Ствола мозга: В древнем мозге нет правшей/левшей, но есть правило «входа и выхода». ПРАВАЯ сторона отвечает за получение/проглатывание нужного куска (гранта), ЛЕВАЯ — за избавление от нежелательного куска.\n'
          '3. Фаза: Жар, гной и ночной пот — это Пкл-фаза, где микробы разбирают наросшую за время стресса ткань миндалины.',
    ),
  ];

  void _answerQuestion(int selectedIndex) {
    if (_isAnswered) return;
    setState(() {
      _isAnswered = true;
      _selectedAnswerIndex = selectedIndex;
      if (selectedIndex == _cases[_currentCaseIndex].correctAnswerIndex) {
        _score++;
      }
    });
  }

  void _nextCase() {
    setState(() {
      _currentCaseIndex++;
      _isAnswered = false;
      _selectedAnswerIndex = null;
    });
  }

  void _resetCases() {
    setState(() {
      _currentCaseIndex = 0;
      _score = 0;
      _isAnswered = false;
      _selectedAnswerIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Практикум: Кейсы ГНМ', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: _currentCaseIndex < _cases.length ? _buildCaseBody() : _buildResultScreen(),
    );
  }

  Widget _buildCaseBody() {
    final currentCase = _cases[_currentCaseIndex];
    final progress = (_currentCaseIndex + 1) / _cases.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.indigo.shade100,
                  color: Colors.indigo,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${_currentCaseIndex + 1} / ${_cases.length}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 3,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.indigo.shade700,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.folder_shared, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        currentCase.title,
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCaseDetailRow(Icons.person, 'Пациент:', currentCase.patientProfile, Colors.indigo),
                      const Divider(height: 16),
                      _buildCaseDetailRow(Icons.history_edu, 'Анамнез:', currentCase.lifeContext, Colors.teal.shade700),
                      const Divider(height: 16),
                      _buildCaseDetailRow(Icons.coronavirus, 'Симптомы:', currentCase.symptoms, Colors.red.shade700),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '❓ ${currentCase.questionText}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          ...List.generate(currentCase.options.length, (index) {
            Color buttonColor = Colors.white;
            Color borderColor = Colors.grey.shade300;
            if (_isAnswered) {
              if (index == currentCase.correctAnswerIndex) {
                buttonColor = Colors.green.shade100;
                borderColor = Colors.green;
              } else if (index == _selectedAnswerIndex) {
                buttonColor = Colors.red.shade100;
                borderColor = Colors.red;
              }
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: InkWell(
                onTap: () => _answerQuestion(index),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    border: Border.all(color: borderColor, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    currentCase.options[index],
                    style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.3),
                  ),
                ),
              ),
            );
          }),
          if (_isAnswered) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.indigo.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.indigo, size: 20),
                      SizedBox(width: 6),
                      Text(
                        'Алгоритм разбора по ГНМ:',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo, fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentCase.breakdown,
                    style: const TextStyle(fontSize: 14, height: 1.4, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _nextCase,
              child: Text(
                _currentCaseIndex == _cases.length - 1 ? 'Завершить практикум' : 'Следующий кейс',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildCaseDetailRow(IconData icon, String label, String text, Color labelColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: labelColor),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
              children: [
                TextSpan(
                  text: '$label ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: labelColor),
                ),
                TextSpan(text: text),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user, size: 80, color: Colors.indigo),
            const SizedBox(height: 16),
            Text(
              'Решено кейсов: $_score из ${_cases.length}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              onPressed: _resetCases,
              icon: const Icon(Icons.replay),
              label: const Text('Решить кейсы заново'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// ВКЛАДКА 2: ВОПРОСЫ К СЕБЕ (САМОДИАГНОСТИКА ПО ЗАБОЛЕВАНИЯМ)
// ============================================================================
class DiseaseInquiry {
  final String title;
  final String category;
  final String germLayer;
  final Color layerColor;
  final String conflictEssence;
  final List<String> questions;
  final String recommendedPractice;

  DiseaseInquiry({
    required this.title,
    required this.category,
    required this.germLayer,
    required this.layerColor,
    required this.conflictEssence,
    required this.questions,
    required this.recommendedPractice,
  });
}

class SelfInquiryTab extends StatefulWidget {
  const SelfInquiryTab({Key? key}) : super(key: key);

  @override
  State<SelfInquiryTab> createState() => _SelfInquiryTabState();
}

class _SelfInquiryTabState extends State<SelfInquiryTab> {
  String _searchQuery = '';
  String _selectedCategory = 'Все';

  final List<String> _categories = [
    'Все',
    'Кожа и ногти',
    'Опорно-двигательный',
    'ЛОР и Дыхание',
    'ЖКТ и Пищеварение',
    'Мочеполовая и Грудь',
  ];

  final List<DiseaseInquiry> _inquiries = [
    DiseaseInquiry(
      title: 'Грибок кожи и ногтей (Микоз)',
      category: 'Кожа и ногти',
      germLayer: 'Старая мезодерма (Дерма)',
      layerColor: const Color(0xFFF57C00),
      conflictEssence: 'Конфликт «запятнанности», нарушения целостности, контакта с чем-то неприятным или «грязным» (буквально или метафорически).',
      questions: [
        '1. Когда именно появился грибок (какая ситуация разрешилась прямо перед этим)?',
        '2. Кто или что «наступило мне на ногу» (где мне приходится ходить по чему-то неприятному)?',
        '3. Где и перед кем я чувствую себя незащищенным или «испачканным»?',
        '4. Не стал ли сам грибок поводом стыдиться себя и своих ног (вторичный конфликт «запятнанности», делающий грибок хроническим)?',
      ],
      recommendedPractice: 'Подходящая практика во вкладке Техники: «Биологический душ и Защитный купол» + «Разрыв трека».',
    ),
    DiseaseInquiry(
      title: 'Экзема, дерматит, сыпь, псориаз',
      category: 'Кожа и ногти',
      germLayer: 'Эктодерма (Эпидермис)',
      layerColor: const Color(0xFFD32F2F),
      conflictEssence: 'Конфликт разлуки: «меня оторвали от любимого человека» ИЛИ наоборот «я хочу оттолкнуть неприятный контакт».',
      questions: [
        '1. Когда появилась сыпь (кто ушел или, наоборот, наконец-то вернулся перед этим)?',
        '2. Чьих прикосновений мне остро не хватает именно на этом участке кожи (внутренняя сторона рук/тела — желание обнять)?',
        '3. От кого я хочу отгородиться и кого не хочу к себе подпускать (внешняя сторона рук/локтей/коленей)?',
        '4. Не избегаю ли я теперь людей и прикосновений из-за некрасивого вида своей кожи (новый конфликт разлуки)?',
      ],
      recommendedPractice: 'Подходящая практика во вкладке Техники: «Насыщение контактом / Отталкивание».',
    ),
    DiseaseInquiry(
      title: 'Боли в спине, пояснице, суставах',
      category: 'Опорно-двигательный',
      germLayer: 'Новая мезодерма',
      layerColor: const Color(0xFFE65100),
      conflictEssence: 'Конфликт самообесценивания (КСО): «я не справляюсь, я слабый партнер/родитель, на мне всё держится».',
      questions: [
        '1. Какую тяжелую ответственность я сбросил с плеч или с кем помирился перед тем, как началась боль?',
        '2. Кто «ездит на мне», и где я тащу непосильный груз за других?',
        '3. На какой стороне болит сустав (для правши левая — мама/дети, правая — партнер/работа; для левши — наоборот)?',
        '4. Не обесцениваю ли я себя сейчас из-за того, что тело болит и не дает двигаться как раньше?',
      ],
      recommendedPractice: 'Подходящая практика во вкладке Техники: «Снятие чужого рюкзака и Возврат опоры».',
    ),
    DiseaseInquiry(
      title: 'Ангина, тонзиллит, ком в горле',
      category: 'ЛОР и Дыхание',
      germLayer: 'Энтодерма / Эктодерма',
      layerColor: const Color(0xFFFBC02D),
      conflictEssence: '«Кусковой» конфликт: не могу проглотить желанный кусок (правая миндалина) или не могу выплюнуть навязанный кусок/обиду (левая миндалина).',
      questions: [
        '1. Какая ситуация с «упущенной выгодой» или «навязанным решением» разрешилась за 1-2 дня до боли в горле?',
        '2. Что именно или чьи слова мне пришлось «проглотить» против своей воли?',
        '3. Какие слова застряли у меня в горле, потому что я побоялся их высказать?',
        '4. Не виню ли я во всем «холодную воду / сквозняк», превращая холод в триггер-трек?',
      ],
      recommendedPractice: 'Подходящая практика во вкладке Техники: «Биологическое выплевывание куска» + «Разрыв трека».',
    ),
    DiseaseInquiry(
      title: 'Гастрит, изжога, СРК, кишечник',
      category: 'ЖКТ и Пищеварение',
      germLayer: 'Эктодерма / Энтодерма',
      layerColor: const Color(0xFFD32F2F),
      conflictEssence: 'Конфликт территориальной злости/несправедливости (желудок) ИЛИ «неперевариваемой подлости» (кишечник).',
      questions: [
        '1. С какой несправедливостью или подлостью в семье/на работе я недавно столкнулся?',
        '2. Кого или какое событие я «не могу переварить» — оно стоит у меня поперек желудка?',
        '3. За что я отчаянно держусь и боюсь отпустить контроль?',
        '4. Не начал ли я бояться обычной еды, запуская спазм желудка одним страхом перед пищей?',
      ],
      recommendedPractice: 'Подходящая практика во вкладке Техники: «Маркировка границ» и «Разрыв трека».',
    ),
    DiseaseInquiry(
      title: 'Цистит, молочная железа',
      category: 'Мочеполовая и Грудь',
      germLayer: 'Эктодерма / Старая мезодерма',
      layerColor: const Color(0xFFD32F2F),
      conflictEssence: 'Конфликт нарушения границ территории (цистит) ИЛИ разрывающая тревога за кого-то в «гнезде» (грудь).',
      questions: [
        '1. Кто нарушает мои границы в доме/отношениях (цистит) или за кого я безумно переживаю (грудь)?',
        '2. Где я не могу четко сказать: «так со мной нельзя, это мое место»?',
        '3. Кого я пытаюсь спасти и «выкормить своей грудью» в ущерб себе?',
        '4. Не стал ли страх диагноза или страх близости новым ежедневным стрессом?',
      ],
      recommendedPractice: 'Подходящая практика во вкладке Техники: «Маркировка границ территории».',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredList = _inquiries.where((item) {
      final matchesCategory = _selectedCategory == 'Все' || item.category == _selectedCategory;
      final matchesSearch = item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.conflictEssence.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Вопросы к себе (Самоанализ)', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Поиск симптома (грибок, горло, спина)...',
                    prefixIcon: const Icon(Icons.search, color: Colors.indigo),
                    filled: true,
                    fillColor: const Color(0xFFF0F4F8),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final cat = _categories[index];
                      final isSelected = _selectedCategory == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: isSelected,
                          selectedColor: Colors.indigo,
                          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontSize: 13),
                          onSelected: (_) => setState(() => _selectedCategory = cat),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final item = filteredList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ExpansionTile(
                    initiallyExpanded: index == 0,
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    leading: CircleAvatar(
                      backgroundColor: item.layerColor,
                      child: const Icon(Icons.question_mark, color: Colors.white, size: 20),
                    ),
                    title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text(item.germLayer, style: TextStyle(color: item.layerColor, fontWeight: FontWeight.w600, fontSize: 12)),
                    children: [
                      const Divider(),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                        child: Text('🎯 Суть конфликта: ${item.conflictEssence}', style: const TextStyle(fontSize: 13)),
                      ),
                      const SizedBox(height: 10),
                      ...item.questions.map((q) {
                        final isTrack = q.startsWith('4.');
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isTrack ? Colors.amber.shade50 : Colors.indigo.shade50.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: isTrack ? Colors.amber.shade400 : Colors.indigo.shade100),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(isTrack ? Icons.loop : Icons.chat_bubble_outline, size: 18, color: isTrack ? Colors.orange.shade800 : Colors.indigo),
                              const SizedBox(width: 10),
                              Expanded(child: Text(q, style: const TextStyle(fontSize: 13.5, height: 1.35))),
                            ],
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade300),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.self_improvement, color: Colors.green, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item.recommendedPractice,
                                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.green.shade900),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ВКЛАДКА 3: ПРОВЕРКА НАЛИЧИЯ КОНСТЕЛЛЯЦИЙ ГОЛОВНОГО МОЗГА (НОВАЯ ВКЛАДКА)
// ============================================================================
class BrainConstellation {
  final String id;
  final String title;
  final String brainArea;
  final Color areaColor;
  final String leftConflict;
  final String rightConflict;
  final List<String> symptomsChecklist;
  final String biologicalPurpose;
  final String exitStrategy;

  BrainConstellation({
    required this.id,
    required this.title,
    required this.brainArea,
    required this.areaColor,
    required this.leftConflict,
    required this.rightConflict,
    required this.symptomsChecklist,
    required this.biologicalPurpose,
    required this.exitStrategy,
  });
}

class ConstellationsTab extends StatefulWidget {
  const ConstellationsTab({Key? key}) : super(key: key);

  @override
  State<ConstellationsTab> createState() => _ConstellationsTabState();
}

class _ConstellationsTabState extends State<ConstellationsTab> {
  String _selectedBrainFilter = 'Все отделы';
  // Хранит отмеченные пользователем симптомы (формат: 'constellationId_symptomIndex')
  final Set<String> _checkedSymptoms = {};

  final List<String> _brainFilters = [
    'Все отделы',
    'Ствол мозга',
    'Мозжечок',
    'Паренхима (Белое в-во)',
    'Кора мозга',
  ];

  final List<BrainConstellation> _constellations = [
    // 1. СТВОЛ МОЗГА
    BrainConstellation(
      id: 'brainstem_const',
      title: '1. Констелляция Ствола мозга («Потеря путеводной нити»)',
      brainArea: 'Ствол мозга',
      areaColor: const Color(0xFFFBC02D),
      leftConflict: 'Левое полушарие ствола: активный конфликт «не могу избавиться от плохого куска» ИЛИ конфликт беженца/покинутости (левая почка).',
      rightConflict: 'Правое полушарие ствола: активный конфликт «не могу получить нужный кусок» ИЛИ конфликт существования (правая почка).',
      symptomsChecklist: [
        'Ощущение полной дезориентации и растерянности: «не знаю, куда идти и за что хвататься»',
        'Ступор и прокрастинация: сижу на одном месте и не могу принять элементарное решение',
        'Внезапная рассеянность и забывчивость («зашел в комнату и забыл зачем»)',
        'Чувство, что я «выброшен на берег», один в чужом и небезопасном мире',
      ],
      biologicalPurpose: 'Экстренно остановить движение особи («замереть на месте»), чтобы в состоянии паники человек не ушел еще дальше от источника безопасности и не растратил последние ресурсы.',
      exitStrategy: 'Чтобы мгновенно вернуть ясность ума, достаточно закрыть ХОТЯ БЫ ОДИН из двух конфликтов: создайте себе ощущение «безопасного дома здесь и сейчас» (теплая ванна, уют, финансовая определенность на ближайшие дни) или выплюньте одну старую обиду.',
    ),

    // 2. МОЗЖЕЧОК
    BrainConstellation(
      id: 'cerebellum_const',
      title: '2. Констелляция Мозжечка («Эмоциональный панцирь / Выгорание»)',
      brainArea: 'Мозжечок',
      areaColor: const Color(0xFFF57C00),
      leftConflict: 'Левое полушарие мозжечка: конфликт тревоги/заботы или атаки (для правши — в отношении партнера/работы).',
      rightConflict: 'Правое полушарие мозжечка: конфликт тревоги/заботы или атаки (для правши — в отношении ребенка/матери/дома).',
      symptomsChecklist: [
        'Ощущение «эмоциональной заморозки» и пустоты: вокруг всё рушится, а я ничего не чувствую',
        'Полное выгорание, отсутствие слез, сочувствия и радости («живу как робот на автопилоте»)',
        'Желание закрыться в панцирь, безразличие к чужим драмам и жалобам',
        'Одновременный завал проблемами и дома (дети/родители), и на работе/с партнером',
      ],
      biologicalPurpose: 'Анестезия души. Когда на человека нападают или требуют заботы с обеих сторон (и семья, и внешняя среда), мозг отключает эмоции, чтобы человек не «сгорел» от боли и мог хладнокровно выживать.',
      exitStrategy: 'Не вините себя за «бесчувственность» — это ваша защита! Разгрузите одну из двух сторон: делегируйте часть заботы о близких ИЛИ временно дистанцируйтесь от конфликта с партнером/работой.',
    ),

    // 3. ПАРЕНХИМА (НОВАЯ МЕЗОДЕРМА)
    BrainConstellation(
      id: 'medulla_megalomania',
      title: '3. Констелляция «Мегаломания» (Гиперкомпенсация самооценки)',
      brainArea: 'Паренхима (Белое в-во)',
      areaColor: const Color(0xFFE65100),
      leftConflict: 'Левое полушарие паренхимы: активный конфликт самообесценивания (КСО) по линии партнера/социума.',
      rightConflict: 'Правое полушарие паренхимы: активный конфликт самообесценивания (КСО) по линии матери/ребенка.',
      symptomsChecklist: [
        'Режим «Супергероя»: ощущение, что я должен и могу вытянуть вообще всё без сна и отдыха',
        'Болезненное непринятие любой помощи или критики («я сам знаю как лучше, все вокруг некомпетентны»)',
        'Постоянная гонка за достижениями, чтобы доказать миру свою значимость',
        'Страх остановиться хотя бы на день (кажется, что если остановлюсь — всё рухнет)',
      ],
      biologicalPurpose: 'Когда человек получает двойной удар по самооценке (и как родитель/ребенок, и как партнер/профессионал), мозг включает «Мегаломанию» — мощный допинг грандиозности, чтобы человек не сломался, а пробил стену.',
      exitStrategy: 'Осознайте, что за вашим «всемогуществом» прячутся две раненые зоны самооценки. Позвольте себе быть «достаточно хорошим, а не идеальным» хотя бы в одной роли (например, дома с близкими).',
    ),

    // 4. КОРА МОЗГА — ПАРЯЩАЯ (ПОЛЕТНАЯ)
    BrainConstellation(
      id: 'cortex_flying',
      title: '4. Парящая (Полетная) констелляция (Уход из реальности)',
      brainArea: 'Кора мозга',
      areaColor: const Color(0xFFD32F2F),
      leftConflict: 'Левая височная доля (Реле гортани): активный конфликт сильного испуга / страха.',
      rightConflict: 'Правая височная доля (Реле бронхов): активный конфликт территориальной угрозы.',
      symptomsChecklist: [
        'Ощущение оторванности от земли и тела («живу в облаках, в своих мечтах и фантазиях»)',
        'Дереализация: реальный бытовой мир кажется каким-то ненастоящим, плоским или чужим',
        'Сильная тяга «улететь» в эзотерику, виртуальные миры, грезы вместо решения земных дел',
        'Частые сны о полетах, падении с высоты или ощущение головокружения/невесомости',
      ],
      biologicalPurpose: 'Когда в реальном мире одновременно очень страшно (гортань) и на вашу территорию давят (бронхи), мозг спасает психику тем, что «поднимает вас в воздух» над невыносимой реальностью.',
      exitStrategy: 'Верните себе чувство физической безопасности на своей территории (закройте дверь, наведите уют, обозначьте границы) и выполняйте практики заземления (контакт стоп с полом, теплая еда, массаж).',
    ),

    // 5. КОРА МОЗГА — БИО-АГРЕССИВНАЯ
    BrainConstellation(
      id: 'cortex_aggressive',
      title: '5. Био-агрессивная констелляция (Вспышки гнева / Аутоагрессия)',
      brainArea: 'Кора мозга',
      areaColor: const Color(0xFFD32F2F),
      leftConflict: 'Левая височная доля (Реле прямой кишки): конфликт идентичности («кто я? где мое место? кому я принадлежу?»).',
      rightConflict: 'Правая височная доля (Реле малой кривизны желудка / желчных протоков): конфликт территориальной злости и несправедливости.',
      symptomsChecklist: [
        'Внезапные вспышки ярости и гнева из-за мелочей («завожусь с пол-оборота»)',
        'Аутоагрессия: когда нельзя накричать на других, начинаю яростно грызть, наказывать или ранить самого себя',
        'Постоянное внутреннее кипение от несправедливости и желание со всеми спорить',
        'Ощущение, что меня выживают с моего места и со мной не считаются',
      ],
      biologicalPurpose: 'Когда животное загнано в угол и лишено своего места в стае, природа включает «режим берсерка» — бесстрашную ярость, чтобы отвоевать территорию и статус.',
      exitStrategy: 'Первым делом решите конфликт Идентичности (левое полушарие): примите твердое решение, где ваше место, на чьей вы стороне и чего именно вы хотите, перестав ждать одобрения от других.',
    ),

    // 6. КОРА МОЗГА — АУТИСТИЧЕСКАЯ
    BrainConstellation(
      id: 'cortex_autistic',
      title: '6. Аутистическая констелляция (Уход в «свою раковину»)',
      brainArea: 'Кора мозга',
      areaColor: const Color(0xFFD32F2F),
      leftConflict: 'Левая доля (Реле гортани): конфликт сильного испуга («онемел от страха»).',
      rightConflict: 'Правая доля (Реле желудка/желчного): конфликт территориальной злости и обиды.',
      symptomsChecklist: [
        'Острое желание закрыться в комнате, выключить телефон и ни с кем не разговаривать',
        'Социальное общение вызывает ступор и истощение («не трогайте меня все»)',
        'Сверхконцентрация на одном узком деле, порядке, числах или хобби, где всё предсказуемо',
        'Снаружи кажусь спокойным и холодным, но внутри — зажатый испуг и обида',
      ],
      biologicalPurpose: 'Изолировать человека от непредсказуемого и пугающего социума и направить весь фокус внимания на одну контролируемую задачу.',
      exitStrategy: 'Снимите конфликт испуга (реле гортани): позвольте себе проговорить или выписать на бумагу то, что вас напугало, или используйте технику «Снятие изолированности в СДХ».',
    ),

    // 7. КОРА МОЗГА — БУЛИМИЧЕСКАЯ
    BrainConstellation(
      id: 'cortex_bulimic',
      title: '7. Булимическая констелляция (Пищевые качели)',
      brainArea: 'Кора мозга',
      areaColor: const Color(0xFFD32F2F),
      leftConflict: 'Левое полушарие (Альфа-клетки поджелудочной железы): конфликт страха с отвращением/брезгливостью.',
      rightConflict: 'Правое полушарие (Малая кривизна желудка): конфликт территориальной злости («не могу переварить эту ситуацию в семье/на работе»).',
      symptomsChecklist: [
        'Постоянные качели между неконтролируемым «волчьим голодом» (тягой к сладкому) и тошнотой/отвращением к еде',
        'Стремление «заесть» злость или тревогу, после чего сразу наступает тяжесть в желудке и вина',
        'Желание очистить желудок или сесть на жесткую голодовку после срыва',
        'Ситуация в жизни, которая одновременно вызывает и гнев (злость), и брезгливое отвращение',
      ],
      biologicalPurpose: 'Из-за снижения глюкагона (левое полушарие) падает сахар в крови, что заставляет человека срочно искать еду, но спазмированный от территориальной злости желудок (правое полушарие) отказывается её принимать.',
      exitStrategy: 'Прекратите бороться с едой! Еда здесь — лишь следствие. Найдите в своей жизни человека или ситуацию, которые вызывают у вас одновременно «злость» и «отвращение», и выстройте с ними жесткую границу.',
    ),
  ];

  void _toggleSymptom(String constId, int index) {
    final key = '${constId}_$index';
    setState(() {
      if (_checkedSymptoms.contains(key)) {
        _checkedSymptoms.remove(key);
      } else {
        _checkedSymptoms.add(key);
      }
    });
  }

  void _clearAllChecks() {
    setState(() {
      _checkedSymptoms.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _constellations.where((c) {
      return _selectedBrainFilter == 'Все отделы' || c.brainArea == _selectedBrainFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Диагностика Констелляций', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        actions: [
          if (_checkedSymptoms.isNotEmpty)
            IconButton(
              tooltip: 'Сбросить отметки',
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: _clearAllChecks,
            ),
        ],
      ),
      body: Column(
        children: [
          // Верхняя поясняющая плашка и фильтр
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.indigo.shade200),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.hub, color: Colors.indigo, size: 22),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Формула констелляции: 1 конфликт в Левом полушарии + 1 конфликт в Правом = изменение состояния психики и поведения. Отметьте галочками свои состояния ниже:',
                          style: TextStyle(fontSize: 12.5, color: Colors.black87, height: 1.3),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _brainFilters.length,
                    itemBuilder: (context, index) {
                      final filter = _brainFilters[index];
                      final isSelected = _selectedBrainFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(filter),
                          selected: isSelected,
                          selectedColor: Colors.indigo,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontSize: 12.5,
                          ),
                          onSelected: (_) => setState(() => _selectedBrainFilter = filter),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Список карточек констелляций
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final item = filteredList[index];
                int matchCount = 0;
                for (int i = 0; i < item.symptomsChecklist.length; i++) {
                  if (_checkedSymptoms.contains('${item.id}_$i')) {
                    matchCount++;
                  }
                }
                final bool isHighProbability = matchCount >= 2;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: isHighProbability ? 4 : 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isHighProbability ? Colors.deepPurple : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: ExpansionTile(
                    initiallyExpanded: index == 0,
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    leading: CircleAvatar(
                      backgroundColor: item.areaColor,
                      child: const Icon(Icons.psychology_alt, color: Colors.white),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.5),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: item.areaColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.brainArea,
                                style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: item.areaColor),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Совпадений: $matchCount из ${item.symptomsChecklist.length}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isHighProbability ? Colors.deepPurple : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        if (isHighProbability) ...[
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.deepPurple.shade300),
                            ),
                            child: const Text(
                              '⚡ Высокая вероятность активной констелляции!',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                            ),
                          ),
                        ],
                      ],
                    ),
                    children: [
                      const Divider(),
                      // Схема двух полушарий
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue.shade200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('◀ ЛЕВОЕ ПОЛУШАРИЕ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.5, color: Colors.indigo)),
                                  const SizedBox(height: 4),
                                  Text(item.leftConflict, style: const TextStyle(fontSize: 12, height: 1.3)),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 24),
                            child: Icon(Icons.compare_arrows, color: Colors.deepPurple),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.orange.shade200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ПРАВОЕ ПОЛУШАРИЕ ▶', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.5, color: Colors.orange.shade900)),
                                  const SizedBox(height: 4),
                                  Text(item.rightConflict, style: const TextStyle(fontSize: 12, height: 1.3)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Проверьте себя (отметьте подходящие состояния):',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Чек-лист симптомов констелляции
                      ...List.generate(item.symptomsChecklist.length, (symIndex) {
                        final isChecked = _checkedSymptoms.contains('${item.id}_$symIndex');
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: InkWell(
                            onTap: () => _toggleSymptom(item.id, symIndex),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isChecked ? Colors.deepPurple.shade50 : Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isChecked ? Colors.deepPurple.shade300 : Colors.grey.shade300,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                                    color: isChecked ? Colors.deepPurple : Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      item.symptomsChecklist[symIndex],
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 8),
                      // Биологический смысл и Ключ к выходу
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '🛡️ Биологический смысл («Суперспособность»): ${item.biologicalPurpose}',
                              style: const TextStyle(fontSize: 12.5, color: Colors.black87, height: 1.35),
                            ),
                            const Divider(height: 14),
                            Text(
                              '🔑 Ключ к выходу из констелляции: ${item.exitStrategy}',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.green.shade900, height: 1.35),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ВКЛАДКА 4: ТЕХНИКИ И УПРАЖНЕНИЯ ДЛЯ ПРОРАБОТКИ КОНФЛИКТОВ
// ============================================================================
class PracticeTechnique {
  final String id;
  final String title;
  final String category;
  final String targetSymptoms;
  final String goal;
  final Color color;
  final String biologicalPrinciple;
  final List<String> steps;

  PracticeTechnique({
    required this.id,
    required this.title,
    required this.category,
    required this.targetSymptoms,
    required this.goal,
    required this.color,
    required this.biologicalPrinciple,
    required this.steps,
  });
}

class PracticesTab extends StatefulWidget {
  const PracticesTab({Key? key}) : super(key: key);

  @override
  State<PracticesTab> createState() => _PracticesTabState();
}

class _PracticesTabState extends State<PracticesTab> {
  String _selectedCategory = 'Все';
  final Set<String> _completedSteps = {};

  final List<String> _categories = [
    'Все',
    'Базовые (СДХ и Треки)',
    'Защита (Грибок, Дерма)',
    'Самооценка (Суставы, Спина)',
    'Разлука и Границы (Эктодерма)',
    'Кусковые (Горло, ЖКТ)',
    'Помощь телу в Пкл-фазе',
  ];

  final List<PracticeTechnique> _techniques = [
    PracticeTechnique(
      id: 'dhs_release',
      title: '1. Снятие изолированности в точке СДХ',
      category: 'Базовые (СДХ и Треки)',
      targetSymptoms: 'Универсальная практика для любого острого или застрявшего симптома',
      goal: 'Убрать один из 3 главных критериев СДХ — изолированность восприятия и подавленный инстинкт.',
      color: Colors.indigo,
      biologicalPrinciple: 'Наш древний мозг не отличает реальное действие от ярко прожитого в теле образа. Если в момент шока вы промолчали и «замерли» в одиночестве, программа продолжает работать.',
      steps: [
        'Шаг 1: Вспомните конкретную сцену (СДХ), после которой начался стресс или перед которой появился симптом.',
        'Шаг 2: Найдите в теле ощущение замирания (ком в горле, сжатие в груди, холод в животе). Какое чувство вы тогда спрятали?',
        'Шаг 3: Введите в эту сцену «Ресурсную фигуру» (защитника или взрослого себя), который берет вас за плечо и говорит: «Ты больше не один, я с тобой».',
        'Шаг 4: Сделайте то, что тело хотело сделать тогда: выскажите всё вслух, оттолкните руками воздух или позвольте себе заплакать.',
        'Шаг 5: Сделайте глубокий выдох и почувствуйте, как теплеют ладони — знак перехода в фазу разрешения.',
      ],
    ),
    PracticeTechnique(
      id: 'old_meso_shield',
      title: '2. «Биологический душ и Защитный купол»',
      category: 'Защита (Грибок, Дерма)',
      targetSymptoms: 'Грибок кожи и ногтей (микоз), акне, фурункулы, потливость',
      goal: 'Снять конфликт «запятнанности / грязи» и прекратить самоатаку (стыд за свое тело).',
      color: const Color(0xFFF57C00),
      biologicalPrinciple: 'Дерма (Старая мезодерма) утолщается и включает грибки тогда, когда мозг считает, что вы соприкасаетесь с чем-то «нечистым, унизительным» или когда вы сами испытываете брезгливость к своим ногам/коже.',
      steps: [
        'Шаг 1: Выпишите, что или кто в вашей жизни ощущается как «грязь» или нарушение границ (токсичное общение, чьи-то оскорбления, на которые вы «наступили»).',
        'Шаг 2: Мысленно снимите этот темный налет со своих стоп/кожи и скажите адресату: «Твои поступки и слова принадлежат тебе. Я к этому не прикасаюсь».',
        'Шаг 3: Встаньте в теплый душ (или сделайте солевую ванночку для ног), проговаривая телу: «Сейчас я стою в чистом, безопасном, своем пространстве».',
        'Шаг 4: Снятие вторичного конфликта (стыда): посмотрите на ноготь или кожу без отвращения и скажите: «Спасибо телу, что пыталось защитить меня. Мне больше не нужно защищаться, я принимаю себя».',
      ],
    ),
    PracticeTechnique(
      id: 'new_meso_kso',
      title: '3. «Снятие чужого рюкзака и Возврат опоры»',
      category: 'Самооценка (Суставы, Спина)',
      targetSymptoms: 'Боли в спине и пояснице, артрит, боли в плечах, коленях, связках',
      goal: 'Выйти из Конфликта самообесценивания (КСО) и остановить рецидивы боли в суставах.',
      color: const Color(0xFFE65100),
      biologicalPrinciple: 'Кости и суставы болят ТОЛЬКО в фазе восстановления. Но если во время боли человек злится на себя («я развалина»), он запускает новый КСО и делает боль хронической.',
      steps: [
        'Шаг 1: Определите по стороне тела: если болит слева (у правши) — перед каким ребенком/мамой вы чувствуете себя «плохим»? Если справа — перед каким партнером или на работе вы «не вытягиваете»?',
        'Шаг 2: Представьте все завышенные ожидания от вас в виде тяжелого каменного рюкзака за спиной.',
        'Шаг 3: Сделайте движение плечами, будто скидываете лямки рюкзака на пол. Скажите: «Я живой человек, а не функция. Я имею право чего-то не мочь и оставаться ценным».',
        'Шаг 4: Положите теплую ладонь на сустав или спину и скажите: «Эта боль — не разрушение, это процесс укрепления моей ткани после решения конфликта».',
      ],
    ),
    PracticeTechnique(
      id: 'ecto_separation',
      title: '4. «Насыщение контактом / Отталкивание»',
      category: 'Разлука и Границы (Эктодерма)',
      targetSymptoms: 'Дерматит, экзема, псориаз, крапивница, герпес',
      goal: 'Закрыть сенсорный конфликт разлуки в коре головного мозга через телесную память.',
      color: const Color(0xFFD32F2F),
      biologicalPrinciple: 'Кора мозга реагирует на потерю тактильного контакта («оторвали от кожи») или на принудительный неприятный контакт.',
      steps: [
        'Шаг 1: Внутренняя поверхность рук/тела — конфликт «хочу обнять». Внешняя сторона (локти, колени, спина) — конфликт «хочу оттолкнуть».',
        'Шаг 2 (Если не хватает тепла): Обнимите себя ладонями, ярко представьте любимого человека и напитайтесь ощущением тепла кожи.',
        'Шаг 3 (Если контакт навязан): Вытяните руки вперед и сделайте резкое отталкивающее движение со словами: «Стоп! Моя кожа — это моя граница».',
      ],
    ),
    PracticeTechnique(
      id: 'ecto_territory',
      title: '5. «Маркировка границ территории»',
      category: 'Разлука и Границы (Эктодерма)',
      targetSymptoms: 'Цистит, бронхит, ларингит, гастрит, желчные протоки',
      goal: 'Высвободить подавленную территориальную злость и восстановить границы.',
      color: const Color(0xFFD32F2F),
      biologicalPrinciple: 'В природе животное защищает территорию рыком (бронхи), злостью (желудок) или метками (мочевой пузырь).',
      steps: [
        'Шаг 1: Честно назовите «нарушителя границ»: кто вторгся в ваше пространство или указывает, как вам жить?',
        'Шаг 2: Сожмите кулаки и сделайте выдох с «рыком» из живота, выпуская зажатую в бронхах и желудке агрессию.',
        'Шаг 3: Обойдите свою комнату и проговорите: «Здесь мои правила. Я хозяйка (хозяин) этого пространства».',
      ],
    ),
    PracticeTechnique(
      id: 'endo_morsel',
      title: '6. «Биологическое выплевывание куска»',
      category: 'Кусковые (Горло, ЖКТ)',
      targetSymptoms: 'Ангина, тонзиллит, ком в горле, СРК, вздутие, отит',
      goal: 'Завершить застрявший рефлекс глотания или отторжения ситуации.',
      color: const Color(0xFFFBC02D),
      biologicalPrinciple: 'Ствол мозга воспринимает застрявшую обиду или подлый поступок буквально как несъедобный кусок пищи.',
      steps: [
        'Шаг 1: Определите, что вам пришлось «проглотить» и промолчать.',
        'Шаг 2: Наберите чистую воду в рот, мысленно поместите в неё всю неприятную ситуацию и с силой ВЫПЛЮНЬТЕ в раковину со словами: «Я не обязан(а) это глотать и переваривать!».',
      ],
    ),
    PracticeTechnique(
      id: 'break_tracks',
      title: '7. Техника «Разрыв Трека» (Выход из хроники)',
      category: 'Базовые (СДХ и Треки)',
      targetSymptoms: 'Аллергия, хронический гастрит, мигрень, сезонные обострения',
      goal: 'Разорвать условный рефлекс между безопасным стимулом (едой, погодой) и запуском СБП.',
      color: Colors.purple,
      biologicalPrinciple: 'В момент шока (СДХ) мозг фотографирует обстановку вокруг (еду, холод, пыльцу) и позже включает симптом при встрече с этим «треком».',
      steps: [
        'Шаг 1: Выявите свой «трек»: на что вы привыкли сваливать обострение? («продуло», «съел не то»).',
        'Шаг 2: Вспомните самый ПЕРВЫЙ раз, когда этот трек совпал с реальным эмоциональным стрессом.',
        'Шаг 3: Скажите своему телу: «Холод / еда — это просто нейтральная природа. А тот старый конфликт УЖЕ В ПРОШЛОМ, сейчас я в безопасности».',
      ],
    ),
    PracticeTechnique(
      id: 'pcl_body_support',
      title: '8. Физиологическая поддержка в Пкл-фазе',
      category: 'Помощь телу в Пкл-фазе',
      targetSymptoms: 'Отеки, воспаления, температура, прохождение Эпикризиса',
      goal: 'Мягко помочь телу пройти фазу восстановления и снизить отек.',
      color: Colors.teal,
      biologicalPrinciple: '90% симптомов возникают на стадии заживления с отеком (Пкл-А). Главное — не пугаться симптома, чтобы не задерживать воду (Синдром собирательных трубочек почек).',
      steps: [
        'Шаг 1: Снимите панику: напомните себе, что воспаление — это ремонт ткани после решения конфликта.',
        'Шаг 2: Осмотические солевые ванны: теплая ванна с 1% раствором соли (около 1 кг соли на 100 л воды) мягко вытягивает лишнюю жидкость и снижает отек.',
        'Шаг 3: Спите на высокой подушке и прикладывайте прохладный компресс ко лбу при головной боли или Эпикризисе.',
      ],
    ),
  ];

  void _toggleStep(String techId, int stepIndex) {
    final key = '${techId}_$stepIndex';
    setState(() {
      if (_completedSteps.contains(key)) {
        _completedSteps.remove(key);
      } else {
        _completedSteps.add(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredTechniques = _techniques.where((t) {
      return _selectedCategory == 'Все' || t.category == _selectedCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Техники работы с симптомом', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: Colors.indigo,
                      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontSize: 13),
                      onSelected: (_) => setState(() => _selectedCategory = cat),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredTechniques.length,
              itemBuilder: (context, index) {
                final tech = filteredTechniques[index];
                int completedCount = 0;
                for (int i = 0; i < tech.steps.length; i++) {
                  if (_completedSteps.contains('${tech.id}_$i')) completedCount++;
                }

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ExpansionTile(
                    initiallyExpanded: index == 0,
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    leading: CircleAvatar(
                      backgroundColor: tech.color,
                      child: const Icon(Icons.self_improvement, color: Colors.white),
                    ),
                    title: Text(tech.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.5)),
                    subtitle: Text(
                      'Выполнено шагов: $completedCount из ${tech.steps.length}',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: tech.color),
                    ),
                    children: [
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: tech.color.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('🧠 Принцип ГНМ: ${tech.biologicalPrinciple}', style: const TextStyle(fontSize: 13)),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(tech.steps.length, (stepIndex) {
                        final isDone = _completedSteps.contains('${tech.id}_$stepIndex');
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: InkWell(
                            onTap: () => _toggleStep(tech.id, stepIndex),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isDone ? Colors.green.shade50 : Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: isDone ? Colors.green.shade400 : Colors.grey.shade300),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                                    color: isDone ? Colors.green.shade700 : Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      tech.steps[stepIndex],
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        decoration: isDone ? TextDecoration.lineThrough : null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ВКЛАДКА 5: СПРАВОЧНИК ГНМ (КОМПАС ХАМЕРА И ТАБЛИЦА ЛИСТКОВ)
// ============================================================================
class ReferenceTab extends StatelessWidget {
  const ReferenceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шпаргалка: Компас Хамера', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.indigo.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('👏 Правило Латеральности (Мозжечок, Паренхима, Кора):', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                    SizedBox(height: 6),
                    Text('• ПРАВША: Левая сторона тела = Мать/Ребенок. Правая сторона = Партнер (муж, жена, друзья, коллеги, отец).'),
                    SizedBox(height: 4),
                    Text('• ЛЕВША: Всё наоборот! Правая сторона = Мать/Ребенок. Левая сторона = Партнер.'),
                    SizedBox(height: 4),
                    Text('• СТВОЛ МОЗГА (Энтодерма): Латеральность рук не работает! Правая сторона = получить нужный кусок, Левая = избавиться от куска.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              '2-й Закон: Двухфазность всех СБП',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 170,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: TwoPhaseDiagramPainter(),
                      ),
                    ),
                    const Divider(height: 24),
                    _buildPhaseLegend(
                      color: Colors.blue.shade700,
                      title: 'КА-фаза (Активный конфликт)',
                      desc: 'Холодные руки, бессонница, навязчивые мысли о проблеме (симпатикотония).',
                    ),
                    const SizedBox(height: 6),
                    _buildPhaseLegend(
                      color: Colors.red.shade600,
                      title: 'Пкл-А (Фаза восстановления А)',
                      desc: 'После решения (КЛ). Отек, воспаление, температура, боли, слабость (ваготония).',
                    ),
                    const SizedBox(height: 6),
                    _buildPhaseLegend(
                      color: Colors.purple,
                      title: 'Эпикризис (ЭК)',
                      desc: 'Краткий возврат симптомов стресса (озноб, спазмы, кашель, кризис) для выжимания отека.',
                    ),
                    const SizedBox(height: 6),
                    _buildPhaseLegend(
                      color: Colors.orange.shade800,
                      title: 'Пкл-Б (Фаза рубцевания)',
                      desc: 'Спад отека, мочеиспускание, рубцевание и возврат сил.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              '3-й Закон: Поведение тканей',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 12),

            _buildGermLayerCard(
              title: '1. ЭНТОДЕРМА',
              brainPart: 'Ствол мозга (Древний мозг)',
              headerColor: const Color(0xFFFBC02D),
              textColor: Colors.black87,
              conflicts: '«Кусковые» конфликты (еда, воздух, кусок информации/денег). ЖКТ, альвеолы легких, миндалины, печень, собирательные трубочки почек.',
              caPhase: '➕ РОСТ ТКАНИ (плюс-ткань). Усиление функции.',
              pclPhase: '➖ РАСПАД ОПУХОЛИ (гной, ночной пот, температура).',
              microbes: 'Грибки и микобактерии.',
            ),

            _buildGermLayerCard(
              title: '2. СТАРАЯ МЕЗОДЕРМА',
              brainPart: 'Мозжечок (Древний мозг)',
              headerColor: const Color(0xFFF57C00),
              textColor: Colors.white,
              conflicts: 'Конфликты атаки, защиты, грязи и заботы о гнезде (дерма кожи, молочные железы, плевра, брюшина).',
              caPhase: '➕ РОСТ ТКАНИ (утолщение, узелок в груди, меланома).',
              pclPhase: '➖ РАСПАД ТКАНИ (гнойники, грибок, воспаление) или инкапсуляция.',
              microbes: 'Грибки, микобактерии и бактерии.',
            ),

            _buildGermLayerCard(
              title: '3. НОВАЯ МЕЗОДЕРМА',
              brainPart: 'Паренхима / Белое вещество (Новый мозг)',
              headerColor: const Color(0xFFE65100),
              textColor: Colors.white,
              conflicts: 'Конфликты самообесценивания (КСО): «я слабый, я не справляюсь» (кости, суставы, мышцы, связки, лимфоузлы, сосуды).',
              caPhase: '➖ УБЫЛЬ ТКАНИ (некроз, остеолиз). Протекает бессимптомно.',
              pclPhase: '➕ РОСТ И ВОССТАНОВЛЕНИЕ (сильный отек, растяжение надкостницы, сильные боли). В итоге ткань становится крепче.',
              microbes: 'Бактерии.',
            ),

            _buildGermLayerCard(
              title: '4. ЭКТОДЕРМА',
              brainPart: 'Кора головного мозга (Новый мозг)',
              headerColor: const Color(0xFFD32F2F),
              textColor: Colors.white,
              conflicts: 'Конфликты разлуки, территориальные конфликты (страх, агрессия, границы). Эпидермис кожи, бронхи, протоки, слизистая носа и желудка.',
              caPhase: '➖ ИЗЪЯЗВЛЕНИЕ (минус-ткань) ИЛИ изменение функции (паралич, диабет, снижение слуха).',
              pclPhase: '➕ ВОССТАНОВЛЕНИЕ ТКАНИ (покраснение, сыпь, зуд, насморк, отек).',
              microbes: 'Вирусы (условно).',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseLegend({required Color color, required String title, required String desc}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13, color: Colors.black87),
              children: [
                TextSpan(text: '$title: ', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                TextSpan(text: desc),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGermLayerCard({
    required String title,
    required String brainPart,
    required Color headerColor,
    required Color textColor,
    required String conflicts,
    required String caPhase,
    required String pclPhase,
    required String microbes,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: headerColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: textColor)),
                Text('Управление: $brainPart', style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.9))),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('🎯 Конфликты и органы:', conflicts),
                const Divider(height: 14),
                _buildInfoRow('❄️ КА-фаза:', caPhase, highlightColor: Colors.blue.shade800),
                const SizedBox(height: 6),
                _buildInfoRow('🔥 Пкл-фаза:', pclPhase, highlightColor: Colors.red.shade800),
                const Divider(height: 14),
                _buildInfoRow('🦠 Микробы:', microbes),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? highlightColor}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
        children: [
          TextSpan(
            text: '$label ',
            style: TextStyle(fontWeight: FontWeight.bold, color: highlightColor ?? Colors.black),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

// --- ОТРИСОВЩИК ДВУХФАЗНОЙ КРИВОЙ ХАМЕРА ---
class TwoPhaseDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double midY = size.height / 2;
    final double w = size.width;
    final double h = size.height;

    final axisPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(0, midY), Offset(w, midY), axisPaint);

    final double dhsX = w * 0.15;
    final double clX = w * 0.48;
    final double ecX = w * 0.70;
    final double endX = w * 0.92;

    final caPath = Path()
      ..moveTo(dhsX, midY)
      ..quadraticBezierTo((dhsX + clX) / 2, h * 0.05, clX, midY);

    canvas.drawPath(caPath, Paint()..color = Colors.blue.withOpacity(0.25)..style = PaintingStyle.fill);
    canvas.drawPath(caPath, Paint()..color = Colors.blue.shade700..strokeWidth = 3..style = PaintingStyle.stroke);

    final pclPath = Path()
      ..moveTo(clX, midY)
      ..quadraticBezierTo((clX + ecX - 15) / 2, h * 0.95, ecX - 12, midY)
      ..lineTo(ecX, h * 0.18)
      ..lineTo(ecX + 12, midY)
      ..quadraticBezierTo((ecX + 12 + endX) / 2, h * 0.85, endX, midY);

    canvas.drawPath(pclPath, Paint()..color = Colors.red.withOpacity(0.2)..style = PaintingStyle.fill);
    canvas.drawPath(pclPath, Paint()..color = Colors.red.shade600..strokeWidth = 3..style = PaintingStyle.stroke);

    _drawText(canvas, '⚡ СДХ', Offset(dhsX - 18, midY + 6), Colors.indigo, FontWeight.bold);
    _drawText(canvas, 'КА-фаза', Offset((dhsX + clX) / 2 - 25, midY - 35), Colors.blue.shade900, FontWeight.bold);
    _drawText(canvas, '⚡ КЛ', Offset(clX - 12, midY - 22), Colors.green.shade800, FontWeight.bold);
    _drawText(canvas, 'Пкл-А', Offset(clX + 12, midY + 25), Colors.red.shade900, FontWeight.normal);
    _drawText(canvas, 'ЭК', Offset(ecX - 8, h * 0.02), Colors.purple, FontWeight.bold);
    _drawText(canvas, 'Пкл-Б', Offset(ecX + 22, midY + 20), Colors.red.shade900, FontWeight.normal);
  }

  void _drawText(Canvas canvas, String text, Offset position, Color color, FontWeight weight) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(color: color, fontSize: 12, fontWeight: weight)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
