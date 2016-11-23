#include "App.h"


#include "Diagnostics.h"
#include "Cache.h"

#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>

App::App(QObject* pParent) :
    QObject(pParent),
    m_pViewer(NULL)
{
    // Do nothing.
}

App::~App()
{
    // Do nothing.
}

void App::reload()
{
    QMetaObject::invokeMethod(this, "doReload", Qt::QueuedConnection);
}

void App::doReload()
{
    if(m_pViewer)
    {
        delete m_pViewer;
        init();
    }
}

void App::init()
{
    qmlRegisterType<Diagnostics>("Sandbox", 1, 0, "Diagnostics");
    qmlRegisterType<Cache>("Sandbox", 1, 0, "Cache");

    m_pViewer = new QQuickView();

    m_pViewer->setPersistentOpenGLContext(false);
    m_pViewer->setPersistentSceneGraph(false);

    m_pViewer->rootContext()->setContextProperty("g_app", this);
    m_pViewer->setResizeMode(QQuickView::SizeRootObjectToView);
    m_pViewer->setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    m_pViewer->show();
}
