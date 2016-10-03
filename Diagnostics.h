#ifndef DIAGNOSTICS_H
#define DIAGNOSTICS_H

#include <QObject>
#include <QtQuick/QQuickItem>

class Diagnostics : public QQuickItem
{
    Q_OBJECT

public:
    /*!
    @brief Constructor.

    @param[in] pParent - the owner of this object.
    */
    explicit Diagnostics(QQuickItem* pParent = NULL);

    /*!
    @brief Destructor.
    */
    ~Diagnostics();

    /*!
    @brief Retrieves the memory used by this process in MB.

    http://stackoverflow.com/questions/63166/how-to-determine-cpu-and-memory-consumption-from-inside-a-process

    @return The memory used by this process in MB.
    */
    Q_INVOKABLE double getMemoryUsed();

    /*!
    @brief Retrieves the number of frames/second rendered by this process.

    http://stackoverflow.com/questions/35553792/show-fps-in-qml

    @return The number of frames/second rendered by this process.
    */
    Q_INVOKABLE double getFPS();

protected:
    /*!
    @brief Takes and manages timestamps used for the FPS calculation.

    @note: This item is actually invisible.
    */
    QSGNode* updatePaintNode(QSGNode* pOldNode, UpdatePaintNodeData* pUpdatePaintNodeData);

private:
    QVector<qint64> m_timeStamps; //!< Time stamps of render calls used to calculate FPS.
};

#endif
