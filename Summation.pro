# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = Summation

CONFIG += sailfishapp

SOURCES += src/Summation.cpp \
    src/list.cpp

OTHER_FILES += qml/Summation.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/Summation.changes.in \
    rpm/Summation.spec \
    rpm/Summation.yaml \
    translations/*.ts \
    Summation.desktop

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/Summation-de.ts

HEADERS += \
    src/list.h

