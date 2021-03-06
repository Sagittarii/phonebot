#include "abstractmetadata.h"
#include <QtCore/QMap>

struct AbstractMetaDataPrivate
{
    QMap<QString, MetaProperty *> metaProperties;
};

AbstractMetaData::AbstractMetaData(QObject *parent)
    : QObject(parent), d_ptr(new AbstractMetaDataPrivate)
{
}

AbstractMetaData::~AbstractMetaData()
{
}

MetaProperty * AbstractMetaData::property(const QString &property) const
{
    Q_D(const AbstractMetaData);
    if (!d->metaProperties.contains(property)) {
        MetaProperty *meta = getProperty(property, const_cast<AbstractMetaData *>(this));
        Q_ASSERT(meta->parent() == this);
        AbstractMetaDataPrivate *dd = const_cast<AbstractMetaDataPrivate *>(d);
        dd->metaProperties.insert(property, meta);
        return meta;
    }

    return d->metaProperties[property];
}
