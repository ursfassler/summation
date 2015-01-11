#ifndef LIST_H
#define LIST_H

#include <QAbstractListModel>

class List : public QAbstractListModel
{
    Q_OBJECT
public:
    enum {
        RoleName = Qt::UserRole,
        RoleValue
    };

    explicit List(QObject *parent = 0);

    QHash<int, QByteArray> roleNames () const;

    int rowCount ( const QModelIndex & parent = QModelIndex() ) const;
    QVariant data ( const QModelIndex & index, int role = Qt::DisplayRole ) const;
    QVariant headerData ( int section, Qt::Orientation orientation, int role = Qt::DisplayRole ) const;

signals:

public slots:

};

#endif // LIST_H
