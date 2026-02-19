import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedBackgroundIndex = 0;
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  double? bmiResult;

  final List<Map<String, dynamic>> backgrounds = [
    {'name': '梦幻紫', 'colors': [const Color(0xFF667eea), const Color(0xFF764ba2)]},
    {'name': '清新绿', 'colors': [const Color(0xFF11998e), const Color(0xFF38ef7d)]},
    {'name': '日落橙', 'colors': [const Color(0xFFf093fb), const Color(0xFFf5576c)]},
    {'name': '海洋蓝', 'colors': [const Color(0xFF4facfe), const Color(0xFF00f2fe)]},
    {'name': '温暖黄', 'colors': [const Color(0xFFfa709a), const Color(0xFFfee140)]},
    {'name': '深邃紫', 'colors': [const Color(0xFF30cfd0), const Color(0xFF330867)]},
    {'name': '淡雅粉', 'colors': [const Color(0xFFa8edea), const Color(0xFFfed6e3)]},
    {'name': '自然绿', 'colors': [const Color(0xFFd4fc79), const Color(0xFF96e6a1)]},
  ];

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void calculateBMI() {
    final height = double.tryParse(heightController.text);
    final weight = double.tryParse(weightController.text);
    if (height != null && weight != null && height > 0) {
      setState(() {
        bmiResult = weight / ((height / 100) * (height / 100));
      });
    }
  }

  (String, Color) getBMICategory(double bmi) {
    if (bmi < 18.5) return ('偏瘦', const Color(0xFF5B8FF9));
    if (bmi < 24.0) return ('正常', const Color(0xFF5AD8A6));
    if (bmi < 28.0) return ('偏胖', const Color(0xFFF6BD16));
    return ('肥胖', const Color(0xFFE8684A));
  }

  @override
  Widget build(BuildContext context) {
    final currentGradient = backgrounds[selectedBackgroundIndex];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: currentGradient['colors'] as List<Color>,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'BMI 计算器',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.palette, color: Colors.white),
                      onPressed: () => _showBackgroundPicker(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildInputCard(),
                      const SizedBox(height: 24),
                      if (bmiResult != null) _buildResultCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: heightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: '身高 (cm)',
              hintText: '例如: 175',
              prefixIcon: const Icon(Icons.height, color: Colors.deepPurple),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: '体重 (kg)',
              hintText: '例如: 70',
              prefixIcon: const Icon(Icons.monitor_weight, color: Colors.deepPurple),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                '计算 BMI',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    final (category, color) = getBMICategory(bmiResult!);

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '您的 BMI',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            bmiResult!.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildReferenceTable(),
        ],
      ),
    );
  }

  Widget _buildReferenceTable() {
    final categories = [
      ('偏瘦', '< 18.5', const Color(0xFF5B8FF9)),
      ('正常', '18.5 - 23.9', const Color(0xFF5AD8A6)),
      ('偏胖', '24.0 - 27.9', const Color(0xFFF6BD16)),
      ('肥胖', '≥ 28.0', const Color(0xFFE8684A)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BMI 参考标准',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        ...categories.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: item.$3,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item.$1,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                item.$2,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  void _showBackgroundPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '选择背景',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(backgrounds.length, (index) {
                final bg = backgrounds[index];
                final isSelected = index == selectedBackgroundIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedBackgroundIndex = index);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 72) / 2,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: bg['colors'] as List<Color>,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: isSelected
                          ? Border.all(color: Colors.deepPurple, width: 3)
                          : null,
                      boxShadow: isSelected
                          ? [BoxShadow(color: Colors.deepPurple.withOpacity(0.3), blurRadius: 8)]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        bg['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}