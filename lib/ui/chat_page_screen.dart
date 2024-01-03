import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../commonWidgets/common_widgets.dart';
import '../utils/utils.dart';


@RoutePage()
class ChatPage extends StatefulWidget {
  final int? initialIndex;

  const ChatPage({super.key, this.initialIndex = 0});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController makeOfferController = TextEditingController();
  late  DefaultTabController tabController;
  List<Message> messages = [
    Message(
        text: 'hii',
        date: DateTime.now().subtract(const Duration(days: 10, minutes: 10)),
        isSendByMe: false),
    Message(
        text: 'Hii',
        date: DateTime.now().subtract(const Duration(days: 8, minutes: 8)),
        isSendByMe: true),
    Message(
        text: 'yenna doing',
        date: DateTime.now().subtract(const Duration(days: 5, minutes: 5)),
        isSendByMe: false),
    Message(
        text: 'summatha',
        date: DateTime.now().subtract(const Duration(days: 4, minutes: 4)),
        isSendByMe: true),
    Message(
        text: 'nega',
        date: DateTime.now().subtract(const Duration(days: 4, minutes: 4)),
        isSendByMe: false),
    Message(
        text: 'nana ipotha work muduche',
        date: DateTime.now().subtract(const Duration(days: 4, minutes: 4)),
        isSendByMe: true),
    Message(
        text: 'okey',
        date: DateTime.now().subtract(const Duration(days: 2, minutes: 2)),
        isSendByMe: false),
    Message(
        text: 'Mmm',
        date: DateTime.now().subtract(const Duration(days: 1, minutes: 1)),
        isSendByMe: true),
  ].reversed.toList();

  bool? isSendButton = false;
  var isShowEditContainer = true;
  String? typeMessage = '';

  changeState(bool value) {
    setState(() {
      isShowEditContainer = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: AppColorData.grey06,
              child: GroupedListView<Message, DateTime>(
                  reverse: true,
                  order: GroupedListOrder.DESC,
                  // useStickyGroupSeparators: true,
                  // floatingHeader: true,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  elements: messages,
                  groupBy: (message) => DateTime(
                    message.date.year,
                    message.date.month,
                    message.date.day,
                  ),
                  groupHeaderBuilder: (Message message) => SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(flex: 2, child: SizedBox.shrink()),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.transparent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              child: Text(
                                (message.date.day == DateTime.now().day)
                                    ? 'Today'
                                    : DateFormat.yMMMd().format(message.date),
                                style: TextStyle(
                                    color: AppColorData.grey03,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        const Expanded(flex: 2, child: SizedBox.shrink()
                        ),
                      ],
                    ),
                  ),
                  itemBuilder: (context, Message message) {
                    return Align(
                      alignment: message.isSendByMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child:
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 260,minWidth: 40,minHeight: 50,
                        ),
                        child: Container(
                         // height: 60,
                          color: AppColorData.transparent,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14.0),
                                child: Card(
                                  elevation: 0,
                                  color: (message.isSendByMe)?AppColorData.appPrimaryColor:AppColorData.appSecondaryColor,
                                  shape:  (message.isSendByMe)?
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(0)
                                      ))
                                      :const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(10)
                                      )),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                          maxWidth: 260,minWidth: 50,minHeight: 20,
                                      ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 12),
                                      child: Text(
                                        message.text,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color:
                                            (message.isSendByMe)?AppColorData.appSecondaryColor:AppColorData.appPrimaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: message.isSendByMe
                                      ?0 : 0,
                                right: message.isSendByMe
                                      ?6 : null,
                                left:  message.isSendByMe
                                      ? null: 6,
                                child: Container(
                                  color: AppColorData.transparent,
                                  child: Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            //DateFormat.jm().format(message.date),
                                            DateFormat('h:mm a').format(message.date),
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColorData.grey03,
                                            ),
                                          ),
                                        )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          chatTypingWidget()
        ],
      ),
    );
  }

  Widget chatTypingWidget() {
    return Container(
      color: AppColorData.grey06,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColorData.grey03,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IntrinsicHeight(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 90,
                          minHeight: 50,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            expands: true,
                            controller: textEditingController,
                            cursorColor: AppColorData.appPrimaryColor,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 16),
                              hintText: "Type here",
                              hintStyle: TextStyle(
                                  color: AppColorData.white03,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.attach_file_outlined)
                            ),

                            enableSuggestions: false,
                            autocorrect: false,
                            maxLines: null,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) {
                              setState(() {
                                if (value != '' && value.isNotEmpty) {
                                  typeMessage = value;
                                  isSendButton = true;
                                } else {
                                  isSendButton = false;
                                }
                              });
                            },
                            onSubmitted: (text) {
                              text = '$text\n';
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (typeMessage != '') {
                      final message = Message(
                          text: textEditingController.text,
                          date: DateTime.now(),
                          isSendByMe: true);
                      setState(() {
                        messages.add(message);
                        textEditingController.clear();
                        isSendButton = false;
                      });
                    } else {
                      null;
                    }
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: AppColorData.appPrimaryColor,
                  child: Icon(
                      (isSendButton!)
                          ? Icons.send_outlined
                          : Icons.keyboard_voice_rounded,
                      color: AppColorData.appSecondaryColor),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return CommonAppBar(
      backgroundColor: AppColorData.appSecondaryColor,
      isTitleWidget: true,
      centerTitle: false,
      elevation: 0,
      leadingWidth: 30,
      automaticallyImplyLeading: false,
      titleWidget: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              color: Colors.transparent,
              width: 50,
              height: 50,
              child: Image.network(
                  "https://cdn3.vectorstock.com/i/1000x1000/00/12/demo-vector-21910012.jpg",
                  fit: BoxFit.fill),
            ),
          ),
          const SizedBox( width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hinnen Blazz",
                  style: TextStyle(
                      color: AppColorData.appPrimaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20)),
              Text("Online",
                  style: TextStyle(
                      color: AppColorData.grey03,
                      fontWeight: FontWeight.w500,
                      fontSize: 17)),
            ],

          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Logger.appLogs("location is pressed");
            },
            splashRadius: 1,
            icon: SvgPicture.asset(SVGAssets.phoneIcon),)
      ],
    );
  }
}

class Message {
  final String text;
  final DateTime date;
  final bool isSendByMe;

  Message({required this.text, required this.date, required this.isSendByMe});
}
