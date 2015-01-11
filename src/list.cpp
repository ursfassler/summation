#include "list.h"

List::List(QObject *parent) :
    QAbstractListModel(parent)
{
}

QHash<int, QByteArray> List::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[RoleName] = "name";
    roles[RoleValue] = "value";
    return roles;
}

int List::rowCount(const QModelIndex &parent) const
{
    return 15;
}

QVariant List::data(const QModelIndex &index, int role) const
{
    switch (role) {
    case RoleName:
        return "Hi";
    case RoleValue:
        return 42;
    default:
        break;
    }

    return QVariant();
}

QVariant List::headerData(int section, Qt::Orientation orientation, int role) const
{
    return "1";
}
