#include "mobilemanager.hpp"


MobileManager::MobileManager(QObject *parent)
    : QObject(parent)
{
    // These two properties will reinitialize for Android and iOs
    m_systemStatusBarAvailable = false;
    m_systemStatusBarSize = 0;

#ifdef Q_MOBILE_PLATFORM
    m_systemStatusBarColor = QColor(0, 0, 0, 46); // #2e000000
    m_uiReady = false;
#if defined (Q_OS_ANDROID)
    m_androidCheatsReady = false;
#elif defined (Q_OS_IOS)
    m_iosCheatsReady = false;
#endif
#endif
}

QColor MobileManager::systemStatusBarColor() const
{
    return m_systemStatusBarColor;
}

bool MobileManager::systemStatusBarAvailable() const
{
    return m_systemStatusBarAvailable;
}

quint32 MobileManager::systemStatusBarSize() const
{
    return m_systemStatusBarSize;
}

void MobileManager::setSystemStatusBarColor(const QColor &systemStatusBarColor)
{
    if (m_systemStatusBarColor != systemStatusBarColor)
    {
        m_systemStatusBarColor = systemStatusBarColor;
        emit systemStatusBarColorChanged(m_systemStatusBarColor);

#if defined (Q_OS_ANDROID)
        // Here we need to check again if is Android or iOs
        MobileManager &currentManager = *this;
        QtAndroid::runOnAndroidThreadSync([&currentManager](){
            QAndroidJniObject activity = QtAndroid::androidActivity();
            if(QtAndroid::androidSdkVersion() >= 19 && QtAndroid::androidSdkVersion() < 21)
            {
                QAndroidJniObject view = currentManager.statusColorChanger();
                view.callMethod<void>("setBackgroundColor", "(I)V", currentManager.systemStatusBarColor().rgba());
            }
            else if(QtAndroid::androidSdkVersion() >= 21)
            {
                QAndroidJniObject window = currentManager.statusColorChanger();
                window.callMethod<void>("setStatusBarColor", "(I)V", currentManager.systemStatusBarColor().rgba());
            }
        });
#elif defined (Q_OS_IOS)
#endif
    }
}

void MobileManager::setSystemStatusBarAvailable(const bool &systemStatusBarAvailable)
{
    if (m_systemStatusBarAvailable != systemStatusBarAvailable)
    {
        m_systemStatusBarAvailable = systemStatusBarAvailable;
        emit systemStatusBarAvailableChanged(m_systemStatusBarAvailable);
    }
}

void MobileManager::setSystemStatusBarSize(const quint32 &systemStatusBarSize)
{
    if (m_systemStatusBarSize != systemStatusBarSize)
    {
        m_systemStatusBarSize = systemStatusBarSize;
        emit systemStatusBarSizeChanged(m_systemStatusBarSize);
    }
}

#ifdef Q_MOBILE_PLATFORM
bool MobileManager::uiReady() const
{
    return m_uiReady;
}

void MobileManager::setUiReady(const bool &uiReady)
{
    if (m_uiReady != uiReady)
    {
        m_uiReady = uiReady;

        // Check if cheats are ready too
#if defined (Q_OS_ANDROID)
        if(m_uiReady && m_androidCheatsReady)
#elif defined (Q_OS_IOS)
        if(m_uiReady && m_iosCheatsReady)
#endif
        {
            cheatsFinish();
        }
    }
}

#if defined (Q_OS_ANDROID)
void MobileManager::doAndroidCheats()
{
    if(QtAndroid::androidSdkVersion() >= 19)
    {
        MobileManager &currentManager = *this;
        QtAndroid::runOnAndroidThreadSync([&currentManager]() {
            QAndroidJniObject activity = QtAndroid::androidActivity();
            QAndroidJniObject resources = activity.callObjectMethod("getResources", "()Landroid/content/res/Resources;");
            QAndroidJniObject window = activity.callObjectMethod("getWindow", "()Landroid/view/Window;");
            jint statusBarHeight = 0;
            quint32 statusBarHeightForQt = 0;
            jint statusBarHeightId = resources.callMethod<jint>("getIdentifier",
                                                                "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I",
                                                                QAndroidJniObject::fromString("status_bar_height").object<jstring>(),
                                                                QAndroidJniObject::fromString("dimen").object<jstring>(),
                                                                QAndroidJniObject::fromString("android").object<jstring>());
            if(statusBarHeightId > 0) {
                statusBarHeight = resources.callMethod<jint>("getDimensionPixelSize", "(I)I", statusBarHeightId);
                jint DENSITY_DEFAULT = QAndroidJniObject::getStaticField<jint>("android/util/DisplayMetrics", "DENSITY_DEFAULT");
                QAndroidJniObject displayMetrics = resources.callObjectMethod("getDisplayMetrics", "()Landroid/util/DisplayMetrics;");
                jint densityDpi = displayMetrics.getField<jint>("densityDpi");
                statusBarHeightForQt = static_cast<quint32>(statusBarHeight / (static_cast<float>(densityDpi) / DENSITY_DEFAULT));
            }

            if(QtAndroid::androidSdkVersion() >= 19 && QtAndroid::androidSdkVersion() < 21)
            {

                jint FLAG_TRANSLUCENT_STATUS = QAndroidJniObject::getStaticField<jint>("android/view/WindowManager$LayoutParams",
                                                                                       "FLAG_TRANSLUCENT_STATUS");
                window.callMethod<void>("setFlags", "(II)V",
                                        FLAG_TRANSLUCENT_STATUS, FLAG_TRANSLUCENT_STATUS);

                QAndroidJniObject view("android/view/View", "(Landroid/content/Context;)V", activity.object<jobject>());
                jint MATCH_PARENT = QAndroidJniObject::getStaticField<jint>("android/view/ViewGroup$LayoutParams",
                                                                                       "MATCH_PARENT");
                jint WRAP_CONTENT = QAndroidJniObject::getStaticField<jint>("android/view/ViewGroup$LayoutParams",
                                                                                       "WRAP_CONTENT");
                QAndroidJniObject layoutParam("android/widget/FrameLayout$LayoutParams",
                                              "(II)V", MATCH_PARENT, WRAP_CONTENT);
                layoutParam.setField<jint>("height", statusBarHeight);
                view.callMethod<void>("setLayoutParams", "(Landroid/view/ViewGroup$LayoutParams;)V", layoutParam.object<jobject>());
                view.callMethod<void>("setBackgroundColor", "(I)V", currentManager.systemStatusBarColor().rgba());
                QAndroidJniObject decorView = window.callObjectMethod("getDecorView", "()Landroid/view/View;");
                decorView.callMethod<void>("addView", "(Landroid/view/View;)V", view.object<jobject>());
                currentManager.setStatusColorChanger(view);
            }
            else if(QtAndroid::androidSdkVersion() >= 21)
            {
                jint flags = QAndroidJniObject::getStaticField<jint>("android/view/View", "SYSTEM_UI_FLAG_LAYOUT_STABLE")
                        | QAndroidJniObject::getStaticField<jint>("android/view/View", "SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN");
                QAndroidJniObject decorView = window.callObjectMethod("getDecorView", "()Landroid/view/View;");
                decorView.callMethod<void>("setSystemUiVisibility", "(I)V", flags);

                jint FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS = QAndroidJniObject::getStaticField<jint>("android/view/WindowManager$LayoutParams",
                                                                                                 "FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS");
                jint FLAG_TRANSLUCENT_STATUS = QAndroidJniObject::getStaticField<jint>("android/view/WindowManager$LayoutParams",
                                                                                       "FLAG_TRANSLUCENT_STATUS");
                window.callMethod<void>("addFlags", "(I)V", FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
                window.callMethod<void>("clearFlags", "(I)V", FLAG_TRANSLUCENT_STATUS);
                window.callMethod<void>("setStatusBarColor", "(I)V", currentManager.systemStatusBarColor().rgba());
                currentManager.setStatusColorChanger(window);
            }

            currentManager.setSystemStatusBarAvailable(true);
            currentManager.setSystemStatusBarSize(static_cast<quint32>(statusBarHeightForQt));

            currentManager.setAndroidCheatsReady(true);
        });
    }
    else
    {
        setAndroidCheatsReady(true);
    }
}

void MobileManager::setAndroidCheatsReady(const bool &androidCheatsReady)
{
    if (m_androidCheatsReady != androidCheatsReady)
    {
        m_androidCheatsReady = androidCheatsReady;

        // Check if ui is ready too
        if(m_uiReady && m_androidCheatsReady)
        {
            cheatsFinish();
        }
    }
}

void MobileManager::androidCheatsFinish()
{
    QtAndroid::hideSplashScreen(250);
}

QAndroidJniObject MobileManager::statusColorChanger()
{
    return m_statusColorChanger;
}

void MobileManager::setStatusColorChanger(const QAndroidJniObject &statusColorChanger)
{
    m_statusColorChanger = statusColorChanger;
}

#elif defined (Q_OS_IOS)
void MobileManager::doIosCheats()
{

}

void MobileManager::setIosCheatsReady(const bool &iosCheatsReady)
{
    if (m_iosCheatsReady != iosCheatsReady)
    {
        m_iosCheatsReady = iosCheatsReady;

        // Check if ui is ready too
        if(m_uiReady && m_iosCheatsReady)
        {
            cheatsReady();
        }
    }
}

void MobileManager::iosCheatsFinish()
{

}
#endif

void MobileManager::systemCheats()
{
#if defined (Q_OS_ANDROID)
    doAndroidCheats();
#elif defined (Q_OS_IOS)
    doIosCheats();
#endif
}

void MobileManager::cheatsFinish()
{
#if defined (Q_OS_ANDROID)
    androidCheatsFinish();
#elif defined (Q_OS_IOS)
    iosCheatsFinish();
#endif
}

#endif // Q_MOBILE_PLATFORM
