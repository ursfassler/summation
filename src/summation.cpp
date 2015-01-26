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

#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>
#include <QStandardPaths>
#include <QDir>
#include <QFile>

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>

int main(int argc, char *argv[])
{
    QGuiApplication *app = SailfishApp::application(argc, argv);
    app->setOrganizationName("ufas");
    QQuickView *view = SailfishApp::createView();

    QString data = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

    QDir dir(data);
    dir.mkpath(dir.absolutePath());
    QString file = dir.absoluteFilePath("data.sum");

    List list(file);
    list.loadFile();
    view->rootContext()->setContextProperty("list", &list);

    view->setSource( SailfishApp::pathTo( "qml/summation.qml" ));
    view->showFullScreen();

    return app->exec();
}

