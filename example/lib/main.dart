import 'package:appcenter_release_manager/appcenter_release_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const apiToken = '';
const preDefinedOwnerName = '';
const preDefinedAppName = '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _index = 0;

  late AppCenterReleaseManager _appCenterReleaseManager;

  @override
  void initState() {
    super.initState();
    _appCenterReleaseManager = AppCenterReleaseManager(apiToken: apiToken);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: const Text('Plugin example app'),
        ),
        body: IndexedStack(
          index: _index,
          children: [
            OwnerList(appCenterReleaseManager: _appCenterReleaseManager),
            AppList(appCenterReleaseManager: _appCenterReleaseManager),
            AppCenterReleaseManagerLatestReleases(
              apiToken: _appCenterReleaseManager.apiToken,
              ownerName: preDefinedOwnerName,
              appName: preDefinedAppName,
            ),
            UserDetails(appCenterReleaseManager: _appCenterReleaseManager),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (value) => setState(() => _index = value),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Owners',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Apps',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: preDefinedAppName,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'User Details',
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetails extends StatefulWidget {
  final AppCenterReleaseManager appCenterReleaseManager;

  const UserDetails({
    required this.appCenterReleaseManager,
    super.key,
  });

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Name: ${_user?.name}'),
        Text('displayName: ${_user?.displayName}'),
        Text('origin: ${_user?.origin}'),
        Text('avatarUrl: ${_user?.avatarUrl}'),
        Text('createdAt: ${_user?.createdAt}'),
        Text('canChangePassword: ${_user?.canChangePassword}'),
      ],
    );
  }

  Future<void> _getUserDetails() async {
    _user = await widget.appCenterReleaseManager.getUserDetails();
    setState(() {});
  }
}

class OwnerList extends StatefulWidget {
  final AppCenterReleaseManager appCenterReleaseManager;

  const OwnerList({
    required this.appCenterReleaseManager,
    super.key,
  });

  @override
  State<OwnerList> createState() => _OwnerListState();
}

class _OwnerListState extends State<OwnerList> {
  var _list = <Owner>[];

  @override
  void initState() {
    super.initState();
    _getApps();
  }

  Future<void> _getApps() async {
    _list = await widget.appCenterReleaseManager.getAllOrganizations();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context, index) {
        final item = _list[index];
        return ListTile(
          leading: Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(4),
            child: item.avatarUrl == null ? const Placeholder() : Image.network(item.avatarUrl!),
          ),
          title: Text(item.name),
          onTap: () => Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (context) => OwnerAppList(
                appCenterReleaseManager: widget.appCenterReleaseManager,
                owner: item,
              ),
            ),
          ),
        );
      },
    );
  }
}

class OwnerAppList extends StatefulWidget {
  final AppCenterReleaseManager appCenterReleaseManager;
  final Owner owner;

  const OwnerAppList({
    required this.appCenterReleaseManager,
    required this.owner,
    super.key,
  });

  @override
  State<OwnerAppList> createState() => _OwnerAppListState();
}

class _OwnerAppListState extends State<OwnerAppList> {
  var _list = <App>[];

  @override
  void initState() {
    super.initState();
    _getApps();
  }

  Future<void> _getApps() async {
    _list = await widget.appCenterReleaseManager.getAllApps(ownerName: widget.owner.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(widget.owner.name),
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final item = _list[index];
          return ListTile(
            leading: Container(
              width: 64,
              height: 64,
              padding: const EdgeInsets.all(4),
              child: item.iconUrl == null ? const Placeholder() : Image.network(item.iconUrl!),
            ),
            title: Text(item.name),
            onTap: () => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => AppDetail(
                  appCenterReleaseManager: widget.appCenterReleaseManager,
                  app: item,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AppList extends StatefulWidget {
  final AppCenterReleaseManager appCenterReleaseManager;

  const AppList({
    required this.appCenterReleaseManager,
    super.key,
  });

  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  var _list = <App>[];

  @override
  void initState() {
    super.initState();
    _getApps();
  }

  Future<void> _getApps() async {
    _list = await widget.appCenterReleaseManager.getAllApps();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context, index) {
        final item = _list[index];
        return ListTile(
          leading: Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(4),
            child: item.iconUrl == null ? const Placeholder() : Image.network(item.iconUrl!),
          ),
          title: Text(item.name),
          onTap: () => Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (context) => AppDetail(
                appCenterReleaseManager: widget.appCenterReleaseManager,
                app: item,
              ),
            ),
          ),
        );
      },
    );
  }
}

class AppDetail extends StatefulWidget {
  final AppCenterReleaseManager appCenterReleaseManager;
  final App app;

  const AppDetail({
    required this.appCenterReleaseManager,
    required this.app,
    super.key,
  });

  @override
  State<AppDetail> createState() => _AppDetailState();
}

class _AppDetailState extends State<AppDetail> {
  var _list = <Release>[];

  @override
  void initState() {
    super.initState();
    _getApps();
  }

  Future<void> _getApps() async {
    final name = widget.app.owner?.name;
    if (name == null) return;
    _list = await widget.appCenterReleaseManager.getReleases(name, widget.app.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(widget.app.name),
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final item = _list[index];
          return ListTile(
            title: Text('${item.shortVersion} (${item.version})'),
            subtitle: Text(item.uploadedAt?.toIso8601String() ?? ''),
            onTap: () => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => ReleaseDetailScreen(
                  appCenterReleaseManager: widget.appCenterReleaseManager,
                  app: widget.app,
                  release: item,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ReleaseDetailScreen extends StatefulWidget {
  final AppCenterReleaseManager appCenterReleaseManager;
  final App app;
  final Release release;

  const ReleaseDetailScreen({
    required this.appCenterReleaseManager,
    required this.app,
    required this.release,
    super.key,
  });

  @override
  State<ReleaseDetailScreen> createState() => _ReleaseDetailScreenState();
}

class _ReleaseDetailScreenState extends State<ReleaseDetailScreen> {
  ReleaseDetail? _details;

  @override
  void initState() {
    super.initState();
    _getApps();
  }

  Future<void> _getApps() async {
    final name = widget.app.owner?.name;
    if (name == null) return;
    _details = await widget.appCenterReleaseManager.getReleaseDetails(name, widget.app.name, widget.release.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(widget.app.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _details == null
            ? []
            : [
                Text(_details!.uploadedAt?.toIso8601String() ?? ''),
                Text('${_details!.shortVersion} (${_details!.version})'),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () => widget.appCenterReleaseManager.installRelease(_details!),
                  child: const Text(
                    'Install',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
      ),
    );
  }
}
