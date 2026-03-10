# Project Blueprint: Karmann Versions

## 1. Visió General del Projecte

**Karmann Versions** és una aplicació mòbil i web desenvolupada amb Flutter que serveix com a galeria interactiva i guia de referència per a una selecció de vehicles històrics carrossats per l'empresa alemanya Karmann.

L'objectiu de l'aplicació és oferir als entusiastes de l'automoció una eina visualment atractiva i rica en informació per a explorar la contribució de Karmann a la història de l'automòbil, amb un enfocament especial en models icònics de marques com Porsche i Volkswagen.

## 2. Estat Actual i Funcionalitats Implementades (Versió Inicial)

Aquesta secció documenta l'estat de l'aplicació després de la fase inicial de desenvolupament i les correccions posteriors.

### 2.1. Estructura i Arquitectura

- **Framework:** Flutter 3.x
- **Gestió de l'Estat:** `ChangeNotifierProvider` per a la gestió del tema i `FutureProvider` juntament amb un `ValueNotifier` per a la càrrega de dades i la gestió de la llista de models.
- **Servei de Dades:** Un servei local (`KarmannService`) simula una crida a una API i proporciona una llista estàtica de models. Les dades estan completes i inclouen identificadors únics (`id`) per a cada model.
- **Estructura del Projecte:** Organitzada per funcionalitats (`models`, `services`, `providers`, `screens`).
- **Internacionalització (i18n):** Suport complet per a 6 idiomes (català, espanyol, anglès, alemany, francès, italià) mitjançant el paquet `flutter_localizations` i fitxers `.arb`. L'aplicació és capaç de canviar d'idioma en temps d'execució.

### 2.2. Característiques d'Usuari

- **Pantalla Principal (Llista de Models):**
  - **Visualització en Graella:** Mostra els cotxes en un `GridView` responsiu que s'adapta a diferents mides de pantalla.
  - **Targeta de Model:** Cada cotxe es presenta en una targeta (`Card`) que mostra una imatge, el nom del model i els anys de producció.
  - **Càrrega Asíncrona:** Mostra un indicador de progrés (`CircularProgressIndicator`) mentre es carreguen les dades dels models.

- **Funcionalitats de la Barra d'Aplicació (AppBar):**
  - **Cerca Dinàmica:** Un camp de text permet a l'usuari filtrar la llista de models per nom o per any de producció en temps real.
  - **Filtre per Tipus:** Un menú desplegable (`PopupMenuButton`) permet filtrar els resultats per a mostrar "Tots" els models o només els "Cabriolets".
  - **Ordenació:** Un segon menú desplegable permet ordenar la llista de models per:
    - **Nom** (alfabèticament, A-Z).
    - **Any** (del més antic al més nou).
    - **Per defecte** (segons l'`id` del model).
  - **Canvi d'Idioma:** Un tercer menú desplegable mostra banderes dels idiomes disponibles i permet a l'usuari canviar la llengua de l'aplicació a l'instant.

- **Pantalla de Detalls del Model:**
  - **Navegació:** En fer clic a una targeta de la llista, l'usuari navega a una pantalla de detall específica per a aquell model.
  - **Informació Completa:** La pantalla de detalls mostra:
    - Una imatge destacada del vehicle.
    - El nom complet.
    - Els anys de producció.
    - Una descripció detallada.
    - Una secció de "Dades Clau" amb informació sobre el dissenyador, el motor i la velocitat màxima.
    - Una secció de "Models Relacionats" amb enllaços per a navegar directament a altres cotxes de la col·lecció.
  - **Localització:** Tota la informació textual (descripcions, etiquetes, dades tècniques) es mostra en l'idioma seleccionat per l'usuari.

### 2.3. Codi i Qualitat

- **Anàlisi de Codi:** El projecte està lliure d'errors crítics. Només queden dos avisos menors de l'analitzador de Dart (`use_build_context_synchronously` i `unused_import`) que seran resolts en futures iteracions.
- **Tests:** S'ha creat una prova de widget bàsica (`widget_test.dart`) que verifica la correcta càrrega de l'aplicació i la visualització de la llista de models.
- **Dependències:** El `pubspec.yaml` està net i només inclou les dependències necessàries (`provider`, `flutter_localizations`, `intl`).

## 3. Pròxims Passos: Millora de la Interfície d'Usuari

L'aplicació és funcionalment completa, però la seva interfície d'usuari és bàsica i es basa en els components estàndard de Material. El següent gran objectiu és transformar l'aplicació en una experiència visualment impactant, moderna i polida.

### Pla d'Acció:

1.  **Revisió i Aplicació d'una Paleta de Colors Atractiva:**
    - Seleccionar una paleta de colors moderna i elegant que evoqui la sensació clàssica i "premium" dels cotxes Karmann.
    - Implementar la paleta de colors a tota l'aplicació (AppBar, fons, targetes, text, icones) utilitzant un `ThemeData` centralitzat.

2.  **Millora de la Tipografia:**
    - Integrar el paquet `google_fonts` per a utilitzar una tipografia més personalitzada i llegible que la de per defecte.
    - Establir una jerarquia visual clara mitjançant diferents mides i pesos de font per a títols, subtítols i cos de text.

3.  **Redisseny de la Targeta de Model:**
    - Afegir ombres subtils (`BoxShadow`) per a donar una sensació de profunditat i fer que les targetes "flotin" sobre el fons.
    - Arrodonir les cantonades de les imatges i les targetes (`borderRadius`) per a un aspecte més suau.
    - Afegir un efecte visual (p. ex., un canvi d'ombra o una lleugera animació) quan l'usuari passa el cursor per sobre o pressiona una targeta.

4.  **Polit de la Pantalla de Detalls:**
    - Estructurar la informació de manera més clara, possiblement utilitzant targetes o seccions visualment diferenciades.
    - Fer que la imatge principal sigui més prominent i atractiva.
    - Millorar l'estil dels enllaços a "Models Relacionats" per a que semblin botons o xips interactius.

5.  **Animacions i Transicions:**
    - Afegir animacions d'entrada subtils per als elements de la llista a mesura que apareixen.
    - Implementar una "Hero Animation" a la imatge del cotxe durant la transició entre la pantalla de llista i la de detalls, creant una experiència de navegació més fluida i professional.
