TEMPLATE = app
TARGET = harbour-phonebot

QT = core gui qml quick dbus

!CONFIG(desktop) {
    CONFIG += sailfishapp
} else {
    DEFINES += DESKTOP
    RESOURCES += res.qrc
}

INCLUDEPATH += ../../lib/core \
    ../../lib/meta \
    ../../lib/config \
    ../../lib/daemon
LIBS += -lrt
LIBS += -L../../plugins/debug -lphonebotdebug \
    -L../../plugins/profile -lphonebotprofile \
    -L../../plugins/time -lphonebottime \
    -L../../lib/config -lphonebotconfig \
    -L../../lib/daemon -lphonebotdaemon \
    -L../../lib/meta -lphonebotmeta \
    -L../../lib/core -lphonebot



SOURCES += \
    main.cpp

OTHER_FILES += qml/main.qml \
    qml/CoverPage.qml \
    qml/MainPage.qml \
    qml/RuleDialog.qml \
    qml/RuleButton.qml \
    qml/ComponentConfigDialog.qml \
    qml/ComponentsDialog.qml \
    qml/typesolver.js \
    qml/TimePicker.qml \
    qml/TypeField.qml \
    qml/DialogButton.qml \
    qml/ComboBox.qml

target.path = /usr/bin
    
desktop.path = /usr/share/applications
desktop.files = harbour-phonebot.desktop

icon.path = /usr/share/icons/hicolor/86x86/apps/
icon.files = harbour-phonebot.png

qml.path = /usr/share/harbour-phonebot/qml
qml.files = $$OTHER_FILES

INSTALLS += target desktop icon qml


