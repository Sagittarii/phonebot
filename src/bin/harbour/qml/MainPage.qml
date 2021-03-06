/*
 * Copyright (C) 2014 Lucien XU <sfietkonstantin@free.fr>
 *
 * You may use this file under the terms of the BSD license as follows:
 *
 * "Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *   * The names of its contributors may not be used to endorse or promote
 *     products derived from this software without specific prior written
 *     permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.phonebot 1.0

Page {
    id: container
    property bool actionsEnabled: false

    function addNew() {
        var rule = rulesModel.createRule()
        window.activate()
        pageStack.push(Qt.resolvedUrl("RuleDialog.qml"),
                       {model: rulesModel, index: rulesModel.count, rule: rule})
    }

    RulesModel {
        id: rulesModel
    }

    Component {
        id: cover
        CoverPage {
            onAddNew: container.addNew()
            rulesCount: rulesModel.count
            actionsEnabled: container.actionsEnabled
        }
    }

    onStatusChanged: {
        if (status == PageStatus.Activating) {
            container.actionsEnabled = true
        } else if (status == PageStatus.Deactivating) {
            container.actionsEnabled = false
        }
    }

    Component.onCompleted: window.cover = cover

    SilicaListView {
        anchors.fill: parent
        model: rulesModel

        header: Column {
            width: parent.width

            PageHeader {
                title: "Phonebot"
            }
        }

        delegate: RuleButton {
            id: rule
            wrap: true
            function removeRule() {
                rulesModel.removeRule(model.index)
            }
            function formatRuleSecondary() {
                if (!model.rule.trigger || model.rule.actions.count == 0) {
                    return ""
                }

                var text = model.rule.trigger.summary + "\n"
                if (model.rule.condition) {
                    text += model.rule.condition.summary + "\n"
                }

                for (var i = 0; i < model.rule.actions.count; i++) {
                    text += model.rule.actions.getComponent(i).summary + "\n"
                }
                text = text.trim()

                return text
            }

            text: model.name == "" ? qsTr("Noname rule %1").arg(model.index + 1) : model.name
            secondaryText: formatRuleSecondary()
            onClicked: {
                if (model.valid) {
                    var rule = rulesModel.createClonedRule(model.rule)
                    pageStack.push(Qt.resolvedUrl("RuleDialog.qml"),
                                   {model: rulesModel, index: model.index, rule: rule, add: false})
                } else {
                    // TODO: display a page full of code ?
                }
            }
            onPressAndHold: {
                rule.showMenu()
            }
            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Remove rule")
                    onClicked: rule.remorseAction(qsTr("Removing rule"), removeRule)
                }
            }
        }

        PullDownMenu {
            MenuItem {
                text: "Add rule"
                onClicked: container.addNew()
            }
        }

        ViewPlaceholder {
            text: qsTr("No rule configured")
            hintText: qsTr("Add a rule using the pulley menu")
            enabled: rulesModel.count == 0
        }

        VerticalScrollDecorator {}
    }
}
