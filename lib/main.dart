import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:karmann/providers/model_provider.dart';
import 'package:karmann/providers/locale_provider.dart';
import 'package:karmann/models/karmann_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:karmann/l10n/app_localizations.dart';
import 'package:karmann/widgets/plant_map.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ModelProvider()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const KarmannApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            final KarmannModel model = state.extra as KarmannModel;
            return DetailScreen(model: model);
          },
        ),
      ],
    ),
  ],
);

class KarmannApp extends StatelessWidget {
  const KarmannApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primarySeedColor = Color(0xFF2d3436);
    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.exo2(fontSize: 57, fontWeight: FontWeight.bold),
      titleLarge: GoogleFonts.exo2(fontSize: 24, fontWeight: FontWeight.w600),
      bodyMedium: GoogleFonts.lato(fontSize: 14, height: 1.5),
      labelLarge: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
    );

    final ThemeData lightTheme = ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.light,
        surface: const Color(0xFFf5f5f5),
      ),
      textTheme: appTextTheme,
      scaffoldBackgroundColor: const Color(0xFFf5f5f5),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF2d3436),
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.exo2(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        elevation: 2,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIconColor: Colors.grey[600],
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    final ThemeData darkTheme = ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.dark,
      ),
      textTheme: appTextTheme,
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.exo2(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: const Color(0xFF1E1E1E),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2d3436),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIconColor: Colors.grey[400],
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        collapsedBackgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp.router(
              routerConfig: _router,
              title: 'Karmann Models',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeProvider.themeMode,
              locale: localeProvider.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ca'),
                Locale('en'),
                Locale('es'),
                Locale('de'),
                Locale('fr'),
                Locale('it'),
              ],
            );
          },
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  bool _imagesPrecached = false;
  bool _isMapVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<ModelProvider>(context, listen: false);

    if (!_imagesPrecached && provider.allModels.isNotEmpty) {
      _precacheImages(provider.allModels);
      _imagesPrecached = true;
    }
  }

  Future<void> _precacheImages(List<KarmannModel> models) async {
    for (final model in models) {
      if (mounted) {
        await precacheImage(AssetImage(model.imageUrl), context);
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ModelProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    final availablePlants = provider.getAvailablePlants(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode_outlined,
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Canviar tema',
          ),
          if (availablePlants.isNotEmpty)
            PopupMenuButton<String>(
              icon: const Icon(Icons.factory_outlined),
              tooltip: l10n.filterByPlant,
              onOpened: () {
                if (mounted) {
                  setState(() {
                    _isMapVisible = true;
                  });
                }
              },
              onCanceled: () {
                if (provider.selectedPlant == null) {
                  setState(() {
                    _isMapVisible = false;
                  });
                }
              },
              onSelected: (String? plantName) {
                provider.filterByPlant(plantName, context);
                if (plantName == null) {
                  setState(() {
                    _isMapVisible = false;
                  });
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: null,
                    child: Text(l10n.allPlants),
                  ),
                  ...availablePlants.map((plant) {
                    return PopupMenuItem<String>(
                      value: plant.name,
                      child: Row(
                        children: [
                          Text(plant.flag),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(plant.name, overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    );
                  }),
                ];
              },
            ),
          PopupMenuButton<SortType>(
            icon: const Icon(Icons.sort),
            tooltip: 'Ordenar',
            onSelected: (SortType type) {
              provider.sort(type, context: context);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SortType>>[
              PopupMenuItem<SortType>(
                value: SortType.byName,
                child: Text(l10n.sortByName),
              ),
              PopupMenuItem<SortType>(
                value: SortType.byYear,
                child: Text(l10n.sortByYear),
              ),
              PopupMenuItem<SortType>(
                value: SortType.byUnits,
                child: Text(l10n.sortByUnits),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<SortType>(
                value: SortType.none,
                child: Text(l10n.sortDefault),
              ),
            ],
          ),
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            tooltip: 'Canviar idioma',
            onSelected: (Locale locale) {
              localeProvider.setLocale(locale);
            },
            itemBuilder: (BuildContext context) {
              return AppLocalizations.supportedLocales.map((Locale locale) {
                return PopupMenuItem<Locale>(
                  value: locale,
                  child: Text(
                    localeProvider.getLocaleName(locale.languageCode),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) => provider.search(value, context),
                  decoration: InputDecoration(
                    hintText: l10n.searchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              provider.search('', context);
                            },
                          )
                        : null,
                  ),
                ),
                if (provider.selectedPlant != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Chip(
                      label: Text(
                        '${l10n.filterActive}: ${provider.selectedPlant}',
                      ),
                      onDeleted: () {
                        provider.filterByPlant(null, context);
                        setState(() {
                          _isMapVisible = false;
                        });
                      },
                      deleteIcon: const Icon(Icons.close, size: 18),
                    ),
                  ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isMapVisible ? 250 : 0,
            child: _isMapVisible ? const PlantMap() : const SizedBox.shrink(),
          ),
          Expanded(
            child: Consumer<ModelProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.models.isEmpty) {
                  return Center(child: Text(l10n.noResults));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.models.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 4 / 3.5,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final model = provider.models[index];
                    final numberFormat =
                        NumberFormat.decimalPattern(l10n.localeName);

                    return Card(
                      elevation: 2,
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () => context.go('/details', extra: model),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Hero(
                                tag: model.getName(context),
                                child: Image.asset(
                                  model.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      model.getName(context),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(fontSize: 18),
                                      maxLines: 2,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            model.productionYears,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.grey[600]),
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.build_sharp,
                                                size: 16,
                                                color: Colors.grey[600]),
                                            const SizedBox(width: 4),
                                            Text(
                                              numberFormat
                                                  .format(model.unitsProduced),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color:
                                                          Colors.grey[600]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final KarmannModel model;

  const DetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final numberFormat = NumberFormat.decimalPattern(l10n.localeName);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Flexible(
              child: Text(
                model.getName(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (model.isCabriolet)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.beach_access, color: colorScheme.secondary),
              ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: model.getName(context),
              child: Image.asset(
                model.imageUrl,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 350,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.getName(context),
                    style: textTheme.displayLarge?.copyWith(
                      fontSize: 36,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    model.productionYears,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.secondary,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    model.getDescription(context),
                    style: textTheme.bodyMedium?.copyWith(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: colorScheme.outline.withAlpha(51),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.dataSheetTitle,
                            style: textTheme.titleLarge,
                          ),
                          const Divider(height: 24),
                          if (model.designer != null)
                            _buildDetailRow(
                              l10n.designerLabel,
                              model.designer!,
                              textTheme,
                              colorScheme,
                              icon: Icons.design_services,
                            ),
                          _buildDetailRow(
                            l10n.unitsProducedLabel,
                            numberFormat.format(model.unitsProduced),
                            textTheme,
                            colorScheme,
                            icon: Icons.build_sharp,
                          ),
                          if (model.getEngine(context) != null)
                            _buildDetailRow(
                              l10n.engineLabel,
                              model.getEngine(context)!,
                              textTheme,
                              colorScheme,
                              icon: Icons.engineering,
                            ),
                          if (model.getTopSpeed(context) != null)
                            _buildDetailRow(
                              l10n.topSpeedLabel,
                              model.getTopSpeed(context)!,
                              textTheme,
                              colorScheme,
                              icon: Icons.speed,
                            ),
                          if (model.getManufacturingPlant(context) != null)
                            _buildDetailRow(
                              l10n.manufacturingPlantLabel,
                              model.getManufacturingPlant(context)!,
                              textTheme,
                              colorScheme,
                              icon: Icons.factory,
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (model.versions.isNotEmpty) ...[
                    Text(l10n.versionsAndVariantsTitle,
                        style: textTheme.titleLarge),
                    for (final version in model.versions)
                      Card(
                        margin: const EdgeInsets.only(top: 12, bottom: 12),
                        clipBehavior: Clip.antiAlias,
                        child: ExpansionTile(
                          title: Text(
                            version.getVersionName(context),
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    version.imageUrl,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      height: 200,
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  if (version.productionYears != null)
                                    Text(
                                      version.productionYears!,
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  const SizedBox(height: 8),
                                  Text(
                                    version.getChanges(context),
                                    style: textTheme.bodyMedium,
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 24),
                  ],
                  if (model.relatedModels.isNotEmpty) ...[
                    Text(l10n.relatedModelsTitle, style: textTheme.titleLarge),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 150,
                      child: Consumer<ModelProvider>(
                        builder: (context, provider, child) {
                          final related =
                              provider.getModelsByIds(model.relatedModels);
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: related.length,
                            itemBuilder: (context, index) {
                              final relatedModel = related[index];
                              return SizedBox(
                                width: 160,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: InkWell(
                                    onTap: () => context.go(
                                      '/details',
                                      extra: relatedModel,
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          relatedModel.imageUrl,
                                          height: 90,
                                          width: 160,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            relatedModel.getName(context),
                                            style: textTheme.bodySmall,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String title,
    String content,
    TextTheme textTheme,
    ColorScheme colorScheme, {
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, color: colorScheme.primary, size: 22),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.labelLarge),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
