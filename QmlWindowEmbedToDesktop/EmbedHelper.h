#pragma once
#include <Windows.h> 
#include <QObject>
class EmbedHelper : public QObject
{
	Q_OBJECT
public:
	explicit EmbedHelper(QObject* parent = nullptr) : QObject(parent) {}
	~EmbedHelper();
	void SetHwnd(HWND tarHwnd);
	Q_INVOKABLE void Embed();
	Q_INVOKABLE void UnEmbed();
private:

};