import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/async_value.dart';
import '../../../theme/theme.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LibraryViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text('Library', style: AppTextStyles.heading),
          const SizedBox(height: 50),
          Expanded(child: _buildBody(context, vm)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, LibraryViewModel vm) {
    return switch (vm.songs) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final error) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: vm.retry,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      AsyncData(:final value) => ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) => SongTile(
            song: value[index],
            isPlaying: vm.isSongPlaying(value[index]),
            onTap: () => vm.start(value[index]),
          ),
        ),
    };
  }
}
