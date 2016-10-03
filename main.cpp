#include "Diagnostics.h"
#include "Cache.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickView* pViewer(NULL);

    pViewer = new QQuickView();

    qmlRegisterType<Diagnostics>("Sandbox", 1, 0, "Diagnostics");
    qmlRegisterType<Cache>("Sandbox", 1, 0, "Cache");

    pViewer->setResizeMode(QQuickView::SizeRootObjectToView);
    pViewer->setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    pViewer->show();

    QObject::connect(pViewer->engine(), &QQmlEngine::quit, pViewer, &QQuickView::close);

    return app.exec();
}
