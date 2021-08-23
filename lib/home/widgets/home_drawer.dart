import '../../exports.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            // decoration: BoxDecoration(
            //   color: Colors.red,
            // ),
            accountName: Text('aaa'),
            accountEmail: Text('aaa'),
            arrowColor: Colors.amber,
            // currentAccountPicture: CircleAvatar(
            //   backgroundColor: Colors.amber,
            //   // foregroundImage: ResizeImage(
            //   //   NetworkImage(
            //   //     'https://avatars.githubusercontent.com/u/18013127?v=4',
            //   //   ),
            //   //   width: 50,
            //   //   height: 50,
            //   // ),
            //   radius: 20.0,
            // ),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text('Theme'),
            onTap: () => Navigator.pushNamed(context, "themes"),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('Language'),
            onTap: () => Navigator.pushNamed(context, "language"),
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: Text('Logout'),
            onTap: () => Navigator.pushNamed(context, "language"),
          ),
        ],
      ),
    );
  }
}
