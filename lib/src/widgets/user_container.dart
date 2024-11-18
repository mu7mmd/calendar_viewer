part of '../views/calendar_viewer.dart';

class _UserContainer extends StatelessWidget {
  const _UserContainer({
    required this.data,
    required this.style,
  });

  final CalendarReservationData data;
  final CalendarReservationStyle style;

  @override
  Widget build(BuildContext context) {
    final hasPrevious = data.hasPrevious;
    final hasNext = data.hasNext;
    final flex = data.weekDays;
    final user = data.user;

    final double startMargin;
    final double endMargin;
    final Radius startRadius;
    final Radius endRadius;
    final BorderSide startSide;
    final BorderSide endSide;

    if (hasPrevious) {
      startMargin = 0;
      startRadius = Radius.zero;
      startSide = BorderSide.none;
    } else {
      startMargin = style.horizontalMargin;
      startRadius = style.radius;
      startSide = style.side;
    }
    if (hasNext) {
      endMargin = 0;
      endRadius = Radius.zero;
      endSide = BorderSide.none;
    } else {
      endMargin = style.horizontalMargin;
      endRadius = style.radius;
      endSide = style.side;
    }

    return Container(
      height: style.height,
      width: double.infinity,
      margin: EdgeInsetsDirectional.only(
        start: startMargin,
        end: endMargin,
        bottom: style.bottomMargin,
        top: style.topMargin,
      ),
      padding: style.padding,
      decoration: BoxDecoration(
        color: style.color,
        gradient: style.gradient,
        border: BorderDirectional(
          start: startSide,
          end: endSide,
          top: style.side,
          bottom: style.side,
        ),
        boxShadow: style.boxShadow,
        borderRadius: BorderRadiusDirectional.horizontal(
          start: startRadius,
          end: endRadius,
        ),
      ),
      child: (!hasPrevious && style.showUserInStart) ||
              (hasPrevious && hasNext && style.showUserInMiddles) ||
              (!hasNext && style.showUserInEnd)
          ? flex == 1
              ? Center(
                  child: user.hasNetImage
                      ? Image.network(
                          user.netImage!,
                          height: style.userImageSize,
                          width: style.userImageSize,
                        )
                      : Image.asset(
                          user.assetImage!,
                          height: style.userImageSize,
                          width: style.userImageSize,
                        ),
                )
              : Row(
                  mainAxisAlignment: style.mainAxisAlignment,
                  children: [
                    if (user.hasNetImage) ...[
                      Image.network(
                        user.netImage!,
                        height: style.userImageSize,
                        width: style.userImageSize,
                      ),
                      const SizedBox(width: 4),
                    ] else if (user.hasAssetImage) ...[
                      Image.asset(
                        user.assetImage!,
                        height: style.userImageSize,
                        width: style.userImageSize,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Flexible(
                      child: Text(
                        user.name,
                        style: style.userNameTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
          : const SizedBox.shrink(),
    );
  }
}
