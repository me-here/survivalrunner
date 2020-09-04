import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survivalrunner/widgets/slider_button/slider_button_viewmodel.dart';

class SliderButton extends StatelessWidget {
  static const BORDER_RADIUS = 10.0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonWidth = screenSize.width / 2;
    return ChangeNotifierProvider(
      create: (context) => SliderButtonViewModel(),
      builder: (context, child) {
        return GestureDetector(
          onPanUpdate: (details) {
            final currentWidth =
                context.read<SliderButtonViewModel>().percentageFilled *
                    buttonWidth;
            if (currentWidth < 20 && details.delta.dx < 0) return;
            if (currentWidth > buttonWidth - 20 && details.delta.dx > 0) return;
            context
                .read<SliderButtonViewModel>()
                .changePercentageFilled(delta: details.delta.dx / buttonWidth);
          },
          child: Card(
            color: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
            ),
            elevation: 8,
            child: Container(
              width: buttonWidth,
              height: 60,
              child: Stack(
                children: [
                  _buildSliderOverlay(buttonWidth, context),
                  _runnerIcon,
                  _targetText(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _targetText(BuildContext context) {
    const MIN_TIME = 4.0;
    const MAX_TIME = 12.0;
    final pct = context.watch<SliderButtonViewModel>().percentageFilled;
    final selectedTime = pct * (MAX_TIME - MIN_TIME) + MIN_TIME;
    final mins = selectedTime.floor().toString();
    final secsInt = (selectedTime % 1 * 60).floor();
    final secs = secsInt < 10 ? "0$secsInt" : "$secsInt";
    final targetTime = '$mins:$secs';

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Target: ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            targetTime,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _runnerIcon {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.all(8),
      child: Image.asset(
        'assets/images/runner_icon.png',
        color: Colors.white,
      ),
    );
  }

  Widget _buildSliderOverlay(double buttonWidth, BuildContext context) {
    final pct = context.watch<SliderButtonViewModel>().percentageFilled;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(BORDER_RADIUS),
        ),
        color: Color.lerp(Colors.green, Colors.red, pct),
      ),
      width: buttonWidth * pct,
    );
  }
}
