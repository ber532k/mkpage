# MKPAGE

An incredibly simple *static website generator*, which accepts the sourcecode
to be written in a variety of different markup languages.

Ein unglaublich simpler *static website generator*, der Quelltext in sehr
vielen unterschiedlichen Markupsprachen akzeptiert.

# Abhängigkeiten

pandoc
: Konvertieren von nicht-html Quelldateien

lowriter
: Zusätzlich benötigt zum konvertieren von `.doc` Quelldateien

lighttpd
: Kann als Testserver verwendet werden

# Dateistruktur

template.html5
: Diese Datei bietet als Template einen Rahmen, der von `mkpage.sh` um jede
  einzelne Quelldatei gelegt wird, um eine fertige Seite mit einheitlichem
  Erscheinungsbild zu erstellen. Hier sind z. B. die Kopf- und Seitenleiste der
  fertigen Webseite definiert.
: Das Format der Datei entspricht dem von pandoc-templates, wie es auf der
  entsprechenden Manpage beschrieben ist und wird von pandoc auch als normales
  Template verwendet. Sollten in `src/` allerdings Quelldateien mit Dateiendung
  `.html` vorhanden sein, so wird für diese Dateien einfach nur `$body$` durch
  den entsprechenden Text der Quelldatei zwischen `<body>` und `</body>`
  ersetzt.  Das Vorkommen anderer Variablen als `$body` führt in diesem Fall
  mit großer Wahrscheinlichkeit zu fehlerhaften html-Dateien in `out/`.

src
: Enthält Quelldateien mit dem Inhalt einzelner Seiten in `html` oder `doc`
  Format bzw. in einem beliebigen anderen Format, das pandoc lesen kann. Die
  Dateistruktur innerhalb dieses Ordners entspricht, mit Ausnahme der
  Dateiendungen, der der fertigen Seite.

data
: Enthält Binärdateien, die unkonvertiert auf der Webseite veröffentlicht werden
  sollen, wie etwa Bilder, `pdf`-Dateien o. ä. Die Dateistruktur innerhalb
  dieses Ordners entspricht exakt der der fertigen Seite.

data/style.css
: Der CSS3-Stylesheet für die Seite. Hier ist das visuelle Erscheinungsbild der
  Webseite, also Schriftart, Hintergrundfarbe, Anordnung des Navigationsmenüs
  etc. definiert.
: Diese Datei muss im Template entsprechend eingebunden werden.

out
: Enthält die fertige Seite. Dateien in `out/` sollten nicht manuell bearbeitet
  werden, da der komplette Ihnalt des Ordners bei jeder Aktualisierung gelöscht
  und neu generiert wird.

testserver
: Enthält Konfigurations- und Logdateien für den testserver.

# Benutzung der Scripts
## mkpage.sh
### Funktion

Dieses Script löscht alle Dateien in `out/`, kopiert alle Dateien aus `data/`
nach `out/` und konvertiert dann alle Dateien aus `src/` mithilfe des Templates
`template.html5` zu korrespondierenden html-Dateien in `out/`

### Optionen

-f
: *fast run*
: `out/` wird nicht gelöscht und Daten aus `data/` werden nicht erneut kopiert.
  Wenn entsprechend viele Quelldateien und vergleichsweise wenige Binärdateien
  vorhanden sind ist allerdings kaum eine Zeitersparnis durch diese Option
  gegeben.


## server.sh
### Funktion

Dieses Script startet einen lokalen Testserver auf Port 8080, so dass die Seite
ausprobiert werden kann. Außerdem wird ein Browser gestartet, um die Seite
anzuzeigen.

### Optionen

-q
: *quiet*
: Es wird kein Browser gestartet.
