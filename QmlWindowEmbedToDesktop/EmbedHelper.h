#pragma once
#include <Windows.h> 
class EmbedHelper
{
public:
	~EmbedHelper();
	static void Embed(HWND tarHwnd);
private:
	EmbedHelper();

};