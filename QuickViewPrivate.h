#ifndef QUICKVIEW_H
#define QUICKVIEW_H

#include <QQuickView>

class QuickView : public QQuickView
{
    Q_OBJECT

public:
    /*!
    @brief Constructor.

    @param[in] pParent - the owner of this object.
    */
    explicit QuickView(QWindow* pParent = NULL);

    /*!
    @brief Destructor.
    */
    virtual ~QuickView();
};

#endif
