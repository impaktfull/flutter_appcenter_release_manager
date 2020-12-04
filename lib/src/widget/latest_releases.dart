import 'package:appcenter_release_manager/appcenter_release_manager.dart';
import 'package:appcenter_release_manager/src/appcenter_release_manager.dart';
import 'package:appcenter_release_manager/src/data/webservice/release.dart';
import 'package:appcenter_release_manager/src/util/formatter/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppCenterReleaseManagerLatestReleases extends StatefulWidget {
  final String apiToken;
  final String ownerName;
  final String appName;
  final bool showLogs;

  const AppCenterReleaseManagerLatestReleases({
    @required this.apiToken,
    @required this.ownerName,
    @required this.appName,
    this.showLogs = false,
  }) : assert(showLogs != null);

  @override
  _AppCenterReleaseManagerLatestReleasesState createState() => _AppCenterReleaseManagerLatestReleasesState();
}

class _AppCenterReleaseManagerLatestReleasesState extends State<AppCenterReleaseManagerLatestReleases> {
  AppCenterReleaseManager _appCenterReleaseManager;
  var _loading = false;
  var _error = false;

  final _releases = <Release>[];
  Release _selectedItem;
  ReleaseDetail _releaseDetail;

  @override
  void initState() {
    super.initState();
    _appCenterReleaseManager = AppCenterReleaseManager(apiToken: widget.apiToken);
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (_loading) return const Center(child: CircularProgressIndicator());
          final theme = Theme.of(context);
          if (_error) {
            return ListView(
              children: [
                Container(
                  height: constraints.maxHeight,
                  width: constraints.minWidth,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline_rounded),
                        const SizedBox(height: 12),
                        Text(
                          'Something went wrong with the AppCenterApi',
                          style: theme.textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          if (_releaseDetail != null) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${_releaseDetail.shortVersion} (${_releaseDetail.version})',
                        style: theme.textTheme.headline6,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: theme.textTheme.subtitle2.color,
                      ),
                      onPressed: _onCloseClicked,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  DateTimeFormatter.format(_releaseDetail.uploadedAt),
                  style: theme.textTheme.subtitle2.copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 16),
                MaterialButton(
                  child: Text(
                    'Download',
                    style: theme.accentTextTheme.bodyText1.copyWith(
                      color: theme.accentColorBrightness == Brightness.light ? Colors.white : Colors.black,
                    ),
                  ),
                  color: theme.accentColor,
                  onPressed: () => _appCenterReleaseManager.installRelease(_releaseDetail),
                ),
                const SizedBox(height: 16),
                Text(
                  _releaseDetail.releaseNotes,
                  style: theme.textTheme.caption,
                ),
              ],
            );
          }
          return ListView.builder(
            itemCount: _releases.length,
            itemBuilder: (context, index) {
              final item = _releases[index];
              return ListTile(
                title: Text(
                  '${item.shortVersion} (${item.version})',
                  style: theme.textTheme.subtitle2,
                ),
                subtitle: Text(
                  DateTimeFormatter.format(item.uploadedAt),
                  style: theme.textTheme.caption,
                ),
                onTap: () => _onReleaseClicked(item),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _getData() async {
    try {
      _loading = _releases.isEmpty;
      _error = false;
      setState(() {});
      final data = await _appCenterReleaseManager.getReleases(widget.ownerName, widget.appName);
      _releases
        ..clear()
        ..addAll(data);
    } catch (e) {
      if (widget.showLogs) print(e); // ignore: avoid_print
      _error = true;
    }
    _loading = false;
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _onRefresh() {
    if (_selectedItem == null) return _getData();
    return _getReleaseDetails();
  }

  Future<void> _onReleaseClicked(Release item) async {
    _selectedItem = item;
    await _getReleaseDetails();
  }

  Future<void> _getReleaseDetails() async {
    try {
      _loading = _releaseDetail == null;
      _error = false;
      setState(() {});
      _releaseDetail = await _appCenterReleaseManager.getReleaseDetails(widget.ownerName, widget.appName, _selectedItem.id);
    } catch (e) {
      if (widget.showLogs) print(e); // ignore: avoid_print
      _error = true;
    }
    _loading = false;
    if (!mounted) return;
    setState(() {});
  }

  void _onCloseClicked() {
    _selectedItem = null;
    _releaseDetail = null;
    setState(() {});
  }
}
