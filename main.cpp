#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>

#include "qiniuaccess.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QiniuAccess gallery;
    engine.rootContext()->setContextProperty("gallery", &gallery);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

