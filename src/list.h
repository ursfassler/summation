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
    Q_SCRIPTABLE void remove(int index);

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
