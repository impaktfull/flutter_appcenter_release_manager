import 'package:appcenter_release_manager/appcenter_release_manager.dart';
import 'package:appcenter_release_manager/src/util/formatter/date_time_formatter.dart';
import 'package:flutter/material.dart';

class ReleaseDetailWidget extends StatefulWidget {
  final AppCenterReleaseManager appCenterReleaseManager;
  final ReleaseDetail releaseDetail;
  final VoidCallback onCloseClicked;

  const ReleaseDetailWidget({
    required this.appCenterReleaseManager,
    required this.releaseDetail,
    required this.onCloseClicked,
    super.key,
  });

  @override
  State<ReleaseDetailWidget> createState() => _ReleaseDetailWidgetState();
}

class _ReleaseDetailWidgetState extends State<ReleaseDetailWidget> {
  var _isLoadingDownload = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${widget.releaseDetail.shortVersion} (${widget.releaseDetail.version})',
                style: theme.textTheme.headline6,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: theme.textTheme.subtitle2?.color,
              ),
              onPressed: widget.onCloseClicked,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          DateTimeFormatter.format(widget.releaseDetail.uploadedAt),
          style: theme.textTheme.subtitle2
              ?.copyWith(fontWeight: FontWeight.normal),
        ),
        const SizedBox(height: 16),
        MaterialButton(
          color: theme.colorScheme.secondary,
          onPressed: () async {
            setState(() => _isLoadingDownload = true);
            await widget.appCenterReleaseManager.installRelease(
              widget.releaseDetail,
              openAndroidInstallScreen: false,
              keepAndroidNotification: false,
            );
            setState(() => _isLoadingDownload = false);
          },
          child: Text(
            _isLoadingDownload ? 'Downloading...' : 'Download',
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.releaseDetail.releaseNotes,
          style: theme.textTheme.caption,
        ),
      ],
    );
  }
}
