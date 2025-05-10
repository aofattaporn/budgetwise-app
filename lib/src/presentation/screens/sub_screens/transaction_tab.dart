import 'package:budget_wise/src/presentation/theme/system/app_text_style.dart';
import 'package:flutter/material.dart';

class TypographyShowcaseScreen extends StatelessWidget {
  const TypographyShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Typography Overview'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Display'),
          _buildTextSample('Display Large', AppTextStyles.displayLarge),
          _buildTextSample('Display Medium', AppTextStyles.displayMedium),
          _buildTextSample('Display Small', AppTextStyles.displaySmall),
          _buildTextSample(
              'Display PrimaryDark Large', AppTextStyles.displayPrimaryLarge),
          _buildTextSample(
              'Display PrimaryDark Medium', AppTextStyles.displayPrimaryMedium),
          _buildTextSample(
              'Display PrimaryDark Small', AppTextStyles.displayPrimarySmall),
          const SizedBox(height: 24),
          _buildSectionTitle('Headline'),
          _buildTextSample('Headline Large', AppTextStyles.headlineLarge),
          _buildTextSample('Headline Medium', AppTextStyles.headlineMedium),
          _buildTextSample('Headline Small', AppTextStyles.headlineSmall),
          const SizedBox(height: 24),
          _buildSectionTitle('Body'),
          _buildTextSample('Body Large', AppTextStyles.bodyLarge),
          _buildTextSample('Body Medium', AppTextStyles.bodyMedium),
          _buildTextSample('Body Small', AppTextStyles.bodySmall),
          const SizedBox(height: 24),
          _buildSectionTitle('Label'),
          _buildTextSample('Label Large', AppTextStyles.labelLarge),
          _buildTextSample('Label Medium', AppTextStyles.labelMedium),
          _buildTextSample('Label Small', AppTextStyles.labelSmall),
          _buildTextSample('Label Gray Small', AppTextStyles.labelGraySmall),
          _buildTextSample(
              'Label Primary Small', AppTextStyles.labelPrimarySmall),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: AppTextStyles.headlineLarge,
      ),
    );
  }

  Widget _buildTextSample(String label, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
