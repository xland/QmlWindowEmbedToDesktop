#pragma once
#include <Windows.h> 
#include <QObject>
#include <qquickwindow.h>
class EmbedHelper : public QObject
{
	Q_OBJECT
public:
	explicit EmbedHelper(QObject* parent = nullptr) : QObject(parent) {}
	~EmbedHelper();
	static EmbedHelper* Init(QObject* _root);
	Q_INVOKABLE void Embed();
	Q_INVOKABLE void UnEmbed();
	Q_INVOKABLE void WinResized();
private:

};