// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:gap/gap.dart';

class PuzzleSimple extends StatelessWidget {
  PuzzleSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: (context, child) => Column(
        children: [PuzzleMenu(), StartSection()],
      ),
      tablet: (context, child) => Column(
        children: [StartSection(), BoardSection(), EndSection()],
      ),
      desktop: (context, child) => Row(
        children: [StartSection(), BoardSection(), EndSection()],
      ),
    );
  }
}

class StartSection extends StatelessWidget {
  const StartSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: (context, child) => child!,
      tablet: (context, child) => child!,
      desktop: (context, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child!,
      ),
      child: () => SimpleStartSection(),
    );
  }
}

class BoardSection extends StatelessWidget {
  const BoardSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class EndSection extends StatelessWidget {
  const EndSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SimpleStartSection extends StatelessWidget {
  const SimpleStartSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(ResponsiveLayout.isMobile(context)
            ? 20
            : ResponsiveLayout.isTablet(context)
                ? 30
                : 150),
        PuzzleTitle(),
        Gap(ResponsiveLayout.isMobile(context)
            ? 5
            : ResponsiveLayout.isTablet(context)
                ? 10
                : 20),
        NumberOfMovesAndTilesLeft(
          numberOfMoves: 2,
          numberOfTilesLeft: 15,
        ),
      ],
    );
  }
}