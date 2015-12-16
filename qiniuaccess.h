#ifndef QINIUACCESS_H
#define QINIUACCESS_H

#include <QObject>

struct _Qiniu_Mac;
struct _Qiniu_Client;

class QiniuAccess : public QObject
{
    Q_OBJECT
public:
    explicit QiniuAccess(QObject *parent = 0);
    ~QiniuAccess();

signals:

public slots:
    void createGallery(const QString &userName, const QString &password);
    void preloadGallery();
    void downloadGallery();
    void uploadDir();
    void downloadDir();

private:
    _Qiniu_Client *client;
    _Qiniu_Mac *mac;
};

#endif // QINIUACCESS_H
