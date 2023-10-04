import 'package:flutter/material.dart';

class OneLineListTile extends StatelessWidget {
  const OneLineListTile(
      {Key? key, required this.title, this.onTap, this.trailing})
      : super(key: key);

  final String title;
  final String? trailing;
  final void Function()? onTap;

  // ignore: todo
  //TODO apply glorifi ui kit
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 72,
          padding: const EdgeInsets.only(left: 24, right: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                color: Colors.black.withOpacity(0.1),
                blurRadius: 55,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff212C37),
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    trailing!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff212C37),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
