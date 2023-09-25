import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget {
  const CardListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 18, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 300,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 16),
          buildImage(),
          const SizedBox(height: 16),
          _buildText(),
          const SizedBox(height: 16),
          Container(
            width: 300,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) =>
                  productLoadingItem(context: context),
              itemCount: 20,
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 250,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
    );
  }

  Widget productLoadingItem({
    required BuildContext context,
  }) =>
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(13)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.13,
            color: Colors.grey,
          ),
        ),
      );
}
