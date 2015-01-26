/**
 *  This file is part of Summation.
 *
 *  Summation is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Summation is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Summation.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "list.h"

#include <QFile>
#include <QDir>
#include <QDomDocument>
#include <QDebug>

List::List(const QString &filename, QObject *parent) :
    QAbstractListModel(parent),
    mFilename(filename)
{
    connect(this, SIGNAL(dataChanged(QModelIndex,QModelIndex)), this, SLOT(saveFile()));
    connect(this, SIGNAL(valueChanged()), this, SLOT(saveFile()));
}

QHash<int, QByteArray> List::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[RoleName] = "name";
    roles[RoleValue] = "value";
    return roles;
}

int List::rowCount(const QModelIndex &) const
{
    qDebug() << "mData.count() = " << mData.count();
    return mData.count();
}

QVariant List::data(const QModelIndex &index, int role) const
{
    qDebug() << "data of " << index.row();
    switch (role) {
    case RoleName:
        return mData[index.row()].first;
    case RoleValue:
        return mData[index.row()].second;
    default:
        break;
    }

    return QVariant();
}

QVariant List::headerData(int, Qt::Orientation, int role) const
{
    return roleNames()[role];
}

bool List::setData(const QModelIndex &index, const QVariant &value, int role)
{
    qDebug() << "setData " << mData.count() << " " << index.row() << " " << role << " " << value;
    switch (role) {
    case RoleName: {
        mData[index.row()].first = value.toString();
        dataChanged(index, index);
        return true;
    }
    case RoleValue: {
            bool ok = false;
            qreal rval = value.toReal(&ok);
            if(ok){
                mData[index.row()].second = rval;
                dataChanged(index, index);
                valueChanged();
            }
            return ok;
    }
    default: {
        return false;
    }
    }
}

Qt::ItemFlags List::flags(const QModelIndex &) const
{
    return Qt::ItemIsSelectable | Qt::ItemIsEditable | Qt::ItemIsEnabled;
}

void List::add(const QString &name, qreal value)
{
    beginInsertRows(QModelIndex(), 0, 0);
    mData.insert(0, Entry(name, value));
    endInsertRows();
    valueChanged();
}

void List::remove(int index)
{
    beginRemoveRows(QModelIndex(), index, index);
    mData.removeAt(index);
    endRemoveRows();
    valueChanged();
}

qreal List::value() const
{
    qreal sum = 0;
    for( const Entry &itr : mData ){
        sum += itr.second;
    }
    return sum;
}



bool List::loadFile()
{
    qDebug() << "load file " << mFilename;

    QFile file(mFilename);
    if (!file.open(QIODevice::ReadOnly)){
        qDebug() << "could not open file: " << file.errorString();
        return false;
    }

    QDomDocument doc;

    if (!doc.setContent(&file)) {
        qDebug() << "could not parse file";
        file.close();
        return false;
    }
    file.close();

    QDomElement docElem = doc.documentElement();

    if( docElem.nodeName() != "summation" )
    {
        qDebug() << "wrong type of content";
        return false;
    }

    beginRemoveRows(QModelIndex(), 0, mData.count()-1);
    mData.clear();
    endRemoveRows();

    QDomNodeList items = docElem.elementsByTagName("item");

    for(int i = 0; i < items.count(); i++){
        QDomElement e = items.item(i).toElement();
        if(e.isNull()) {
            qWarning() << "expected element, got " << (int)e.nodeType() << " for " << e.nodeName();
            continue;
        }
        if(!e.hasAttribute("name") || !e.hasAttribute("value")){
            qWarning() << "missing attribute name or value for " << e.nodeName();
            continue;
        }
        bool ok;
        qreal value = e.attribute("value").toFloat(&ok);
        if(!ok){
            qWarning() << "could not convert value (" << e.attribute("value") << ") to real for " << e.nodeName();
            continue;
        }

        mData.append(Entry(e.attribute("name"), value));
    }

    beginInsertRows(QModelIndex(), 0, mData.count()-1);
    endInsertRows();

    valueChanged();

    return true;
}

bool List::saveFile()
{
    qDebug() << "save file";

    QDomDocument doc;

    QDomElement root = doc.createElement("summation");
    doc.appendChild(root);
    for( const Entry &entry : mData ){
        QDomElement item = doc.createElement("item");
        item.setAttribute("name", entry.first);
        item.setAttribute("value", QString("%1").arg(entry.second));
        root.appendChild(item);
    }

    QFile file(mFilename);
    if (!file.open(QIODevice::WriteOnly)){
        qDebug() << "could not open file: " << file.errorString();
        return false;
    }

    return file.write(doc.toByteArray());
}

