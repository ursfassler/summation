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
TARGET = summation

QT += xml

CONFIG += sailfishapp
CONFIG += warn_on
CONFIG += c++11

SOURCES +=  \
    src/summation.cpp \
    src/list.cpp

OTHER_FILES += \
    summation.desktop \
    rpm/summation.changes.in \
    rpm/summation.spec \
    rpm/summation.yaml \
    qml/cover/CoverPage.qml \
    qml/pages/EditItem.qml \
    qml/pages/ListView.qml \
    qml/summation.qml \
    qml/pages/Reduce.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

HEADERS += \
    src/list.h

