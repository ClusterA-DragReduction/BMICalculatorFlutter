# BMI Calculator Flutter

一个简洁大方的 BMI 计算器应用，支持多种精美背景切换。

## 功能特点

- **BMI 计算**：输入身高(cm)和体重(kg)自动计算 BMI 值
- **8种精美背景**：梦幻紫、清新绿、日落橙、海洋蓝、温暖黄、深邃紫、淡雅粉、自然绿
- **结果可视化**：显示 BMI 值、健康分类及颜色标识
- **参考标准**：展示中国 BMI 分类标准表

## 技术栈

- **框架**：Flutter 3.x
- **语言**：Dart
- **设计规范**：Material Design 3

## 获取应用

### iOS (苹果手机)

1. 安装 Flutter SDK: https://flutter.dev/docs/get-started/install
2. 克隆仓库并运行:
```bash
git clone https://github.com/ClusterA-DragReduction/BMICalculatorFlutter.git
cd BMICalculatorFlutter
flutter pub get
flutter run
```

### GitHub Actions 自动构建

1. 前往 https://github.com/ClusterA-DragReduction/BMICalculatorFlutter/actions
2. 运行 Workflow
3. 下载构建产物

## BMI 计算标准

| 分类 | BMI 范围 | 颜色 |
|------|---------|------|
| 偏瘦 | < 18.5 | 蓝色 |
| 正常 | 18.5 - 23.9 | 绿色 |
| 偏胖 | 24.0 - 27.9 | 黄色 |
| 肥胖 | ≥ 28.0 | 红色 |

## 许可证

MIT License