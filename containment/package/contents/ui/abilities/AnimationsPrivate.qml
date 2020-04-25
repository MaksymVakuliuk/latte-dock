/*
*  Copyright 2020 Michail Vourlakos <mvourlakos@gmail.com>
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
import org.kde.plasma.plasmoid 2.0

import org.kde.latte.core 0.2 as LatteCore
import org.kde.latte.private.app 0.1 as LatteApp

import org.kde.latte.abilities.definitions 0.1 as AbilityDefinition

AbilityDefinition.Animations {
    property Item container: null
    property Item settings: null

    property Item publicApi: null

    //DEPRECATED
    //C1 property bool animationsEnabled:  -> active
    //C11 property int animationsNeedBothAxis:0 //animations need space in both axes, e.g zooming a task
    //C12 property int animationsNeedLength: 0 // animations need length, e.g. adding a task
    //C13 property int animationsNeedThickness: 0 // animations need thickness, e.g. bouncing animation

    //C8 function slotAnimationsNeedBothAxis(step) {  -> events
    //C9 function slotAnimationsNeedLength(step) {  -> event
    //C10 function slotAnimationsNeedThickness(step) {  -> events

    //C2 property bool thickAnimated: -> hasThicknessAnimation
    //C5 property int appliedDurationTime: -> speedFactor.normal
    //C7 property int durationTime -> speedFactor.current
    //C6 property int animationTime -> duration.proposed

    //C20 root.shortDuration -> animations.duration.small
    //C21 root.longDuration -> animations.duration.large

    //parabolic
    //C3 property int animationStep -> hoverPixelSensitivity
    //C4 property int animationsZoomFactor -> minZoomFactor


    //! animations properties
    active: plasmoid.configuration.animationsEnabled && LatteCore.WindowSystem.compositingActive
    hasThicknessAnimation:  (needBothAxis.count>0) || (needThickness.count>0)

    duration.large: LatteCore.Environment.longDuration
    duration.proposed: speedFactor.current * 2.8 * duration.large
    duration.small: LatteCore.Environment.shortDuration

    speedFactor.normal: 1.0
    speedFactor.current: {
        if (!active || plasmoid.configuration.durationTime === 0) {
            return 0;
        }

        if (plasmoid.configuration.durationTime === 1 ) {
            return 0.75;
        } else if (plasmoid.configuration.durationTime === 2) {
            return speedFactor.normal;
        } else if (plasmoid.configuration.durationTime === 3) {
            return 1.15;
        }

        return speedFactor.normal;
    }

    //! animations related to parabolic effect
    hoverPixelSensitivity: {
        if (!settings || settings.sensitivity === LatteApp.Settings.HighMouseSensitivity) {
            return 1;
        } else if (settings.sensitivity === LatteApp.Settings.MediumMouseSensitivity) {
            return Math.max(3, container.iconSize / 18);
        } else if (settings.sensitivity === LatteApp.Settings.LowMouseSensitivity) {
            return Math.max(5, container.iconSize / 10);
        }
    }

    minZoomFactor : {
        if (!active || !LatteCore.WindowSystem.compositingActive) {
            return 1;
        }

        /* if (latteApplet && (animationLauncherBouncing || animationWindowInAttention || animationWindowAddedInGroup)) {
            return 1.65;
        }*/

        return 1;
    }
}
