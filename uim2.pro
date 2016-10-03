TEMPLATE = app

QT += qml quick

SOURCES += main.cpp \
    Diagnostics.cpp \
    Cache.cpp

DESTDIR = ./bin

RESOURCES += qml.qrc

OTHER_FILES += \
               main.qml \
               Panel1.qml \
               Panel2.qml \
               Panel3.qml \
               Panel4.qml \
               Panel5.qml \
               Panel6.qml \
               PanelBase.qml

# Default rules for deployment.
include(deployment.pri)

unix:QMAKE_CXXFLAGS += -funwind-tables
unix:QMAKE_LFLAGS += -rdynamic

HEADERS += \
    Diagnostics.h \
    Cache.h

win32 {
    LIBS += -lpsapi
}