#include "QuickView.h"

QuickView::QuickView(QWindow* pParent) :
    QQuickView(pParent)
{
    // Do nothing.
}

QuickView::~QuickView()
{
    // Do nothing.
}


void QuickView::flush()
{
    QMetaObject::invokeMethod(this, "doFlush", Qt::QueuedConnection);
}

void QuickView::doFlush()
{
    this->setClearBeforeRendering(true);
    //const QQuickViewPrivate* d = d_func();
    //Q_UNUSED(d);
}
