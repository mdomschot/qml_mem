#include "Cache.h"

#include <QQmlEngine>

Cache::Cache(QObject* pParent) :
    QObject(pParent)
{
    // Do nothing.
}

Cache::~Cache()
{
    // Do nothing.
}

void Cache::giveItem(const QString& title, QQuickItem* pPanel)
{
    pPanel->setParent(this);
    pPanel->setParentItem(NULL);
    pPanel->setVisible(false);
    pPanel->installEventFilter(this);

    m_cache.insert(title, pPanel);
}

QQuickItem* Cache::takeItem(const QString& title)
{
    QQuickItem* pPanel = NULL;

    if(m_cache.contains(title))
    {
        pPanel = m_cache[title];
        pPanel->removeEventFilter(this);

        m_cache.remove(title);
    }

    return pPanel;
}

bool Cache::hasItem(const QString& title)
{
    return m_cache.contains(title);
}

void Cache::trimComponentCache()
{
    qmlEngine(this)->trimComponentCache();
}

void Cache::clearComponentCache()
{
    qmlEngine(this)->clearComponentCache();
}

bool Cache::eventFilter(QObject* pObject, QEvent* pEvent)
{
    Q_UNUSED(pObject);

    // QQuickLoader is a [redacted] and assumes that when it unloads the created QQuickItem, it
    // needs to delete it.  This is because it never gives the QQuickItem up to JavaScript memory.
    // While this works for 99% of cases where one just wants to bind to QQuickLoader's item, it
    // fails if you want to assign it to a var or hand it off to something like a cache. So we have
    // to block the delete here as an installed filter.
    return pEvent->type() == QEvent::DeferredDelete;
}
