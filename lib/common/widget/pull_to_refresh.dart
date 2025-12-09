import 'package:flutter/material.dart';

/// Notification broadcasted when a global pull-to-refresh occurs.
class ReloadDataNotification extends Notification {
  const ReloadDataNotification();
}

/// A small reusable pull-to-refresh wrapper.
///
/// If [onRefresh] is provided it is called when user pulls down. Otherwise
/// a [ReloadDataNotification] is dispatched so pages can listen and reload
/// their own data.
class PullToRefresh extends StatelessWidget {
  const PullToRefresh({super.key, required this.child, this.onRefresh});

  final Widget child;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      edgeOffset: 0,
      onRefresh: () async {
        if (onRefresh != null) return await onRefresh!();
        // Notify children to handle reload if they want to.
        ReloadDataNotification().dispatch(context);
        // Give a small delay to allow listeners to react.
        await Future.delayed(const Duration(milliseconds: 400));
      },
      child: _ScrollWrapper(child: child),
    );
  }
}

// RefreshIndicator requires a scrollable. If child already contains a scrollable
// (ListView/SingleChildScrollView) we should not force another one. But to be
// safe and consistent we wrap the child in a CustomScrollView with a single
// SliverFillRemaining to host the child. This makes pull-to-refresh available
// even for pages that don't have their own scroll view.
class _ScrollWrapper extends StatelessWidget {
  const _ScrollWrapper({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [SliverFillRemaining(hasScrollBody: true, child: child)],
    );
  }
}
