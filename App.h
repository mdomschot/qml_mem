#ifndef APP_H
#define APP_H

#include <QObject>
#include <QQuickView>

class App : public QObject
{
    Q_OBJECT

public:
    /*!
    @brief Constructor.

    @param[in] pParent - the owner of this object.
    */
    explicit App(QObject* pParent = NULL);

    /*!
    @brief Destructor.
    */
    ~App();

    Q_INVOKABLE void reload();
    void init();

private slots:
    void doReload();

private:
    QQuickView* m_pViewer;
};

#endif
