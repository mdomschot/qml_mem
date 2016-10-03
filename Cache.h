#ifndef CACHE_H
#define CACHE_H

#include <QObject>
#include <QtQuick/QQuickItem>

class Cache : public QObject
{
    Q_OBJECT

public:
    /*!
    @brief Constructor.

    @param[in] pParent - the owner of this object.
    */
    explicit Cache(QObject* pParent = NULL);

    /*!
    @brief Destructor.
    */
    ~Cache();

    /*!
    @brief Caches a panel.

    @param[in] pPanel - the panel to cache.
    */
    Q_INVOKABLE void giveItem(const QString& title, QQuickItem* pPanel);

    /*!
    @brief Uncaches a panel.

    @param[in] title - The panel to retrieve.

    @return The panel if found; otherwise null.
    */
    Q_INVOKABLE QQuickItem* takeItem(const QString& title);

    /*!
    @brief Checks to see if the cache has a specific panel.

    @param[in] title - The panel to check for.

    @return True if the panel is in the cache; otherwise false.
    */
    Q_INVOKABLE bool hasItem(const QString& title);

    /*!
    @brief Utility method to call QQmlEngine::trimComponentCache().
    */
    Q_INVOKABLE void trimComponentCache();

    /*!
    @brief Utility method to call QQmlEngine::clearComponentCache().
    */
    Q_INVOKABLE void clearComponentCache();

protected:
    /*!
    @brief Filters events for monitored QObjects.

    Used to block deletions of cached panes.

    @param pObject[in] - the object receiving the event.
    @param pEvent[in] - the triggering event.

    @return True if the event should be blocked; false otherwise.
    */
    bool eventFilter(QObject* pObject, QEvent* pEvent);

private:
    QMap<QString, QQuickItem*> m_cache;
};

#endif
