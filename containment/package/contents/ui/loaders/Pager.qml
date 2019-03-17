/*
*  Copyright 2018  Michail Vourlakos <mvourlakos@gmail.com>
*
*  This file is part of Latte-Dock
*
*  Latte-Dock is free software; you can redistribute it and/or
*  modify it under the terms of the GNU General Public License as
*  published by the Free Software Foundation; either version 2 of
*  the License, or (at your option) any later version.
*
*  Latte-Dock is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.7

import org.kde.plasma.private.pager 2.0

import org.kde.latte 0.2 as Latte

Loader {
    id: pagerLoader
    active: root.scrollAction === Latte.Types.ScrollDesktops || root.scrollAction === Latte.Types.ScrollActivities
    sourceComponent: Item{
        readonly property int count: repeater.count
        readonly property QtObject model: pagerModel

        PagerModel {
            id: pagerModel
            enabled: true
            showDesktop: true
            showOnlyCurrentScreen: true
            screenGeometry: latteView.screenGeometry
            pagerType: root.scrollAction === Latte.Types.ScrollDesktops ? PagerModel.VirtualDesktops : PagerModel.Activities
        }

        Repeater{
            id: repeater
            model: pagerModel

            Item{}
        }
    }
}