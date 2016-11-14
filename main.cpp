#include "App.h"

#include <QGuiApplication>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    App app2;
    app2.init();

    return app.exec();
}
