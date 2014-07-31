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

#ifndef RULECOMPONENTMODEL_H
#define RULECOMPONENTMODEL_H

#include <QtCore/QAbstractListModel>

class RuleComponentModelPrivate;
class RuleComponentModel: public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString type READ type CONSTANT)
    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(QString description READ description CONSTANT)
    Q_PROPERTY(int count READ count NOTIFY countChanged)
public:
    enum Role {
        Type,
        Value
    };
    explicit RuleComponentModel(QObject *parent = 0);
    virtual ~RuleComponentModel();
    QHash<int, QByteArray> roleNames() const;
    QString type() const;
    QString name() const;
    QString description() const;
    int count() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    static RuleComponentModel * create(const QString &type, QObject *parent = 0);
    static RuleComponentModel * clone(RuleComponentModel *other, QObject *parent = 0);
Q_SIGNALS:
    void countChanged();
public Q_SLOTS:
    void setValue(int row, const QVariant &value);
protected:
    explicit RuleComponentModel(RuleComponentModelPrivate &dd, QObject *parent = 0);
    const QScopedPointer<RuleComponentModelPrivate> d_ptr;
private:
    Q_DECLARE_PRIVATE(RuleComponentModel)
};


#endif // RULECOMPONENTMODEL_H
