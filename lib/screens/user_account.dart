import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/screens/chat_rooms.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  static const routeName = '/user-account-screen';

  @override
  UserAccountState createState() => UserAccountState();
}

class UserAccountState extends State<UserAccount> {
  String loremIpsum =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ';

  void openChatRoom() {
    Navigator.of(context).pushNamed(ChatRooms.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(
        Icons.account_circle_outlined,
        color: Colors.green[700],
        size: MediaQuery.of(context).size.width * 0.4,
      ),

      // space between icon and name
      const SizedBox(height: 10),

      const Text(
        'Ferko Mrkvicka',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 200),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 173, 173, 173),
          ),
          child: ExpandablePanel(
            header: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 173, 173, 173)),
              child: const Padding(
                padding: EdgeInsets.only(top: 12, left: 15),
                child: Text(
                  'Preferences',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            collapsed: const Text(''),
            expanded: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 204, 204, 204)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  List.generate(5, (_) => loremIpsum).join('\n\n'),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            builder: (_, collapsed, expanded) =>
                Expandable(collapsed: collapsed, expanded: expanded),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 173, 173, 173),
          ),
          child: ExpandablePanel(
            header: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 173, 173, 173)),
              child: const Padding(
                padding: EdgeInsets.only(top: 12, left: 15),
                child: Text(
                  'Account settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            collapsed: const Text(''),
            expanded: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 204, 204, 204)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  List.generate(5, (_) => loremIpsum).join('\n\n'),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            builder: (_, collapsed, expanded) =>
                Expandable(collapsed: collapsed, expanded: expanded),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 173, 173, 173),
          ),
          child: ExpandablePanel(
            header: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 173, 173, 173)),
              child: const Padding(
                padding: EdgeInsets.only(top: 12, left: 15),
                child: Text(
                  'Favorite items',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            collapsed: const Text(''),
            expanded: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 204, 204, 204)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  List.generate(5, (_) => loremIpsum).join('\n\n'),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            builder: (_, collapsed, expanded) =>
                Expandable(collapsed: collapsed, expanded: expanded),
          ),
        ),
      ),

      Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 173, 173, 173),
          ),
          child: ExpandablePanel(
            header: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 173, 173, 173),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 12, left: 15),
                child: Text(
                  'Help',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            collapsed: const Text(''),
            expanded: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 204, 204, 204),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Write us an email:',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Text(
                      'support@armyshop.xd',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Or',
                      style: TextStyle(fontSize: 18),
                    ),
                    MyButton(text: 'Chat with us', onTap: openChatRoom),
                  ],
                ),
              ),
            ),
            builder: (_, collapsed, expanded) =>
                Expandable(collapsed: collapsed, expanded: expanded),
          ),
        ),
      ),
    ]);
  }
}
