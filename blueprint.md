# Project Blueprint: Karmann Versions

## 1. Visió General del Projecte

**Karmann Versions** és una aplicació mòbil i web desenvolupada amb Flutter que serveix com a galeria interactiva i guia de referència per a una selecció de vehicles històrics carrossats per l'empresa alemanya Karmann.

L'objectiu de l'aplicació és oferir als entusiastes de l'automoció una eina visualment atractiva i rica en informació per a explorar la contribució de Karmann a la història de l'automòbil, amb un enfocament especial en models icònics de marques com Porsche i Volkswagen.

## 2. Estat Actual i Funcionalitats Implementades

Aquesta secció documenta l'estat de l'aplicació, incloent-hi totes les funcionalitats implementades fins a la data.

### 2.1. Estructura i Arquitectura

- **Framework:** Flutter 3.x
- **Gestió de l'Estat:** `ChangeNotifierProvider` per a la gestió del tema i `FutureProvider` juntament amb un `ValueNotifier` per a la càrrega de dades i la gestió de la llista de models.
- **Servei de Dades:** Un servei local (`KarmannService`) carrega les dades des de fitxers JSON locals. El servei ha estat refactoritzat per a ser robust davant d'errors en fitxers individuals.
- **Estructura del Projecte:** Organitzada per funcionalitats (`models`, `services`, `providers`, `screens`).
- **Internacionalització (i18n):** Suport complet per a 6 idiomes (català, espanyol, anglès, alemany, francès, italià) mitjançant el paquet `flutter_localizations` i fitxers `.arb`.

### 2.2. Característiques d'Usuari

- **Pantalla Principal (Llista de Models):**
  - **Visualització en Graella:** Mostra els cotxes en un `GridView` responsiu.
  - **Targeta de Model:** Presenta cada cotxe amb una imatge, nom i anys de producció.
  - **Càrrega Asíncrona i Robusta:** Mostra un indicador de progrés durant la càrrega i és capaç de carregar dades parcials si alguns fitxers contenen errors.

- **Funcionalitats de la Barra d'Aplicació (AppBar):**
  - **Cerca Dinàmica:** Filtra la llista per nom o any en temps real.
  - **Filtre per Tipus:** Permet filtrar per "Tots" o "Cabriolets".
  - **Ordenació:** Ordena els models per nom, any, unitats produïdes o per defecte.
  - **Canvi d'Idioma:** Permet canviar la llengua de l'aplicació a l'instant.

- **Pantalla de Detalls del Model:**
  - **Navegació:** S'hi accedeix en fer clic a una targeta de la llista.
  - **Informació Completa:** Mostra una imatge destacada, nom, anys, descripció i dades tècniques.
  - **Secció de Dades Clau:** Informació sobre dissenyador, motor i velocitat màxima.
  - **Secció de Models Relacionats:** Enllaços per a navegar a altres cotxes.
  - **Secció de Versions (Avançat):** Mostra un panell desplegable (`ExpansionPanelList`) amb les diferents versions del model, cadascuna amb la seva pròpia imatge, nom, anys i descripció de canvis.
  - **Localització:** Tota la informació textual es mostra en l'idioma seleccionat.

## 3. Disseny i Experiència d'Usuari (UI/UX)

Aquest apartat detalla les millores visuals i d'interacció aplicades.

- **Paleta de Colors i Tipografia:** S'ha implementat una paleta de colors elegant i s'ha integrat `google_fonts`.
- **Redisseny de Components:** Les targetes tenen ombres subtils i cantonades arrodonides.
- **Animacions i Transicions:** S'ha implementat una **Hero Animation** per a una transició fluida entre pantalles.

## 4. Últims Canvis: Sistema Avançat de Versions i Millores de Robustesa

Aquesta secció descriu les últimes funcionalitats implementades i les millores estructurals.

### 4.1. Pla d'Acció Executat

1.  **Reestructuració del Model de Dades (`karmann_model.dart`):**
    - S'ha eliminat l'antiga propietat `variants` (`List<String>`).
    - S'ha introduït una nova classe `Version` per a encapsular dades detallades de cada variant:
        - `versionName`: Nom localitzat de la versió (Mapa `String, String`).
        - `imageUrl`: URL de la imatge específica de la versió.
        - `productionYears`: Anys de producció (opcional).
        - `changes`: Descripció localitzada dels canvis (Mapa `String, String`).
    - S'ha afegit la propietat `versions` (`List<Version>`) a la classe `KarmannModel`, fent-la opcional al constructor per garantir la retrocompatibilitat durant la càrrega.

2.  **Millora de la Robustesa en la Càrrega de Dades (`karmann_service.dart`):**
    - S'ha refactoritzat el mètode `_loadModels` per a gestionar errors de manera individual per cada fitxer JSON.
    - El bloc `try-catch` s'ha mogut a l'interior del bucle de lectura de fitxers (`for`).
    - Si un fitxer (`db_*.json`) falla en carregar-se o processar-se, es registra l'error mitjançant `developer.log` però l'aplicació continua carregant la resta de fitxers, evitant que la llista de models quedi buida per un error aïllat.

3.  **Actualització de la Interfície d'Usuari (Pantalla de Detalls):**
    - La secció "Versions i Variants" ara utilitza un `ExpansionPanelList` per a mostrar les noves dades estructurades. Cada panell mostra:
        - **Capçalera:** El nom de la versió i els seus anys de producció.
        - **Contingut (expandit):** Una imatge de la versió i una descripció detallada dels canvis.

4.  **Actualització dels Fitxers de Dades (`db_*.json`):**
    - S'està actualitzant tots els fitxers de dades per a substituir l'antic camp `variants` (si existeix) pel nou camp estructurat `versions`. Si un model no té versions, el camp s'omet.

## 5. Correccions Finals de Disseny

Aquesta secció detalla els ajustos finals realitzats per a resoldre problemes específics de la interfície d'usuari.

1.  **Ajust de la Proporció de les Targetes (Pantalla Principal):**
    - **Problema:** Les targetes de la graella principal es mostraven quadrades, desaprofitant l'espai horitzontal.
    - **Solució:** S'ha modificat la propietat `childAspectRatio` del `GridView.builder` de `1.0` a `4 / 3`. Aquest canvi assegura que les targetes siguin rectangulars (més amples que altes), millorant la composició visual i l'aprofitament de l'espai.

2.  **Reducció de l'Espaiat (Pantalla de Detall):**
    - **Problema:** Existia una distància vertical excessiva entre el títol "Versions i Variants" i la llista de targetes desplegables.
    - **Solució Definitiva:** Després de diversos intents fallits amb `SizedBox` i la reestructuració de la llista, la solució final i robusta ha estat afegir un marge superior a cada targeta de versió. S'ha aplicat `margin: const EdgeInsets.only(top: 12, bottom: 12)` directament al `Card` dins del bucle que genera les versions. Aquest mètode assegura un control precís de l'espaiat, independentment del comportament d'altres widgets.
