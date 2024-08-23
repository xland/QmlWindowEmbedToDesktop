# QmlWindowEmbedToDesktop



case RI_MOUSE_RIGHT_BUTTON_DOWN:
{
    PostMessage(tarHwnd, WM_RBUTTONDOWN, MK_RBUTTON, lParam);
    break;
}
case RI_MOUSE_RIGHT_BUTTON_UP:
{
    PostMessage(tarHwnd, WM_RBUTTONUP, MK_RBUTTON, lParam);
    break;
}
case RI_MOUSE_MIDDLE_BUTTON_DOWN: {
    PostMessage(tarHwnd, WM_MBUTTONDOWN, MK_MBUTTON, lParam);
    break;
}
case RI_MOUSE_MIDDLE_BUTTON_UP: {
    PostMessage(tarHwnd, WM_MBUTTONUP, MK_MBUTTON, lParam);
    break;
}
case RI_MOUSE_BUTTON_4_DOWN:{
    PostMessage(tarHwnd, WM_XBUTTONDOWN, MAKEWPARAM(0, XBUTTON1), lParam);
    break;
}
case RI_MOUSE_BUTTON_4_UP: {
    PostMessage(tarHwnd, WM_XBUTTONUP, MAKEWPARAM(0, XBUTTON1), lParam);
    break;
}
case RI_MOUSE_BUTTON_5_DOWN: {
    PostMessage(tarHwnd, WM_XBUTTONDOWN, MAKEWPARAM(0, XBUTTON2), lParam);
    break;
}
case RI_MOUSE_BUTTON_5_UP: {
    PostMessage(tarHwnd, WM_XBUTTONUP, MAKEWPARAM(0, XBUTTON2), lParam);
    break;
}




case RIM_TYPEKEYBOARD:
{
    auto message = raw->data.keyboard.Message;
    auto vKey = raw->data.keyboard.VKey;
    auto makeCode = raw->data.keyboard.MakeCode;
    auto flags = raw->data.keyboard.Flags;
    std::uint32_t lParam = 1u;
    lParam |= static_cast<std::uint32_t>(makeCode) << 16;
    lParam |= 1u << 24;
    lParam |= 0u << 29;
    if (!(flags & RI_KEY_BREAK)) {
        lParam |= 1u << 30;
        lParam |= 1u << 31;
    }
    PostMessage(tarHwnd, message, vKey, lParam);
    break;
}