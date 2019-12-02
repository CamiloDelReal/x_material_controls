#ifndef MOBILEMANAGER_HPP
#define MOBILEMANAGER_HPP

#include <QObject>
#include <QQmlEngine>
#include <QQmlContext>
#include <QColor>

#if defined (Q_OS_ANDROID)
#include <QtAndroidExtras>
#endif

#if defined (Q_OS_ANDROID) || defined (Q_OS_IOS)
#define Q_MOBILE_PLATFORM
#endif

class MobileManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QColor systemStatusBarColor READ systemStatusBarColor WRITE setSystemStatusBarColor NOTIFY systemStatusBarColorChanged)
    Q_PROPERTY(bool systemStatusBarAvailable READ systemStatusBarAvailable WRITE setSystemStatusBarAvailable NOTIFY systemStatusBarAvailableChanged)
    Q_PROPERTY(quint32 systemStatusBarSize READ systemStatusBarSize WRITE setSystemStatusBarSize NOTIFY systemStatusBarSizeChanged)

public:
    MobileManager(QObject *parent = nullptr);

    QColor systemStatusBarColor() const;
    bool systemStatusBarAvailable() const;
    quint32 systemStatusBarSize() const;

    virtual void addContextProperty(QQmlEngine *engine, QQmlContext *context) = 0;

    Q_INVOKABLE virtual void initialize() = 0;

public slots:
    virtual void onAboutToQuit() = 0;
    virtual void onApplicationStateChanged(Qt::ApplicationState applicationState) = 0;

    void setSystemStatusBarColor(const QColor &systemStatusBarColor);
    void setSystemStatusBarAvailable(const bool &systemStatusBarAvailable);
    void setSystemStatusBarSize(const quint32 &systemStatusBarSize);

signals:
    void systemStatusBarColorChanged(const QColor &systemStatusBarColor);
    void systemStatusBarAvailableChanged(bool systemStatusBarAvailable);
    void systemStatusBarSizeChanged(const quint32 &systemStatusBarSize);

private:
    QColor m_systemStatusBarColor;
    quint32 m_systemStatusBarSize;
    bool m_systemStatusBarAvailable;

#ifdef Q_MOBILE_PLATFORM
public:
    bool uiReady() const;
    Q_INVOKABLE void setUiReady(const bool &uiReady);
#if defined (Q_OS_ANDROID)
    void doAndroidCheats();
    void setAndroidCheatsReady(const bool &androidCheatsReady);
    void androidCheatsFinish();
    QAndroidJniObject statusColorChanger();
    void setStatusColorChanger(const QAndroidJniObject &statusColorChanger);
#elif defined (Q_OS_IOS)
    void doIosCheats();
    void setIosCheatsReady(const bool &iosCheatsReady);
    void iosCheatsFinish();
#endif

    void systemCheats();
    void cheatsFinish();

private:
    bool m_uiReady;
#if defined (Q_OS_ANDROID)
    bool m_androidCheatsReady;
    QAndroidJniObject m_statusColorChanger;
#elif defined (Q_OS_IOS)
    bool m_iosCheatsReady;
#endif
#endif // Q_MOBILE_PLATFORM
};

#endif // MOBILEMANAGER_HPP
