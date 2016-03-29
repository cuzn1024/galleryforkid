#include "qiniuaccess.h"

#include <QFile>
#include <QEventLoop>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QNetworkAccessManager>

#include "qiniu/main/base.h"
#include "qiniu/main/io.h"
#include "qiniu/main/rs.h"

QiniuAccess::QiniuAccess(QObject *parent) : QObject(parent)
{
    client = (Qiniu_Client*)malloc(sizeof(Qiniu_Client));

    mac = (Qiniu_Mac*)malloc(sizeof(Qiniu_Mac));

    mac->accessKey = "bhZYeMO4EF05XHAzAic5VZDGtMGzB-hNi4vbhxQU";
    mac->secretKey = "BQvDlL2mdOMilkB-JIGU3a_ULYBoHw1xAR-Qw0m2";

    Qiniu_Global_Init(-1);
    Qiniu_Client_InitMacAuth(client, 1024, mac);
}

QiniuAccess::~QiniuAccess()
{
    Qiniu_Client_Cleanup(client);
    Qiniu_Servend_Cleanup();

    free(client);
    free(mac);

    client = 0;
    mac = 0;
}

char* uptoken(const char* bucket, Qiniu_Mac* mac)
{
    Qiniu_RS_PutPolicy putPolicy;
    Qiniu_Zero(putPolicy);
    putPolicy.scope = bucket;
    return Qiniu_RS_PutPolicy_Token(&putPolicy, mac);
}

void debug(Qiniu_Client* client, Qiniu_Error &err)
{
    printf("\nerror code: %d, message: %s\n", err.code, err.message);
    printf("respose header:\n%s\n", Qiniu_Buffer_CStr(&client->respHeader));
    printf("respose body:\n%s\n", Qiniu_Buffer_CStr(&client->b));
}

void QiniuAccess::createGallery(const QString &userName, const QString &password)
{
    printf("createGallery\n");
    Qiniu_RS_StatRet ret;
    Qiniu_Error err = Qiniu_RS_Stat(client, &ret, "cuzn", "cuzn.dir");
    if (err.code == 200) {

        downloadDir();
        return;
    }

    if (strcmp(err.message, "no such bucket") == 0)
    {
        printf("no such bucket\n");
        return;
    }

    if (strcmp(err.message, "no such file or directory") == 0)
    {
        uploadDir();
        return;
    }

    debug(client, err);
}

void QiniuAccess::uploadDir()
{
    char *token = uptoken("cuzn", mac);

    QFile file("cuzn.dir");
    file.open(QIODevice::WriteOnly);
    file.flush();
    file.close();

    Qiniu_Error err;
    err = Qiniu_Io_PutFile(client, NULL, token, "cuzn.dir", "cuzn.dir", NULL);

    free(token);

    debug(client, err);
}

void QiniuAccess::downloadDir()
{
    qDebug()<<"downloadDir";
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);

    QEventLoop eventLoop;

    QNetworkReply *reply = manager->get(QNetworkRequest(QUrl("http://7xksjc.com1.z0.glb.clouddn.com/cuzn.dir")));
    connect(reply, SIGNAL(readyRead()), &eventLoop, SLOT(quit()));

    eventLoop.exec();
    qDebug()<<reply->readAll();
}

void QiniuAccess::preloadGallery()
{
}

void QiniuAccess::downloadGallery()
{

}
