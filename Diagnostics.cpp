#include "Diagnostics.h"

#include <QDateTime>

// These are needed by uim::GetMemoryConsumed.
#if defined(Q_OS_WIN)
#  include "windows.h"
#  include "winbase.h"
#  include "psapi.h"
#elif defined(Q_OS_LINUX)
#   include "stdlib.h"
#   include "stdio.h"
#   include "string.h"
#endif

Diagnostics::Diagnostics(QQuickItem* pParent) :
    QQuickItem(pParent)
{
    // Indicates the item has visual content (which is a lie) and should be rendered by the scene
    // graph.  Otherwise, we can't calculate FPS.
    setFlag(QQuickItem::ItemHasContents);
}

Diagnostics::~Diagnostics()
{
    // Do nothing.
}

double Diagnostics::getMemoryUsed()
{
    unsigned long memoryUsed = 0;

#if defined(Q_OS_WIN)
    PROCESS_MEMORY_COUNTERS_EX pmc;
    if(GetProcessMemoryInfo(GetCurrentProcess(), (PROCESS_MEMORY_COUNTERS*)&pmc, sizeof(pmc)))
    {
        memoryUsed = pmc.PrivateUsage;
    }
#elif defined(Q_OS_LINUX)
    FILE* file = fopen("/proc/self/status", "r");
    char line[128];

    while (fgets(line, 128, file) != NULL){
        if (strncmp(line, "VmSize:", 7) == 0){
            // This assumes that a digit will be found and the line ends in " Kb".
            int i = strlen(line);
            const char* p = line;
            while (*p <'0' || *p > '9') p++;
            line[i-3] = '\0';
            memoryUsed = atoi(p) * 1024.0;
            break;
        }
    }
    fclose(file);
#endif

    return memoryUsed / 1024.0 / 1024.0;
}

double Diagnostics::getFPS()
{
    return m_timeStamps.count() / 2.0;
}

QSGNode* Diagnostics::updatePaintNode(QSGNode* pOldNode, UpdatePaintNodeData* pUpdatePaintNodeData)
{
    Q_UNUSED(pUpdatePaintNodeData);

    qint64 currentTime = QDateTime::currentDateTime().toMSecsSinceEpoch();
    m_timeStamps.push_back(currentTime);

    while(m_timeStamps[0] <= currentTime - 2000) {
        m_timeStamps.pop_front();
    }

    update();

    return pOldNode;
}
