#ifndef LIST_H
#define LIST_H

#include <QAbstractListModel>
#include <QList>
#include <QPair>

class List: public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(qreal value READ value NOTIFY valueChanged)
public:
    enum {
        RoleName = Qt::UserRole,
        RoleValue
    };

    explicit List(const QString &filename, QObject *parent = 0);

    QHash<int, QByteArray> roleNames () const;

    int rowCount ( const QModelIndex & parent = QModelIndex() ) const;
    QVariant data ( const QModelIndex & index, int role = Qt::DisplayRole ) const;
    QVariant headerData ( int section, Qt::Orientation orientation, int role = Qt::DisplayRole ) const;

    bool setData ( const QModelIndex & index, const QVariant & value, int role = Qt::EditRole );
    Qt::ItemFlags flags ( const QModelIndex & index ) const;

    Q_SCRIPTABLE void add(const QString &name, qreal value);

    qreal value() const;

signals:
    void valueChanged();

public slots:
    Q_SCRIPTABLE bool loadFile();
    Q_SCRIPTABLE bool saveFile();

private:
    typedef QPair<QString,qreal> Entry;
    QList<Entry>    mData;
    QString         mFilename;
};


#endif // LIST_H
