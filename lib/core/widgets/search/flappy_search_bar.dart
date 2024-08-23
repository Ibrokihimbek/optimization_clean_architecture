import "dart:async";

import "package:async/async.dart";
import "package:flutter/material.dart";
import "package:currency_clean_architecture/core/extension/extension.dart";
import "package:currency_clean_architecture/core/theme/themes.dart";
import "package:currency_clean_architecture/core/utils/utils.dart";
import "package:currency_clean_architecture/core/widgets/loading/circular_progress_indicator.dart";

mixin ControllerListener<T> on State<FlappySearchBar<T>> {
  void onListChanged(List<T> items) {}

  void onLoading() {}

  void onClear() {}

  void onError(Error error) {}
}

class FlappySearchBarController<T> {
  final List<T> _list = <T>[];
  final List<T> _filteredList = <T>[];
  final List<T> _sortedList = <T>[];
  late TextEditingController _searchQueryController;
  String? _lastSearchedText;
  Future<List<T>> Function(String? text)? _lastSearchFunction;
  late ControllerListener<dynamic> controllerListener;
  int Function(T a, T b)? _lastSorting;
  CancelableOperation<List<T>>? _cancelableOperation;
  late int minimumChars;

  void setTextController(
    TextEditingController searchQueryController,
    int minimunChars,
  ) {
    _searchQueryController = searchQueryController;
    minimumChars = minimunChars;
  }

  void clear() {
    controllerListener.onClear();
  }

  Future<void> _search(
    String? text,
    Future<List<T>> Function(String? text) onSearch,
  ) async {
    controllerListener.onLoading();
    try {
      if (_cancelableOperation != null &&
          (!_cancelableOperation!.isCompleted ||
              !_cancelableOperation!.isCanceled)) {
        await _cancelableOperation!.cancel();
      }
      _cancelableOperation = CancelableOperation<List<T>>.fromFuture(
        onSearch(text),
        onCancel: () {},
      );

      final List<T> items = (await _cancelableOperation?.value) ?? <T>[];
      _lastSearchFunction = onSearch;
      _lastSearchedText = text;
      _list.clear();
      _filteredList.clear();
      _sortedList.clear();
      _lastSorting = null;
      _list.addAll(items);
      controllerListener.onListChanged(_list);
    } on Exception catch (error) {
      controllerListener.onError(error as Error);
    }
  }

  Future<void> injectSearch(
    String? searchText,
    Future<List<T>> Function(String? text) onSearch,
  ) async {
    if (searchText != null && searchText.length >= minimumChars) {
      _searchQueryController.text = searchText;
      await _search(searchText, onSearch);
    }
  }

  Future<void> replayLastSearch() async {
    if (_lastSearchFunction != null && _lastSearchedText != null) {
      await _search(_lastSearchedText, _lastSearchFunction!);
    }
  }

  void removeFilter() {
    _filteredList.clear();
    if (_lastSorting == null) {
      controllerListener.onListChanged(_list);
    } else {
      _sortedList
        ..clear()
        ..addAll(List<T>.from(_list))
        ..sort(_lastSorting);
      controllerListener.onListChanged(_sortedList);
    }
  }

  void removeSort() {
    _sortedList.clear();
    _lastSorting = null;
    controllerListener
        .onListChanged(_filteredList.isEmpty ? _list : _filteredList);
  }

  void sortList(int Function(T a, T b) sorting) {
    _lastSorting = sorting;
    _sortedList
      ..clear()
      ..addAll(List<T>.from(_filteredList.isEmpty ? _list : _filteredList))
      ..sort(sorting);
    controllerListener.onListChanged(_sortedList);
  }

  void filterList(bool Function(T item) filter) {
    _filteredList
      ..clear()
      ..addAll(
        _sortedList.isEmpty
            ? _list.where(filter).toList()
            : _sortedList.where(filter).toList(),
      );
    controllerListener.onListChanged(_filteredList);
  }

  String get searchText => _searchQueryController.text;
}

typedef IndexedScaledTileBuilder = Widget Function(int index);

class FlappySearchBar<T> extends StatefulWidget {
  const FlappySearchBar({
    super.key,
    required this.onSearch,
    required this.onItemFound,
    this.searchBarController,
    this.minimumChars = 3,
    this.recent,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.loader = const Center(child: CustomCircularProgressIndicator()),
    this.onError,
    this.emptyWidget = const SizedBox.shrink(),
    this.header,
    this.placeHolder,
    this.icon = const Icon(Icons.search),
    this.hintText = "",
    this.hintStyle = const TextStyle(
      color: Color.fromRGBO(36, 36, 36, 0.45),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    this.iconActiveColor = Colors.black,
    this.textStyle,
    this.cancellationWidget = const Text("Cancel"),
    this.onCancelled,
    this.suggestions = const <Never>[],
    this.buildSuggestion,
    this.crossAxisCount = 1,
    this.shrinkWrap = false,
    this.scrollDirection = Axis.vertical,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.listPadding = EdgeInsets.zero,
    this.searchBarPadding = EdgeInsets.zero,
    this.headerPadding = EdgeInsets.zero,
    this.focusNode,
    this.scrollController,
  });

  final ScrollController? scrollController;

  /// Future returning searched items
  final Future<List<T>> Function(String? text) onSearch;

  /// List of items showed by default
  final List<T> suggestions;

  /// Callback returning the widget corresponding to a Suggestion item
  final Widget Function(T? item, int index)? buildSuggestion;

  /// Minimum number of chars required for a search
  final int minimumChars;

  /// Callback returning the widget corresponding to an item found
  final Widget Function(T? item, int index) onItemFound;

  /// Callback returning the widget corresponding to an Error while searching
  final Widget Function(Error error)? onError;

  /// Cooldown between each call to avoid too many
  final Duration debounceDuration;

  /// Widget to show when loading
  final Widget loader;

  /// Widget to show when no item were found
  final Widget emptyWidget;

  /// Widget to show by default
  final Widget? placeHolder;

  /// Widget to show by Recent
  final Widget? recent;

  /// Widget showed on left of the search bar
  final Widget? icon;

  /// Widget placed between the search bar and the results
  final Widget? header;

  /// Hint text of the search bar
  final String hintText;

  /// TextStyle of the hint text
  final TextStyle hintStyle;

  /// Color of the icon when search bar is active
  final Color iconActiveColor;

  /// Text style of the text in the search bar
  final TextStyle? textStyle;

  /// Widget shown for cancellation
  final Widget cancellationWidget;

  /// Callback when cancel button is triggered
  final void Function()? onCancelled;

  /// Focus node
  final FocusNode? focusNode;

  /// Controller used to be able to sort, filter or replay the search
  final FlappySearchBarController<T>? searchBarController;

  /// Number of items displayed on cross axis
  final int crossAxisCount;

  /// Weather the list should take the minimum place or not
  final bool shrinkWrap;

  /// Set the scrollDirection
  final Axis scrollDirection;

  /// Spacing between tiles on main axis
  final double mainAxisSpacing;

  /// Spacing between tiles on cross axis
  final double crossAxisSpacing;

  /// Set a padding on the search bar
  final EdgeInsetsGeometry searchBarPadding;

  /// Set a padding on the header
  final EdgeInsetsGeometry headerPadding;

  /// Set a padding on the list
  final EdgeInsetsGeometry listPadding;

  @override
  FlappySearchBarState<T> createState() => FlappySearchBarState<T>();
}

class FlappySearchBarState<T> extends State<FlappySearchBar<T>>
    with TickerProviderStateMixin, ControllerListener<T> {
  bool _loading = false;
  bool _isTitle = true;
  Widget? _error;
  final TextEditingController _searchQueryController = TextEditingController();
  Timer? _debounce;
  bool animate = false;
  List<T?> _list = <T?>[];
  late FlappySearchBarController<T> searchBarController;
  late WidgetStatesController statesController;

  @override
  void initState() {
    super.initState();
    statesController = WidgetStatesController();
    searchBarController =
        widget.searchBarController ?? FlappySearchBarController<T>();
    searchBarController
      ..controllerListener = this
      ..setTextController(
        _searchQueryController,
        widget.minimumChars,
      );
  }

  @override
  void dispose() {
    // ignore: discarded_futures
    searchBarController._cancelableOperation?.cancel();
    _searchQueryController.dispose();
    statesController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void onListChanged(List<T?> items) {
    setState(() {
      _loading = false;
      _list = items;
    });
  }

  @override
  void onLoading() {
    setState(() {
      _loading = true;
      _error = null;
      animate = true;
    });
  }

  @override
  void onClear() {
    _cancel();
  }

  @override
  void onError(Error error) {
    setState(() {
      _loading = false;
      _error =
          widget.onError != null ? widget.onError!(error) : const Text("error");
    });
  }

  Future<void> _onTextChanged(String newText) async {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(widget.debounceDuration, () async {
      if (newText.length >= widget.minimumChars) {
        await searchBarController._search(newText, widget.onSearch);
      } else {
        setState(() {
          _list.clear();
          _error = null;
          _loading = false;
          animate = false;
        });
      }
    });
  }

  void _cancel() {
    if (widget.onCancelled != null) {
      widget.onCancelled!.call();
    }

    setState(() {
      _searchQueryController.clear();
      _list.clear();
      _isTitle = !_isTitle;
      _error = null;
      _loading = false;
      animate = false;
    });
  }

  Widget _buildListView(
    List<T?> items,
    Widget Function(T? item, int index) builder,
  ) =>
      ListView.separated(
        controller: widget.scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: widget.listPadding,
        itemCount: items.length,
        shrinkWrap: widget.shrinkWrap,
        scrollDirection: widget.scrollDirection,
        itemBuilder: (_, int index) => builder(items[index], index),
        separatorBuilder: (_, __) => AppUtils.kGap8,
      );

  Widget? _buildContent() {
    if (_error != null) {
      return _error;
    } else if (_loading) {
      return widget.loader;
    } else if (_searchQueryController.text.length < widget.minimumChars) {
      if (widget.placeHolder != null) {
        return widget.placeHolder;
      }
      return _buildListView(
        widget.suggestions,
        widget.buildSuggestion ?? widget.onItemFound,
      );
    } else if (_list.isNotEmpty) {
      return _buildListView(_list, widget.onItemFound);
    } else {
      return widget.emptyWidget;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: widget.searchBarPadding,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    statesController: statesController,
                    controller: _searchQueryController,
                    onChanged: _onTextChanged,
                    style: widget.textStyle ?? context.textTheme.titleMedium,
                    focusNode: widget.focusNode,
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      fillColor: context.color.background,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: AppUtils.kBorderRadius10,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: AppUtils.kBorderRadius10,
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: AppUtils.kBorderRadius10,
                      ),
                      prefixIcon: widget.icon,
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: widget.hintStyle,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                AnimatedCrossFade(
                  alignment: Alignment.centerRight,
                  firstCurve: Curves.easeInOut,
                  secondCurve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                  crossFadeState:
                      _searchQueryController.text.length >= widget.minimumChars
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                  firstChild: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      style: ButtonStyle(
                        padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.all(12),
                        ),
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          context.colorScheme.surfaceContainer,
                        ),
                      ),
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () async {
                        widget.focusNode?.unfocus();
                        widget.onCancelled?.call();
                        await _onTextChanged("");
                        _searchQueryController.clear();
                      },
                    ),
                  ),
                  secondChild: AppUtils.kGap,
                ),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Offstage(
              offstage:
                  _searchQueryController.text.length < widget.minimumChars,
              child: Padding(
                padding: widget.headerPadding,
                child: widget.header ?? const SizedBox.shrink(),
              ),
            ),
            Expanded(
              child: _buildContent() ?? const SizedBox.shrink(),
            ),
          ],
        ),
      );
}
