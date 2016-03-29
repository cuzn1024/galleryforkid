TEMPLATE = app

QT += quick network
CONFIG += c++11

SOURCES += main.cpp \
           qiniu/main/base_io.c \
           qiniu/main/io.c \
           qiniu/main/http.c \
           qiniu/main/conf.c \
           qiniu/main/base.c \
           qiniu/main/auth_mac.c \
           qiniu/main/rs.c \
           qiniu/cJSON/cJSON.c \
           qiniu/b64/urlsafe_b64.c \
    qiniuaccess.cpp

RESOURCES += qml.qrc

INCLUDEPATH += /usr/local/ssl/include

LIBS+=-L/usr/lib/ -lcurl -lm -lcrypto

HEADERS += \
    qiniuaccess.h

